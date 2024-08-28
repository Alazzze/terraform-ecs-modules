provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security_group" {
  source  = "./modules/security_group"
  vpc_id  = module.vpc.vpc_id
}

module "load_balancer" {
  source            = "./modules/load_balancer"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = [module.vpc.subnet_ids.subnet1, module.vpc.subnet_ids.subnet2]
  security_group_id = module.security_group.security_group_id
}

module "iam" {
  source = "./modules/iam"
}

resource "aws_launch_template" "ecs_launch_template" {
  name_prefix   = "stasec2"
  image_id      = "ami-0ae421f328ecb3a1e" # Amazon Linux 2 
  instance_type = "t3.medium"
  iam_instance_profile {
    name = module.iam.instance_profile_name
  }
  key_name = "alazze"
  
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [module.security_group.security_group_id]
  }

  user_data = base64encode(<<EOF
#!/bin/bash
cat << EOF | sudo tee /etc/ecs/ecs.config
ECS_CLUSTER=stasECStask
EOF
  )
}

resource "aws_autoscaling_group" "ecs_asg" {
  desired_capacity     = 1
  max_size             = 2
  min_size             = 1
  launch_template {
    id      = aws_launch_template.ecs_launch_template.id
    version = "$Latest"
  }
  vpc_zone_identifier = [module.vpc.subnet_ids.subnet1, module.vpc.subnet_ids.subnet2]

  tag {
    key                 = "Name"
    value               = "ecs-instance"
    propagate_at_launch = true
  }

  target_group_arns = [module.load_balancer.target_group_arn]

  health_check_type          = "EC2"
  health_check_grace_period = 300
}

resource "aws_ecs_cluster" "stas_ecs_cluster" {
  name = "stasECStask"
}

resource "aws_ecs_task_definition" "nginx_task" {
  family                = "nginx-task"
  network_mode          = "bridge"
  container_definitions = jsonencode([{
    name      = "nginx"
    image     = "nginx:latest"
    memory    = 512
    cpu       = 256
    essential = true
    portMappings = [
      {
        containerPort = 80
        hostPort      = 0
      }
    ]
  }])

  execution_role_arn = module.iam.task_execution_role_arn
  task_role_arn      = module.iam.task_execution_role_arn
}

resource "aws_ecs_service" "nginx_service" {
  name            = "nginx-service"
  cluster         = aws_ecs_cluster.stas_ecs_cluster.id
  task_definition = aws_ecs_task_definition.nginx_task.arn
  desired_count   = 3
  launch_type     = "EC2"
  deployment_controller {
    type = "ECS"
  }

  load_balancer {
    target_group_arn = module.load_balancer.target_group_arn
    container_name   = "nginx"
    container_port   = 80
  }

  depends_on = [
    module.load_balancer.load_balancer_arn
  ]
}

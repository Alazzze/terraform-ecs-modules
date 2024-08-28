resource "aws_lb" "stas_load_balancer" {
  name                        = "stas-load-balancer"
  internal                    = false
  load_balancer_type          = "application"
  security_groups             = [var.security_group_id]
  subnets                     = var.subnet_ids
  enable_deletion_protection  = false
  enable_cross_zone_load_balancing = true
  idle_timeout                = 60
  drop_invalid_header_fields  = true

  tags = {
    Name = "stas-load-balancer"
  }
}

resource "aws_lb_target_group" "nginx_target_group" {
  name       = "nginx-target-group"
  port       = 80
  protocol   = "HTTP"
  vpc_id     = var.vpc_id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "nginx-target-group"
  }
}

resource "aws_lb_listener" "nginx_listener" {
  load_balancer_arn = aws_lb.stas_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx_target_group.arn
  }
}


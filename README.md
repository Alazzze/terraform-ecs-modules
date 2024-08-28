Terraform ECS Modules
This repository contains Terraform modules for setting up AWS infrastructure, including VPC, IAM roles, ECS clusters, and Load Balancers

Repository Structure

terraform-ecs-modules/
├── modules/
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── README.md
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── README.md
│   ├── load_balancer/
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── README.md
│   └── iam/
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── README.md
├── main.tf
├── outputs.tf
└── variables.tf
Modules
VPC Module
Creates a Virtual Private Cloud (VPC) with subnets, an internet gateway, and route tables.

Inputs:

cidr_block (string): The CIDR block for the VPC.
availability_zones (list(string)): List of availability zones for the subnets.
Outputs:

vpc_id: The ID of the VPC.
subnet_ids: List of subnet IDs.
Security Group Module
Sets up a security group with inbound and outbound rules.

Inputs:

vpc_id (string): The ID of the VPC where the security group will be created.
Outputs:

security_group_id: The ID of the security group.
Load Balancer Module
Creates an Application Load Balancer with a listener and target group.

Inputs:

vpc_id (string): The ID of the VPC.
subnet_ids (list(string)): List of subnet IDs where the load balancer will be placed.
security_group_id (string): The security group ID to associate with the load balancer.
Outputs:

load_balancer_arn: The ARN of the load balancer.
target_group_arn: The ARN of the target group.
IAM Module
Creates IAM roles and policies for ECS tasks and instances.

Outputs:

task_execution_role_arn: The ARN of the ECS task execution role.
instance_role_arn: The ARN of the ECS instance role.
instance_profile_name: The name of the IAM instance profile.
Usage
To use these modules, include them in your Terraform configuration and provide the necessary inputs. Example usage:


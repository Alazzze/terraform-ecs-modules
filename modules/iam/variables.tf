variable "execution_role_name" {
  description = "Name of the ECS task execution role"
  default     = "ecsTaskExecutionRole"
}

variable "instance_role_name" {
  description = "Name of the ECS instance role"
  default     = "ecsInstanceRole"
}

variable "instance_profile_name" {
  description = "Name of the ECS instance profile"
  default     = "ecsInstanceProfile"
}


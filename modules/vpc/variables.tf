variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "vpc_name" {
  description = "Name for the VPC"
  default     = "stas-vpc"
}

variable "subnet1_cidr" {
  description = "CIDR block for the first subnet"
  default     = "10.0.1.0/24"
}

variable "subnet1_az" {
  description = "Availability zone for the first subnet"
  default     = "us-east-1a"
}

variable "subnet1_name" {
  description = "Name for the first subnet"
  default     = "stas-subnet1"
}

variable "subnet2_cidr" {
  description = "CIDR block for the second subnet"
  default     = "10.0.2.0/24"
}

variable "subnet2_az" {
  description = "Availability zone for the second subnet"
  default     = "us-east-1b"
}

variable "subnet2_name" {
  description = "Name for the second subnet"
  default     = "stas-subnet2"
}

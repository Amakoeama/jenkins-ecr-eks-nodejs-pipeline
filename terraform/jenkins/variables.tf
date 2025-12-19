variable "aws_region" {
  description = "AWS region where Jenkins will be deployed"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "EC2 instance type for Jenkins server"
  type        = string
  default     = "t3.small"
}

variable "key_pair_name" {
  description = "Existing EC2 key pair name for SSH access"
  type        = string
}

variable "allowed_ssh_cidr" {
  description = "CIDR block allowed to SSH into Jenkins"
  type        = string

}

variable "jenkins_http_port" {
  description = "Port Jenkins will listen on"
  type        = number
  default     = 8080
}

variable "project_name" {
  description = "Project name for tagging AWS resources"
  type        = string
  default     = "jenkins_ecr-eks-pipeline"
}
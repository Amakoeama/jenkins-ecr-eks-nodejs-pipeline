
#--- Jenkins Security group ---


resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins-sg"
  description = "Security group for Jenkins CI server"
  vpc_id      = data.aws_vpc.default.id

  # --- SSH ingress ---

  ingress {
    description = "SSH access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # --- Jenkins UI ingress ---

  ingress {
    description = "Jenkins web UI"
    from_port   = var.jenkins_http_port
    to_port     = var.jenkins_http_port
    protocol    = "tcp"
    cidr_blocks = [var.allowed_ssh_cidr]
  }

  # --- Outbound traffic ---

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name    = "jenkins-sg"
    Project = "jenkins-ecr-eks-pipeline"
  }
}

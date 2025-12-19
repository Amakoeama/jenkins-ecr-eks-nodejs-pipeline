
#--- Jenkins EC2 instance resource ---

resource "aws_instance" "jenkins" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = var.instance_type
  key_name      = var.key_pair_name

  subnet_id              = data.aws_subnet.default.id
  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  iam_instance_profile = aws_iam_instance_profile.jenkins_instance_profile.name

  user_data = file("${path.module}/user_data.sh")

  tags = {
    Name    = "jenkins-ci-server"
    Project = "jenkins-ecr-eks-pipeline"
  }
}



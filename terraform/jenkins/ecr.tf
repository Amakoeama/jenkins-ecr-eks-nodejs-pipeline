resource "aws_ecr_repository" "nodejs_app" {
  name = "nodejs-demo-app"

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = {
    Project = "jenkins-ecr-eks-pipeline"
  }
}

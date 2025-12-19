output "jenkins_instance_id" {
  description = "EC2 Instance ID for Jenkins"
  value       = aws_instance.jenkins.id
}

output "jenkins_public_ip" {
  description = "Public IP address of Jenkins server"
  value       = aws_instance.jenkins.public_ip
}

output "jenkins_public_dns" {
  description = "Public DNS of Jenkins server"
  value       = aws_instance.jenkins.public_dns
}

output "jenkins_url" {
  description = "Jenkins Web UI URL"
  value       = "http://${aws_instance.jenkins.public_dns}:8080"
}

output "ssh_command" {
  description = "SSH command to connect to Jenkins EC2"
  value       = "ssh -i ${var.key_pair_name}.pem ec2-user@${aws_instance.jenkins.public_dns}"
}


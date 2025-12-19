#!/bin/bash
set -euo pipefail

exec > >(tee /var/log/user-data.log | logger -t user-data ) 2>&1

echo "==== Waiting for yum to be ready ===="
until yum repolist >/dev/null 2>&1; do
  echo "Waiting for yum..."
  sleep 5
done

echo "==== Installing Amazon Corretto 17 ===="
rpm --import https://yum.corretto.aws/corretto.key
curl -L -o /etc/yum.repos.d/corretto.repo https://yum.corretto.aws/corretto.repo
yum install -y java-17-amazon-corretto

echo "==== Installing Jenkins ===="
wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key || true
yum install -y jenkins

echo "==== Configuring Jenkins Java ===="
echo 'JENKINS_JAVA_CMD="/usr/lib/jvm/java-17-amazon-corretto/bin/java"' >> /etc/sysconfig/jenkins

echo "==== Enabling and starting Jenkins ===="
systemctl enable jenkins
systemctl start jenkins

echo "==== Jenkins bootstrap completed successfully ===="

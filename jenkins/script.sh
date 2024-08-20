#!/bin/bash
 
echo "updating system package"
sudo yum update -y
 
echo "installing java"
sudo yum install java-17-amazon-corretto-devel -y
 
echo "adding jenkins repo and key"
sudo wget -O /etc/yum.repos.d/jenkins.repo https://pkg.jenkins.io/redhat-stable/jenkins.repo
sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io-2023.key
 
echo "Installing Jenkins"
yum install jenkins -y
 
echo "start jenkins"
sudo systemctl start jenkins
 
echo "enable jenkins"
sudo systemctl enable jenkins
 
echo "status jenkins"
sudo systemctl status jenkin
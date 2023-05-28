#!/bin/bash
sudo apt update
sudo apt install nginx -y


instanceId=$(curl http://169.254.169.254/latest/meta-data/instance-id)
region=$(curl http://169.254.169.254/latest/dynamic/instance-identity/document | grep region | awk -F\" '{print $4}')
echo "<h1> Hello, This is the Instance ID: $instanceId</h1>" > index.nginx-debian.html

sudo mv index.nginx-debian.html /var/www/html/index.nginx-debian.html

sudo systemctl enable nginx
sudo systemctl start nginx

mkdir /tmp/ssm
cd /tmp/ssm
wget https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/debian_amd64/amazon-ssm-agent.deb
sudo dpkg -i amazon-ssm-agent.deb
sudo systemctl enable amazon-ssm-agent
#! /bin/bash
sudo yum update
sudo yum install -y httpd
sudo chkconfig httpd on
sudo service httpd start
echo "<h1>This is my sample webpage from Terraform User Data Script</h1>" | sudo tee /var/www/html/index.html
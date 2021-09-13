#! /bin/bash
yum update -y
yum install httpd wget -y
service httpd start
chkconfig httpd on
cd /var/www/html
wget https://${url}/${file} || true
echo "<html><h1>Hello Devops</h1><img src="https://serge-bucket.s3.us-east-2.amazonaws.com/netology.jpg></html>" > index.html
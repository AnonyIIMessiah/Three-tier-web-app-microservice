#!/bin/bash
echo "Hello World ${var.name}" > /var/www/html/index.html
yum install -y httpd
systemctl start httpd
systemctl enable httpd
EOF

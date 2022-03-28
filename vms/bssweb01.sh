#! bin/bash

sudo apt-get update
sudo apt-get -y install apache2
echo "<html><h1>Welcome to WebServer01!</h1></html>" > /var/www/html/index.html
sudo systemctl start apache2
sudo systemctl enable apache2

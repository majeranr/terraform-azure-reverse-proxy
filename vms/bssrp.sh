#! bin/bash
sudo apt-get update
sudo apt-get -y install nginx
sudo ufw allow "Nginx Full"
sudo systemctl start nginx
sudo systemctl enable nginx
sudo unlink /etc/nginx/sites-enabled/default
sudo echo "
upstream server_group {
	server 172.0.0.140;
	server 172.0.0.145;
	}
server  {

	location / {
		
		proxy_set_header Host $""host;
		proxy_pass http://server_group;

	}
}
" > /etc/nginx/sites-available/webserver.conf
sudo ln -s /etc/nginx/sites-available/webserver.conf /etc/nginx/sites-enabled/webserver.conf
sudo systemctl restart nginx

server {
	listen 80;
	listen [::]:80;

	# root /home/nat/www/webshop; 

	# Add index.php to the list if you are using PHP
	# index index.html index.htm index.nginx-debian.html;

	server_name webshop.ironbeard.com;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		proxy_pass http://localhost:8000;
		#try_files $uri $uri/ =404;
		# autoindex on;
	}

	location ~* ^.+\.(css|cur|gif|gz|ico|jpg|jpeg|js|png|svg|woff|woff2)$ {
		root /home/numart/src/nu_mart/priv/static;
		etag off;
		expires max;
		add_header Cache-Control public;
	}	 
}

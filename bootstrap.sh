#!/usr/bin/env bash
set -e # exit on first error
set -u # exit on using unset variable

# See http://michaelchelen.net/81fa/install-jekyll-2-ubuntu-14-04/

apt-get update
apt-get upgrade -y
SITEURL="documentation.majorsilence.com"

function base_system()
{
	apt-get install ruby2.0 ruby2.0-dev make build-essential npm nodejs git nginx zlib1g-dev -y

	echo "start gem install.  This will take several minutes."
	yes | gem2.0 install jekyll github-pages rdiscount json --no-rdoc --no-ri --verbose
	echo "end gem install"
}

function jekyll_hook()
{
	# See https://github.com/developmentseed/jekyll-hook
	ln -s /usr/bin/nodejs /usr/bin/node
	npm install -g forever

	git clone https://github.com/developmentseed/jekyll-hook.git
	cd jekyll-hook
	npm install
}


configure_nginx_basic()
{

	if [ ! -d "/var/www/$SITEURL" ]; then
		rm -rf /var/www
		mkdir /var/www
	fi

	
	if [ -d "/documentation" ]; then
  		# running on local vagrant vm
  		ln -fs /documentation "/var/www/$SITEURL"
  	else
  		# live server

		if [ ! -d "/var/www/$SITEURL" ]; then
			# create folder only if it does not exist
			mkdir "/var/www/$SITEURL"
		fi
  		
	fi

}



configure_nginx()
{

	echo "configure_nginx start" 

	# clear default site contents
	# cp /etc/nginx/sites-enabled/default /etc/nginx/sites-enabled/default-backup
	> /etc/nginx/sites-enabled/default

	# config server port 80 with mono
	echo "server {" >> /etc/nginx/sites-enabled/default
	echo "	listen 80 default_server;" >> /etc/nginx/sites-enabled/default
	echo "	listen [::]:80 default_server ipv6only=on;" >> /etc/nginx/sites-enabled/default
	echo "	root /var/www/$SITEURL/;" >> /etc/nginx/sites-enabled/default
	echo "	index index.html index.htm;" >> /etc/nginx/sites-enabled/default
	echo "	server_name $SITEURL www.$SITEURL;" >> /etc/nginx/sites-enabled/default
	
	# The line below will auto redirect to https
	#echo "	rewrite        ^ https://\$server_name\$request_uri? permanent;" >> /etc/nginx/sites-enabled/default
	echo "	location / {" >> /etc/nginx/sites-enabled/default
	echo "		root /var/www/$SITEURL/;" >> /etc/nginx/sites-enabled/default
	echo "		index index.html index.htm;" >> /etc/nginx/sites-enabled/default
	echo "	}" >> /etc/nginx/sites-enabled/default
	echo "}" >> /etc/nginx/sites-enabled/default
	#\ntry_files $uri $uri/ =404;

	# increase bucket size so more server options can go in sites-enabled/defaults
	# TODO: maybe we want to override the full nginx.conf file
	sed -i 's/# server_names_hash_bucket_size 64;/server_names_hash_bucket_size 64;/g' /etc/nginx/nginx.conf

	# Redirect www to non www
	# https://rtcamp.com/tutorials/nginx/www-non-www-redirection/

	service nginx reload

	echo "configure_nginx finished" 
}


base_system
configure_nginx_basic
configure_nginx
#jekyll_hook


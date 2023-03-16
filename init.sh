#!/bin/bash

sudo apt-get install nginx
path=~/web/
mkdir -p ${path}{public/{img,css,js},uploads,etc}

if [!-e "${path}etc/nginx.conf"]
then
    bash -c "cat <<- EOF >> ${path}etc/nginx.conf
    server {
        location ^~ /uploads/ {
            root ${path}uploads;
        }
        location ~* ^\/img\/.+\.jpg$ {
            root ${path}public;
        }
        location / {
            return 404;
        }
    }
EOF"
else
    echo "The file ${path}etc/nginx.conf already exists"
    cat ${path}etc/nginx.conf
fi
sudo ln -sf ${path}etc/nginx.conf /etc/nginx/sites-enabled/default
sudo systemctl start nginx
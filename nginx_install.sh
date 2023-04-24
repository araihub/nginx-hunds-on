# NGINX Plus install script

### help

function setup () {
    sudo mkdir /etc/ssl/nginx
    sudo cp -p nginx-repo.crt /etc/ssl/nginx/ && sudo cp -p nginx-repo.key /etc/ssl/nginx/
    sudo apt-get update
}

function lic_check () { 
    ## check certificate & key
    ls /etc/ssl/nginx/nginx-repo.*  2>&1

    if [ $? -eq 0 ] ; then
        echo 'nginx license file FOUND'
    else
        echo 'license file is Not FOUND'
    fi
}


function plus () {
    sudo wget https://cs.nginx.com/static/keys/nginx_signing.key && sudo apt-key add nginx_signing.key && \
    sudo apt-get install -y apt-transport-https lsb-release ca-certificates wget && \
    printf "deb https://pkgs.nginx.com/plus/ubuntu `lsb_release -cs` nginx-plus\n" | sudo tee /etc/apt/sources.list.d/nginx-plus.list && \
    sudo wget -P /etc/apt/apt.conf.d https://cs.nginx.com/static/files/90pkgs-nginx && sudo apt-get update && \
    sudo apt-get install -y nginx-plus

    if [ $? == 0 ] ; then
        sudo apt-get install -y nginx-plus && echo `complete Install to nginx plus`  
      
    else
        echo `Not Complete install nginx plus`
    fi
}

setup
lic_check
plus

nginx -v 
dpkg-query -l | grep nginx-plus

sudo service nginx start

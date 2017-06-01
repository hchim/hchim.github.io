---
layout: post
categories: Node.js
tags: [Node.js, EC2, nginx]

---

### Install node.js


We will use nvm (node version manager) to install node. nvm allows us to install multiple
versions of node and allows us to switch between each version.
Run the following code to install nvm:

```
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
```

nvm will be install to the `~/.nvm` directory. Run this command to activate nvm.

```
. ~/.nvm/nvm.sh
```

Then we can run this command to install the version of node we need.

```
nvm install 8.0.0
```

### Pull the code from github

My code is stored on github. I will need git to pull the code.

```
sudo yum install git
```

You also need to generate a ssh key and add the pub key to github.
Following this [webpage](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/) to setup ssh key. 

Now we can clone the git repository.

```
git clone git@github.com:<github userid>/<Repository Name>.git
```

### Run the node.js app

I use [bower](https://bower.io/) to manage front end packages, so I use this command to install bower first.

```
npm install -g bower
```

I use [pm2](http://pm2.keymetrics.io/) as the process manager of node.js apps.

```
npm install -g pm2
```

I also install development tools so as to successfully run `npm install` to install one of the package `bcrypt` that I used.

```
sudo yum group install "Development Tools"
npm install
```

Finally, we can use pm2 to start the node.js app.

```
pm2 start ecosystem.config.js
```

### Install nginx

We will run multiple node.js apps on the same host, these apps will share the 80 and 443 ports.
So we use nginx as the proxy for node.js apps. Run this command to install nginx.

```
sudo yum install nginx
```

Then we will add a `.conf` file, which specifies nginx should forward the requests to the node.js app.

```
upstream app_name {
    server 127.0.0.1:3000;
}

server {
  listen 0.0.0.0:80;
  server_name example.com;
  access_log off;
  return 301 https://$host$request_uri;
}

# the nginx server instance
server {
  listen 0.0.0.0:443 ssl;
  server_name example.com;

  ssl on;

  ssl_certificate /www/ssl/example.com.crt;
  ssl_certificate_key /www/ssl/example.com.key;

  access_log off;

  # pass the request to the node.js server with the correct headers and much more can be added, see nginx config options
  location / {
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-NginX-Proxy true;
    #for nginx >=1.3.13 handle websocket requests
    proxy_http_version 1.1;
    proxy_set_header Upgrade $http_upgrade;
    proxy_set_header Connection "upgrade";

    proxy_pass http://app_name/;
    proxy_redirect off;
  }
}
```

Restart nginx, then you should be able to access your website.

```
sudo service nginx restart
```
# How to use custom domain while developing

There are a bunch of tutorials online on how to set up DNSMasQv on macOS to basically do one thing. Any address that ends with a specific root domain like .loc, is captured and forwarded to the Virtual Box. You might think, Convenient: I don’t have to do anything, and whatever I type, it will just end up on my dev server. Yes, but that won’t help you much, because you’ll need a reverse proxy to have multiple sites on the virtual server using Port 80. To do so, you need to add each domain in the Nginx configuration, and, since you have to do that manually anyway, you might as well just add one extra line to the `/etc/hosts` file. This way, you'll have one less piece of software running on your machine.

So, when it comes to custom domains, just do this in your `/etc/hosts` file, and all will be good.

```
##
# Host Database
#
# localhost is used to configure the loopback interface
# when the system is booting.  Do not change this entry.
##
127.0.0.1			localhost
255.255.255.255	broadcasthost
::1             		localhost

192.168.56.100	app.example.com
192.168.56.100 	login.example.com
192.168.56.100  	api.example.com
```

## How to setup Nginx as a simple reverse proxy for development

On a Debian installation, this process is straight forward. Just type this:

	sudo apt-get install nginx

After you do this, Ngnix will use SystemD to manage its process. Here are some useful commands to help you manage the server:

Stop

	sudo systemctl stop nginx

Start

	sudo systemctl start nginx

Restart

	sudo systemctl restart nginx

Reaload all the configuration files without stoping the server

	sudo systemctl reload nginx

Make sure Nginx stats when the server restarts

	sudo systemctl enable nginx

Now you know how to manage the server and configure it to handle our sites. The main folder where all the configuration files reside is `/etc/nginx/sites-enabled/`. In the folder, I like to create one file per site:

- app.example.com
- login.example.com
- api.example.com

Inside each file, I have a configuration like this:

```
server {

	#
	#	Listen on port 80 on IPv4
	#
	listen 80;

	#
	#	Listen on port 80 on IPv6
	#
	listen [::]:80;

	#
	#	React to this specific domain
	#
	server_name example.loc;

	location / {

		#
		#	Pass the request to this internal running website
		#
		proxy_pass http://localhost:3000;

		#
		#	Attach the real IP of the request to the header
		#
		proxy_set_header  X-Real-IP  $remote_addr;

		#
		#	Set the host name (the name of the domain that we are
		#	listening for) to the header
		#
		proxy_set_header Host $host;

	}
}
```

The only differences between the files are the `server_name` option and the port at which the site is running. Here, you see `3000`, but you can have multiple sites on any port you like. After you reload the Nginx configuration, Nginx will forward the traffic to the right internal address.

# Ginnx will do it for you

Now that you know that basic how to setup Nginx, it be best if there was an automated tool that could create a configuration file automatically, right? Well I did one 😅 called [ginnx](https://www.npmjs.com/package/ginnx). Every time you'll run it will ask you for the domain of the site that you want to use and the port on which is should run. With this information the configuration file will be automatically created, the Nginx server restarted, and a new server be running.

This tool makes my life easier, and I hope it will help you to 😀.

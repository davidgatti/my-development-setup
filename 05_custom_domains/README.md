# How to use custom domain while developing

There are a bunch of tutorials on-line where where they show you how to setup DNSMasQv on macOS, to basically do one thing. Any address ending with a specific root domain like .loc, is being captured and forwarded to the virtual box. You can say, convenient: I don’t have to do anything and whatever I type it will just end up on my dev server. Yes, but that won’t help you much :) Because you’ll need a reverse proxy to allow you to have multiple sites on the virtual server using the port 80. To do so you need to add each domain that you want to in the Nginx configuration, and since you have to do that manually anyway, you might as well just add one extra line to the `/etc/hosts` file. This way you have one less peace of software running on your machine.

So yes, when it comes to custom domains, just do this in your /etc/hosts file and you will be good.

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

On a Debian installation this process if straight forward. You just type this

`sudo apt-get install nginx`

After you do this Ngnix will use SystemD to manage its process, and so this are some useful commands that will help you manage the server

Stop

	`sudo systemctl stop nginx`

Start

	`sudo systemctl start nginx`

Restart

	`sudo systemctl restart nginx`

Reaload all the configuration files without stoping the server

	`sudo systemctl reload nginx`

Make sure Nginx stats when the server restarts

	`sudo systemctl enable nginx`

Now you know how to manage the server lest configure it to handle our sites. The main folder where all the configurations files resides is this `/etc/nginx/sites-enabled/`. In the folder I like to create one file per site for example

- app.example.com
- login.example.com
- api.example.com

And inside each file I have a configuration like this:

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

The only difference between the files is the `server_name` option. And the port at which the site is running. Here you see 3000, but you can have multiple sites on any port you like. After you reload the Nginx configuration, Nginx will forward the traffic to the right internal address.
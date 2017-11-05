```
[Unit]
Description=receipt-api-auth
Documentation=https://github.com/davidgatti/receipt-api-auth
After=network.target

[Service]
EnvironmentFile=/home/davidgatti/Documents/MrWhite/Receipt/receipt-api-auth/.env
Type=simple
User=root
Group=root
WorkingDirectory=/home/davidgatti/Documents/MrWhite/Receipt/receipt-api-auth
ExecStart=/usr/bin/node workers/server
StandardOutput=journal
StandardError=journal
SyslogIdentifier=receipt-api-auth
Restart=on-failure
RestartSec=3
KillMode=process
ExecReload=/bin/kill -HUP $MAINPID

[Install]
WantedBy=multi-user.target
```

# The Server Environment

This was quite the journey. Lots of ideas, configurations files and apps. But it is time to actually show you how I put it all together, and what tools I use to simplify and automate my life as much as possible with custom tools that I've built.

# Story time

Wile back when I started working with NodeJS I was running each server in my VM but in a separated terminal window. This worked fine when I had only few project, but it became unmanageable when the list of server grew almost each week because of the micro-service architecture. I then decided to move over SystemD as the main infrastructure to manage my servers.

# SystemD

The good part of SystemD is that once you add a server as a service with the option to start when the system starts, then you don't have to spend the time to start everything by hand. The downside is that adding a service is a tedious task, since you have to create a configuration file for each micro-service.

To alleviate this problem I created [toSystemD](https://www.npmjs.com/package/tosystemd) a small tool that if run inside the project folder it will read the `package.json` and get all the information from there, while also use the current location to crate the right paths etc.

Once this tools is done,

- you will have a new configuration file in `/etc/systemd/system`,
- SystemD reloaded,
- your site running,
- and auto start enabled

This tool proved it self countless time for me, and I hope you'll also find it useful and a time savior ☺️
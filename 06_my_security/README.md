# My Security approach

I’m one of those guys that takes security very seriously, to the point that people look at me with the stink eye and think that I’m crazy. But I try to keep tabs on what's going on in the security world. When you hear about all the hacks and issues that happen, all of which could have easily been avoided, I’m not sure I’m the crazy one! ;) To me, people who don’t take security seriously are the crazy ones. Maybe it just depends on your point of view. Anyway…

## Password management

I categorize passwords using two types:

- Websites
- Servers

### Websites

I use KeyChain to store all my website passwords. I like this app solution because it nicely synchronizes with all of my Apple devices, and I have one less app to install on my system and manage. Apps like 1Password or LastPass have more features, but that's not enough for me to switch.

## Servers

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/06_my_security/images/1.png">
</div>

I manage dozens of servers, and it's not feasible to try to remember every password, so I use SSH Key. But I want to avoid making it easy for someone to get access to my laptop and log in on each server with ease. This inspired me to come up with the following solution:

For each client, I create a disk image using the built-in Disk Utility app in macOS. Each disk is around 50MB and encrypted. I keep important information inside the disk, including SSL Certs and SSH Keys. When I finish working for a client, I unmount the disk, and suddenly, you can’t access the servers from my computer.

The path to the SSH Key in the .ssh/config file no longer exists, since it points inside a Disk Image.

When I need to do some work for a client, I mount the Disk Image and write the password to decrypt the image. But I do this once, and then until the disk is mounted, I can work.

I think this is a good middle ground solution for security and convenience 🙂.

# how to create a disk/image in macOS

First you need to open the Disk Utility tool, from there select File from the menu bar, New Image, and then Blank Image, or just hit CMD+N. A drop down window will appear with the image options as shown bellow:

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/06_my_security/images/1.png">
</div>

Write down all your information and in the Encryption drop down select the highest option. A new drop down will show up where you can add the password that will decrypt the image. Remember if you forget this password you are out of luck and won't be able to access the disk again.

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/06_my_security/images/1.png">
</div>

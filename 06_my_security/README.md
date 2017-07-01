# My Security approach

I’m one of those guys that teats security very seriously, to the point that people looks at me with a stinky eye and think that I’m crazy. But I try to keep a tap on what is going on in the security world, and where you heard all the hacks and issues that happens, and that all of that could have been avoided really easily, then i’m not sure I’m the crazy one ;) To me people that don’t take security seriously are the crazy ones - so it seams this is just a point of view.

## Password management

I categorize passwords in two types:

- Websites
- Servers

### Websites

For websites I use KeyChain to store all my passwords. I like this solution from 3th party apps because it nicely synchronizes with all my Apple devices and I have one less app to install on my system and manage. Apps like 1Password or LastPass for sure have more features but they are not enough for me to switch over.

## Servers

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/06_my_security/images/1.png">
</div>

I have dozens of servers that I manage and to remember for each of them the password is unfeasible, so f course I use SSH Key. But I want to avoid the situation that if someone gets access to my laptop they could easily log-in on each server with no problem. Because of this I came up with the following solution:

For each client that I have I create a disk image using the build in Disk Utility app in macOS, each disk is around 50MB and of course encrypted. Inside the disk I keep all the important secrets like SSL Certs and SSH Keys. This way when I finish working for a client I can unmount the disk, and suddenly you can’t access the servers from my computer. Since the path to the SSH Key in the `.ssh/config` file doesn’t exists anymore, since it points inside a Disk Image.

When I need to do some work for a client I mount the Disk Image, write the password to decrypt the image, but I do this once, and then until the disk is mounted I can work.

I think this is a good middle ground solution of security and convenience :)
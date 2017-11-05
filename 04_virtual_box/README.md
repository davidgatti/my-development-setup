# My Virtual Box

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/VirtualBox.png">
</div>

You probably wouldn’t be surprised to hear that I don’t run code from my main operating system, which in my case is macOS. All of the code is run from Debian, which is inside a Virtual Box installation. This allows me to keep my main system clean of any servers and weird things that I might have to install for development.

Inside Debian, I use Docker for further organization. In the beginning, I tried to code my apps inside Docker. But, after few months, I came to the conclusion that the benefit was minimal and the overhead involved in making small changes was too much, so I decided to drop Docker for this particular scenario, but keep it to run servers like SQL-type apps, Redis, and other things. This way, I can have multiple versions for testing in a very easy-to-manage way.

# Virtualization within macOS, rather than VirtualBox

Yes, VirtualBox is a big beast, and one big downside of that is that it takes up 7GB of space on my SSD (this is the size of my virtual hard drive), although I've used nearly 1/3 of that. To me, this is a hit that I can take. With VBox, I basically have a box from which I can just delete one file and I’m back to a clean system.

In addition, Virtual Box allows me to mimic a real server in any way I like, thanks to its infinite network configuration possibilities. You can do whatever crazy thing pops into your head, without disrupting any installation, which I love.

Also, if I kill my Virtual Box, nothing runs on my host machine - absolutely nothing, zero, nada. So, when I want to be sure that my battery will last as long as possible, I just shoot down Virtual Box.

## How to connect to Virtual Box

At first, I was using the NAT Network option, so VB was basically part of the localhost address space. For example, to reach Redis, you could just use `redis://localhost:6379` from the host machine, but the Virtual Box would forward the request inside Debina. This way, I was able to connect to my VB whether I was connected to a network or not.

But when I decided to use a reverse proxy like Nginx, it became clear that I wouldn't be able to use this setup, because I was unable to use port 80. macOS won’t allow it, and to change this behavior would decrease system security. At first, I used port 8080, so I would have to type `http://example.loc:8080`, but this approach was so unclean that I decided to find a better solution.

Thankfully, you can configure VirtualBox to have a fixed IP, no matter what network you connect to. Because if you were to use the "Bridge Adapter" option, the running system would obtain an IP from your home router. But if you were to go to a different network, your VB system would get a different IP, meaning you would have to change your `/etc/hosts` file each time. Super annoying.

## How to set a fixed IP to Virtual Box

Open VirtualBox and go to general Preference window. From there, select the Network tab and add a new card. Once added, select it and click the little screw driver icon.

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/1.png">
</div>

Now select the DHCP Server table, where you're going to uncheck the Enable Server option on the adapter view, next to the DHCP Server tab. You can either change the IP to one that you prefer, or remember the default.

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/2.png">
</div>

By the way, this won’t be the IP of the server when it runs. You'll set the IP in the next step.

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/3.png">
</div>

These are the general settings for VirtualBox, where you can edit the Network settings for your virtual machine. Once you open the settings page, go to the Network tab, select Adapter 1, and then the NAT option from the drop-down menu for the Attached to piton. This provides the virtual machine with internet access.

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/4.png">
</div>

On the Adapter 2 tab, choose Host-only Adapter from the drop down-menu for the Attached to option, and then in the Name option select the cart we created in the previous step.

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/5.png">
</div>

Now you can start your server with the window where you can log-in to the machine, and log in to edit the following file: `sudo nano /etc/network/interfaces`. At the end of the file you'll write the following:

```
# The fixed IP
auto enp0s8
iface enp0s8 inet static
address 192.168.56.100
netmask 255.255.255.0
network 192.168.56.0
broadcast 192.168.56.255
```

**WARNING**: where did the eth0, eth1 go? Read here more about [Predictable Network Interface Names](https://www.freedesktop.org/wiki/Software/systemd/PredictableNetworkInterfaceNames/) to find out what changed in Debian 9. Also do `ls /sys/class/net/` to find out all your network cards.

Save the file and restart the Virtual Machine. You should be able to access the server on the `192.168.56.100` IP, no matter which network you're using.

Now the question is this: How do you put code that you've written to the Virtual Machine inside Virtual Box? Well, you can share a folder from the host machine inside the Virtual one. This might seem nuts, but it's a super cool and simple way to just code with your favorite IDE on your host machine, while your code is being run inside Debian.

## Share host folder inside a Virtual Machine run from Virtual Box

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/6.png">
</div>

1. Install kernel headers (installer needs them to build the kernel module):

	```
	sudo apt-get install -y build-essential linux-headers-$(uname -r)
	```

1. Restart the system
1. Start the virtual system with a regular window (not windowless)
1. Log-in in to the system
1. From the virtual machine window select Devices > Insert Guest Additions CD Image
1. Mount the Guest Additions CD in your host system.

	```
	sudo mount /dev/cdrom /media/cdrom
	```

1. Go to the mounted CD-ROM

	```
	cd /media/cdrom
	```

1. Run the installer

	```
	sudo ./VBoxLinuxAdditions.run
	```

## How to share a macOS folder with Linux through Virtual Box

1. Power off the virtual machine
2. Create a folder on macOS that you want to share with your virtual machine

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/7.png">
</div>

3. Open the Settign section of your virtual machine
4. Go to the Sharde Folders tab
5. Click on the + folder
6. From the drop down menu, select the folder that is on your macOS
7. Name it hoewver you want, the name can be different form the folder name on your macOS
8. Select Make Permanent if you have such option, so the folder will be alwasy mounted

<div align="center">
	<img src="https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/8.png">
</div>

9. Click OK.
10. Now, boot your virtual machine
11. Create a new folder wherewer you like with mkdir
12. Once the new fodler is done, type the following:

```
sudo mount -t vboxsf folder_name path_to_mount_point
```

Where `folder_name` is the name that you gave on the Settings page, and path_to_mount_point is the path to the folder that you just created in your Virtual Box.

## Mount folders

How to mount the folder from the host in to a folder inside VirtualBox:

```
mount -t vboxsf NAME_OF_THE_FOLDER_YOU_SHARED /home/$(users)/Documents -o uid=$(users) -o gid=$(users)
```

## How to enable symlink in a shared folder

By default, when you share a folder from your host machine, symlinking is not supported. This is okay most of the time, but with NodeJS, for example, when you install a module using NPM, symlinking is crucial. In this case, the line below allows you to enable symlinking in your shared folder.

Type this in your host system, the system that have VirtualBox installed

```
VBoxManage setextradata "NAME_OF_YOUR_VM" VBoxInternal2/SharedFoldersEnableSymlinksCreate/NAME_OF_THE_SHARED_FOLDER 1
```

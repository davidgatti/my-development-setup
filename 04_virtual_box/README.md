# My Virtual Box

Probably you won’t be surprised if I tell you that I don’t run code from my main operating system, which in my case is macOS. All the code is being run from a Debian, which is inside a Virtual Box installation. This way I keep my main system clean of any servers and weird things that I might have to install for development.

Inside Debian I also use Docker for further organization. In the beginning I tried to code my apps inside Docker but after few months of doing that I came to the conclusion that the benefit is minimal and the overhead of doing small changes etc was to much for the befits, so I decided to drop Docker for this particular scenario, and keep it to run servers like SQL type apps, Redis and other things. This way I can have multiple versions for testing in a very simple to manage way.

## How to connect to Virtual Box

At first what I was doing was, using the NAT Network option so VB basically was part of the localhost address space, so to reach let say Redis you could just use redis://localhost:6379 from the host machine, but the Virtual Box would forward the request inside Debina. This way no matter if you were connected to a network or not I was able to connect to my VB with no problems.

But when I decided to use a reverse proxy like Nginx, it became clear that I won't be able to use this setup, because I was unable to use port 80. macOS won’t allow it and change this behavior would decrease security of my system. At first I used port 8080 so I would have to type google.loc:8080, but this approach was so unclean, that I decided to find a better solution.

Thankfully you can configure VirtualBox to have a fixed IP no matter the network you connect to. Because if you were to use the “Bridge Adapter” option, yes the running system would get an IP from your home router, but then if you were to go to a different network your VB system would get a different IP, meaning you would have to change for example your /etc/hosts file each time. Super annoying.

## How to set a fixed IP to Virtual Box

Open up VirtualBox and go to general Preference window of VB. From the new window select the Network tab and add a new card. Once aded select it and click the little screw driver icon.

<div align="center">
![Virtual Box Network](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/1.png)
</div>

And select the DHCP Server table where you are going to uncheck the Enable Server option. On the adapter view, next to the DHCP Server tab. You can either change the IP to one that you like better, or remember the default one.

![Virtual Box DHCP Server](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/2.png)

By the way this won’t be the IP of the server once it’s going to be running. The IP is the one that you are login to set in the next step.

![Virtual Box Adapter](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/3.png)

This is were the general settings for VirtualBox, it is time to edit the Network settings for your virtual machine. Once you open the setting page, to the Network tab, select the Adapter 1 and select the NAT option from the drop down menu for the Attached to piton. This way the virtual machine will have access to the internet

![Virtual Box Adapter 2](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/4.png)

On Adapter 2 tab, choose Host-only Adapter from the drop down menu for the Attached to option, and then in the Name option select the cart that we created in the previous step

![Virtual Box Adapter 2](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/5.png)

Now you can start your server with the window where you can log-in to the machine, where you are login to edit the following file: `sudo nano /etc/network/interfaces`, and where at the end of the file you are going to write the following:

```
# The fixed IP
auto eth1
iface eth1 inet static
address 192.168.56.100
netmask 255.255.255.0
network 192.168.56.0
broadcast 192.168.56.255
```

Save the file. Restart the Virtual Machine, and you should be able to access the server on the 192.168.56.100 IP no matter which network you will connect.

Now the question is how do you put code that you write to the Virtual Machine inside Virtual Box. Well you can Share a folder from the host machine inside a Virtual one, nuts, but super cool and simple way to just code with your favorite IDE on your host machine, while your code is being run inside Debian and access you I write with my host browser by connection to the Virtual Machine.

## This is how you do it.

Share host folder inside a virtual Machine run from Virtual Box

How to install Virtual Box Guest Additions on Linux

![Virtual Box Share Folder](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/6.png)

1. Install kernel headers (installer needs them to build the kernel module):

	sudo apt-get install -y linux-headers-$(uname -r)

1. Start the virtual system with a regular window (not windowless)
1. From the virtual machine window select Devices > Insert Guest Additions CD Image
1. Mount the CD-ROM

	sudo mount /dev/cdrom /media/cdrom

1. Go to the mounted CD-ROM

	cd /media/cdrom

1. Run the installer

	sudo ./VBoxLinuxAdditions.run

## How to share a macOS folder with Linux through Virtual Box

1. First you'll need to install the Guest Additions package from Virtual Box.
1. Then, power off the virtual machine
1. Create a folder on macOS that you want to share with your virtual machine

![Virtual Box Share Folder Path](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/7.png)

1. Open the Settign section of your virtual machine
1. Go to the Sharde Folders tab
1. Click on the + folder
1. From the drop down menu, select the folder that is on your macOS
1. Name it hoewver you want, the name can be different form the folder name on your macOS
1. Select Make Permanent if you have such option, so the folder will be alwasy mounted

![Virtual Box Share Folder Dir](https://raw.githubusercontent.com/davidgatti/my-development-setup/master/04_virtual_box/images/8.png)

1. Click OK.
1. Now, boot your virtual machine
1. Create a new folder wherewer you like with mkdir
1. Once the new fodler is done, type the following:

`sudo mount -t vboxsf folder_name path_to_mount_point`

where folder_name is the name that you given in the settign page, and path_to_mount_point is the path to the folder that you jsut created in your virtual box.

## Mount folders

How to mount the folder form the host in to a folder inside VirtualBox

`mount -t vboxsf GitHub-VM /home/$(users)/Documents -o uid=$(users) -o gid=$(users)`

## How to enable symlink in a shared folder

By default when you share a folder from your host machine that hosts VirtualBox to a system inside VirtualBox, symlinking ins not supported. This is ok for the majority of the time but for example with NodeJS, when you install a modules using NPM, then symlinking is crucial. In this case, the line bellow allows you to enable symlinking in your shared folder.

`VBoxManage setextradata "NAME_OF_YOUR_VM" VBoxInternal2/SharedFoldersEnableSymlinksCreate/NAME_OF_THE_SHARED_FOLDER 1`
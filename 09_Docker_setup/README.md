# How to Install Docker on Debian 9

1. `apt install apt-transport-https dirmngr`
1. `echo 'deb https://apt.dockerproject.org/repo debian-stretch main' >> /etc/apt/sources.list`
1. `apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D`
1. `apt update`
1. `apt install docker-engine`


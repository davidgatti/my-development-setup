# Bring Debian up to speed

sudo apt-get update && 
sudo apt-get upgrade -y && 
sudo apt-get install -y git && 
sudo apt-get install -y build-essential && 
sudo apt-get install -y curl && 
sudo apt-get install sudo && 
sudo apt-get autoremove && 
sudo apt-get clean &&
sudo adduser $(users) sudo

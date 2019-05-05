## this script runs as root
apt update
apt install docker.io -y 

# let admin user use docker without sudo
gpasswd -a crankier docker

docker pull staff0rd/crankier

## this script runs as root
apt update
apt install docker.io -y 
apt install docker-compose -y

# let admin user use docker without sudo
gpasswd -a crankier docker

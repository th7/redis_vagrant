set -e
sudo yum update -y
sudo yum install -y wget

# set up redis rpm
sudo wget -r --no-parent -A 'epel-release-*.rpm' http://dl.fedoraproject.org/pub/epel/7/x86_64/e/
sudo rpm -Uvh dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-*.rpm

sudo yum install -y redis-2.8.19
# make redis available to external clients
sudo sed '/bind 127.0.0.1/d' /etc/redis.conf | sudo tee /etc/redis.conf

# start redis with os
sudo systemctl enable redis.service
# start redis now
sudo systemctl start redis.service

# open port 6379
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --zone=public --add-port=6379/tcp --permanent
sudo firewall-cmd --reload

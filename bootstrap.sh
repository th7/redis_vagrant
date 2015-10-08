set -e
# sudo yum update -y
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

sudo yum --enablerepo=remi,remi-test install -y redis

# make redis available to external clients
sudo sed '/bind 127.0.0.1/d' /etc/redis.conf | sudo tee /etc/redis.conf

# run redis with os
sudo chkconfig --add redis
sudo chkconfig --level 345 redis on
sudo service redis start

# open port 6379
sudo iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 6379 -j ACCEPT
sudo service iptables restart

#!/bin/sh

# Update system first
sudo apt-get update 
sudo apt-get upgrade -y

# Install puppet
curl -O https://apt.puppetlabs.com/puppetlabs-release-pc1-xenial.deb
sudo dpkg -i puppetlabs-release-pc1-xenial.deb
sudo apt-get update 
sudo apt-get install puppet-agent -y

# Setup puppet agent
sudo systemctl enable puppet
sudo cat <<EOT >> /etc/puppetlabs/puppet/puppet.conf
[main]
server = foreman.lab
environment = production
runinterval = 15m
EOT

# Run puppet agent 
for i in {1..5}; do sudo /opt/puppetlabs/bin/puppet agent -tvd; done

# Exiting
exit 0

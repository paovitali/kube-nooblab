#!/bin/bash

# Run on VM to bootstrap the Foreman server

# Update system first
sudo yum update -y
sudo yum check-update

# Disable selinux everywhere
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Install base repos & tools
sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
sudo yum -y install curl git rsync net-tools vim mc htop docker

# Install puppet
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm

# Install Foreman
sudo yum -y install https://yum.theforeman.org/releases/1.16/el7/x86_64/foreman-release.rpm && \
sudo yum -y install foreman-installer && \
sudo foreman-installer

# Foreman Fix yaml configuration
sudo sed -i 's/:puppetdir: "\/opt\/puppetlabs\/server\/data\/puppetserver"/:puppetdir: "\/etc\/puppetlabs\/puppetserver"/' /etc/puppetlabs/puppet/foreman.yaml

# Puppet shared folder configuration 
sudo rm -f /etc/puppetlabs/puppet/autosign.conf
sudo ln -s /etc/puppetlabs/code/config-files/autosign.conf /etc/puppetlabs/puppet/autosign.conf
sudo rm -f /etc/puppetlabs/puppet/hiera.yaml
sudo ln -s /etc/puppetlabs/code/config-files/hiera.yaml /etc/puppetlabs/puppet/hiera.yaml

# Disable Firewalld
sudo systemctl stop firewalld
sudo systemctl disable firewalld

# Enable Docker
sudo systemctl enable docker
sudo systemctl start docker

# Refresh services
sudo systemctl restart httpd
sleep 10
sudo systemctl restart puppet
sleep 10
sudo systemctl restart foreman
sleep 10
puppet agent -tvd

# Exiting
exit 0

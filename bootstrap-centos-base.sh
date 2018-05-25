#!/bin/sh

# Update system first
sudo yum update -y
sudo yum check-update

# Install mainline elrepo kernel 4.x
#sudo rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
#sudo rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-3.el7.elrepo.noarch.rpm
#sudo yum -y --enablerepo=elrepo-kernel install kernel-lt kernel-lt-devel
#sudo grub2-mkconfig -o /boot/grub2/grub.cfg
#sudo grub2-set-default 0

# Disable selinux everywhere
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
sudo sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config

# Install base repos & tools
sudo yum -y install http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm && \
sudo yum -y install curl git rsync net-tools vim mc htop

# Install puppet
sudo rpm -ivh https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm &&

# Disable firewalld
sudo systemctl stop firewalld
sudo systemctl disable firewalld

# Setup puppet agent
sudo yum -y install puppet-agent

sudo cat <<EOT >> /etc/puppetlabs/puppet/puppet.conf
[main]
server = foreman.lab
environment = production
runinterval = 15m
EOT

sudo /opt/puppetlabs/bin/puppet agent -tvd
sudo /opt/puppetlabs/bin/puppet agent -tvd
sudo /opt/puppetlabs/bin/puppet agent -tvd

sudo systemctl enable puppet

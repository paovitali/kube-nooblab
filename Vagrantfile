# -*- mode: ruby -*-
# vi: set ft=ruby :

# Automated configurable vagrant file to build nodes from JSON file

# Json nodes configuration parsing
nodes_config = (JSON.parse(File.read("nodes.json")))['nodes']

# Vagrantfile API Declaration
VAGRANTFILE_API_VERSION = "2"

# Main Vagrant Cycle
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Parse through each node configuration
  nodes_config.sort.each do |node|
    
    # Split nodes names / values	  
    node_name   = node[0] # Name of node
    node_values = node[1] # Content of node

    # Hostmanager configuration
    config.hostmanager.enabled = true
    config.hostmanager.manage_host = true
    config.hostmanager.ignore_private_ip = false
    config.hostmanager.include_offline = true
    
    # Vbox Guest Additions auto update
    config.vbguest.auto_update = true
    config.vbguest.iso_path = "http://download.virtualbox.org/virtualbox/%{version}/VBoxGuestAdditions_%{version}.iso"

    # Per node configuration cycle
    config.vm.define node_name do |config|

      # Configure Base Box for each node
      config.vm.box = node_values[':box']

      # Shared Dirs
      config.vm.synced_folder '.', '/vagrant', id: "default_share", disabled: true 
      if node_values[':shared_dir_host'] 
        config.vm.synced_folder node_values[':shared_dir_host'], 
        node_values[':shared_dir_guest'], 
        id: "custom_share", 
        type: node_values[':shared_dir_type'],
        owner: node_values[':shared_dir_owner'],
        group: node_values[':shared_dir_group'] 
      end

      # Ports
      ports = node_values['ports']
      ports.each do |port|
        config.vm.network :forwarded_port,
        host:  port[':host'],
        guest: port[':guest'],
        id:    port[':id']
        node.hostmanager.aliases = %w([':alias'])
      end

      # Hostname
      config.vm.hostname = node_name
      # Networking 
      config.vm.network :private_network, ip: node_values[':ip']

      # VM Resources
      config.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", node_values[':memory']]
        vb.customize ["modifyvm", :id, "--name", node_name]
        vb.customize ["modifyvm", :id, "--cpus", node_values[':cpus']]
      end

      # Post Install Scripts
      config.vm.provision :shell, :path => node_values[':bootstrap']

      # Vagrant Reload
      config.vm.provision :reload

    end
  end
end

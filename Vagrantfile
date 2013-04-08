# -*- mode: ruby -*-
# vi: set ft=ruby :

# Conventions
# host == Host Computer
# node == VM

host_source_root = 'projects'
host_log_root    = 'logs'
web_root         = 'webroot'
node_source_root = '/source'
node_log_root    = '/mnt/logs'

Vagrant.configure("2") do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "centos63-puppet"
  config.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-63-x64.box"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  # config.vm.box_url = "http://domain.com/path/to/above.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network :private_network, ip: "192.168.56.60"
  config.vm.hostname = "phpdev.local"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder host_source_root, node_source_root
  if host_log_root != 'undef'
    config.vm.synced_folder host_log_root, node_log_root, :create => true, :extra => 'dmode=777,fmode=777'
  end

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.

  config.vm.provision :puppet do |puppet|
    puppet.facter = {
        'host_source_root' => host_source_root,
        'node_source_root' => node_source_root,
        'host_log_root'    => host_log_root,
        'node_log_root'    => node_log_root,
        'web_root'         => web_root,
    }
    puppet.manifests_path = "puppet/manifests/"
    puppet.manifest_file  = "phpwebdev.pp"
    puppet.module_path = "puppet/modules/"
  end
end

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Conventions
# host == Host Computer
# node == VM


project_name     = 'My Project'
host_source_root = 'projects'
host_log_root    = 'logs'
web_root         = 'webroot'
node_source_root = '/source'
node_log_root    = '/mnt/logs'
php_version      = '5.3' #5.4 is also usable. To change, you will need to rebuild the VM
server_mode      = :single_server
enable_yum_update= false

paths = {
    :local_path  => host_source_root,
    :log_path    => host_log_root,
}

# We have to clean up the paths because vagrant doesn't want
# relative ones...
paths.each_pair do |name,path|
  paths[name] = File.expand_path(path)
  if File.exists?(paths[name]) == false
    print "The directory #{paths[name]} does not exist.\n"
    exit 1
  end
end


nodes = {}

if server_mode == :single_server
  nodes = {
      :'all' => {
          :hostname => 'www',
          :ipaddress => '192.168.56.60',
      }
  }
end

if server_mode == :web_and_db
  nodes = {
      :'web' => {
          :hostname => 'www',
          :ipaddress => '192.168.56.60',
      },
      :'db' => {
          :hostname => 'db',
          :ipaddress => '192.168.56.61',
      }
  }
end

Vagrant.configure("2") do |config|
  nodes.each_pair do |name,options|
    config.vm.define name do |node|
      # All Vagrant configuration is done here. The most common configuration
      # options are documented and commented below. For a complete reference,
      # please see the online documentation at vagrantup.com.

      # Every Vagrant virtual environment requires a box to build off of.
      node.vm.box = "centos63-puppet"
      node.vm.box_url = "http://puppet-vagrant-boxes.puppetlabs.com/centos-63-x64.box"

      # The url from where the 'config.vm.box' box will be fetched if it
      # doesn't already exist on the user's system.
      # config.vm.box_url = "http://domain.com/path/to/above.box"

      # Create a forwarded port mapping which allows access to a specific port
      # within the machine from a port on the host machine. In the example below,
      # accessing "localhost:8080" will access port 80 on the guest machine.
      node.vm.network :forwarded_port, guest: 80, host: 8080

      # Create a private network, which allows host-only access to the machine
      # using a specific IP.
      node.vm.network :private_network, ip: options[:ipaddress]
      node.vm.hostname = "#{options[:hostname]}.example.com"

      node.vm.provider "virtualbox" do |v|
        if nodes.length > 1
          v.name = options[:hostname]
          v.customize ["modifyvm", :id, "--groups", "/#{project_name}"]
        else
          v.name = project_name
        end
      end

      # Create a public network, which generally matched to bridged network.
      # Bridged networks make the machine appear as another physical device on
      # your network.
      # config.vm.network :public_network

      # Share an additional folder to the guest VM. The first argument is
      # the path on the host to the actual folder. The second argument is
      # the path on the guest to mount the folder. And the optional third
      # argument is a set of non-required options.
      node.vm.synced_folder host_source_root, node_source_root, :extra => 'dmode=777,fmode=777'
      if host_log_root != 'undef'
        node.vm.synced_folder host_log_root+"/#{name}", node_log_root, :create => true, :extra => 'dmode=777,fmode=777'
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

      node.vm.provision :puppet do |puppet|
        puppet.facter = {
            'host_source_root' => paths[:local_path],
            'node_source_root' => node_source_root,
            'host_log_root'    => paths[:log_path],
            'node_log_root'    => node_log_root,
            'web_root'         => web_root,
            'php_version'      => php_version,
            'ip_addresses'     => nodes.map { |name,data| data[:ipaddress] }.join(','),
            'enable_yum_update'=> enable_yum_update,
        }
        puppet.manifests_path = "puppet/manifests/"
        puppet.manifest_file  = "#{name}.pp"
        puppet.module_path = "puppet/modules/"
      end
    end
  end
end

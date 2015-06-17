VAGRANTFILE_API_VERSION = "2"

puppet_nodes = [
  {:hostname => 'tech-ops-uchiwa-test', :ip => '172.16.32.10', \
   :host => 3000, :guest => 3000 },
  {:hostname => 'i-492kdieo-rbmq-test', :ip => '172.16.32.11', \
   :host => 15671, :guest => 15671 },
  {:hostname => 'tech-ops-sensu-test', :ip => '172.16.32.12', \
   :host => 6379, :guest => 6379 },
]

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  puppet_nodes.each do |node|
    config.vm.define node[:hostname] do |node_config|
      node_config.vm.box = "ubuntu/trusty64"

      # Manage the Hostname
      node_config.vm.host_name = node[:hostname] + '.2u.com'

      # Port-forwarding
      node_config.vm.network "forwarded_port", guest: node[:guest], host: node[:host]

      # Network
      node_config.vm.network "private_network", ip: node[:ip]

      # Virtual Box-specific
      node_config.vm.provider "virtualbox" do |vb|
        vb.customize ["modifyvm", :id, "--memory", "512"]
      end

      # Sync to local 2u puppet repo
      config.vm.synced_folder "/Users/cdunda/Desktop/puppet/site", "/etc/puppet/modules"

      # Provisioners
      node_config.ssh.private_key_path = [ '~/.vagrant.d/insecure_private_key', '~/.ssh/id_rsa' ]
      node_config.ssh.forward_agent = true
      node_config.vm.provision :shell, :path => "shell/bootstrap_puppet.sh"
      node_config.vm.provision "puppet" do |puppet|
        puppet.manifests_path = "/Users/cdunda/Desktop/puppet/manifests"
        puppet.module_path    = "/Users/cdunda/Desktop/puppet/site"
      end
    end
  end
end

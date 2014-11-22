Vagrant.configure('2') do |config|

  # VM Configuration
  config.vm.box = 'chef/ubuntu-13.10'

  config.vm.provider "virtualbox" do |v|
   v.name = 'campus-vm'
   v.memory = 1024
  end

  config.vm.network "forwarded_port", guest: 7070, host: 12000
  config.vm.network "forwarded_port", guest: 4848, host: 12001

  # SSH Configuration
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.omnibus.chef_version = :latest
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(site-cookbooks cookbooks)
    chef.add_recipe 'glassfish-app'
  end
end
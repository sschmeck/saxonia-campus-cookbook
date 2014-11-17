def define_node(config, name, glassfish_config)
  config.vm.define name do |client|
    client.vm.hostname = "#{name}-vm"
    config.vm.network "forwarded_port", guest: 7070, host: 12000
    config.vm.network "forwarded_port", guest: 4848, host: 12001

    config.omnibus.chef_version = :latest
    client.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = %w(site-cookbooks cookbooks)
      
      chef.add_recipe 'glassfish-app'

      chef.json = {
        'glassfish' => glassfish_config
      }
    end
  end
end

Vagrant.configure('2') do |config|

  # VM Configuration
  config.vm.box = 'chef/ubuntu-13.10'

  # SSH Configuration
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  define_node(config,
              'glassfish-example',
              'domains' => {
                'mydomain' => {
                  'config' => {
                    'port' => 7070,
                    'admin_port' => 4848,
                    'username' => 'admin',
                    'password' => 'admin',
                    'master_password' => 'mykeystorepassword',
                    'remote_access' => true
                  }
                }
              })

end
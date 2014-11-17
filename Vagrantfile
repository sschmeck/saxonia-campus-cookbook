Vagrant.configure('2') do |config|

  # VM Configuration
  config.vm.box = 'chef/ubuntu-13.10'

  config.vm.network "forwarded_port", guest: 7070, host: 12000
  config.vm.network "forwarded_port", guest: 4848, host: 12001

  # SSH Configuration
  config.ssh.forward_agent = true
  config.ssh.forward_x11 = true

  config.omnibus.chef_version = :latest
  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = %w(site-cookbooks cookbooks)
      
    chef.add_recipe 'glassfish-app'

    chef.json = {
      'glassfish' => {
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
        }
      }
    }
  end
end
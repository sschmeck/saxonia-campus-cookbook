default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '7'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['campus-app']['source-location'] = '/project'
default['campus-app']['git_repository'] = 'https://github.com/sschmeck/Saxonia-Campus.git'
default['campus-app']['git_revision'] = 'HEAD'
default['campus-app']['database-schema-file'] = 'business/src/test/db/campus.sql'

default['glassfish']['version'] = '4.1'
default['glassfish']['package_url'] = 'http://dlc.sun.com.edgesuite.net/glassfish/4.1/release/glassfish-4.1.zip'
default['glassfish']['domains'] = {
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
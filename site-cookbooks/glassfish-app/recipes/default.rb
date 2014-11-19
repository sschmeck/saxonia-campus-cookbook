# -----------------------------------------------
# 1. Build the application (EAR)
# -----------------------------------------------
include_recipe 'apt'

package 'git' do
  action :install
end

git "#{node['campus-app']['source-location']}" do
  repository node['campus-app']['git_repository']
  revision node['campus-app']['git_revision']
  action :sync
end

include_recipe 'java'
include_recipe 'maven'

execute 'mvn-package' do
  cwd node['campus-app']['source-location']
  command 'mvn package'
  action :run
end

# -----------------------------------------------
# 2. Setup the database
# -----------------------------------------------
include_recipe 'mysql::server'
include_recipe 'database::mysql'

mysql_connection_info = { :host     => 'localhost',
                          :username => 'root',
                          :password => node['mysql']['server_root_password'] }

mysql_database 'campus' do
  connection mysql_connection_info
  action :create
end

schema_file = ::File.join(node['campus-app']['source-location'], node['campus-app']['database-schema-file'])
mysql_database 'create campus tables' do
  connection mysql_connection_info
  database_name 'campus'
  # TODO use script from git repository
  sql { ::File.open(schema_file).read }
  action :query
end

# -----------------------------------------------
# 3. Setup the application server
# -----------------------------------------------
include_recipe 'glassfish::attribute_driven_domain'
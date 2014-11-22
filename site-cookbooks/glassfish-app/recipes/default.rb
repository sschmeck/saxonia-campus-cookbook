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

mysql_database node['campus-app']['database']['name'] do
  connection mysql_connection_info
  action :create
end

schema_file = ::File.join(node['campus-app']['source-location'], node['campus-app']['database']['schema-file'])
mysql_database 'create campus tables' do
  connection mysql_connection_info
  database_name node['campus-app']['database']['name']
  sql { ::File.open(schema_file).read }
  action :query
end

mysql_database_user node['campus-app']['database']['user'] do
  connection mysql_connection_info
  database_name node['campus-app']['database']['name']
  password node['campus-app']['database']['password']
  privileges [:all]
  action :grant
end

ark "mysql-connector-java" do
   url 'http://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.34.zip'
 end

# -----------------------------------------------
# 3. Setup the application server
# -----------------------------------------------
include_recipe 'glassfish::attribute_driven_domain'
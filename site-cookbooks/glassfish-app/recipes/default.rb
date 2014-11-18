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

include_recipe 'glassfish::attribute_driven_domain'

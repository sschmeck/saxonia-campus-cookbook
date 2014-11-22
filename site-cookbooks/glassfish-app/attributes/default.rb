default['java']['install_flavor'] = 'oracle'
default['java']['jdk_version'] = '7'
default['java']['oracle']['accept_oracle_download_terms'] = true

default['campus-app']['source-location'] = '/project'
default['campus-app']['git_repository'] = 'https://github.com/sschmeck/Saxonia-Campus.git'
default['campus-app']['git_revision'] = 'HEAD'
default['campus-app']['database']['name'] = 'campus'
default['campus-app']['database']['user'] = 'campus'
default['campus-app']['database']['password'] = 'campus'
default['campus-app']['database']['schema-file'] = 'business/src/test/db/campus.sql'

default['glassfish']['domains'] = {
  'mydomain' => {
    'config' => {
      'port' => 7070,
      'admin_port' => 4848,
      'username' => 'admin',
      'password' => 'admin',
      'master_password' => 'mykeystorepassword',
      'remote_access' => true
    },
    'extra_libraries' => {
      'jdbcdriver' => {
        'type' => 'common',
        'url' => 'file:///usr/local/mysql-connector-java/mysql-connector-java-5.1.34-bin.jar'
      },
    },
    'jdbc_connection_pools' => {
      'MySqlPool' => {
        'config' => {
          'datasourceclassname' => 'com.mysql.jdbc.jdbc2.optional.MysqlDataSource',
          'restype' => 'javax.sql.DataSource',
          'isconnectvalidatereq' => 'true',
          'validationmethod' => 'auto-commit',
          'ping' => 'true',
          'description' => 'MySql Connection Pool',
          'properties' => {
            'Instance' => 'Instance1',
            'ServerName' => 'localhost',
            'User' => 'campus',
            'Password' => 'campus',
            'PortNumber' => '3306',
            'DatabaseName' => 'campus'
          }
        },
        'resources' => {
          'jdbc/campus' => {
          	'description' => 'MySql Connection Resource'
          }
        }
      }
    },
    'deployables' => {
      'campus' => {
        'url' => 'file://' + ::File.join(node['campus-app']['source-location'], 'ear/target/ear-0.0.1-SNAPSHOT.ear'),
        'context_root' => '/campus'
      }
    }
  }
}
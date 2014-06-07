name              'mysql-chef_gem'
maintainer        'Chef Software, Inc.'
maintainer_email  'cookbooks@getchef.com'
license           'Apache 2.0'
description       'Provides the mysql_chef_gem resource'

version           '0.0.3'
#commit           9dfdcee8654512f983f8610318dd15ba44589121

supports          'amazon'
supports          'redhat'
supports          'centos'
supports          'scientific'
supports          'fedora'
supports          'debian'
supports          'ubuntu'
supports          'smartos'
# supports          'omnios'

depends           'build-essential'
depends           'mysql'

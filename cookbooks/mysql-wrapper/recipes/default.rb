#
# Cookbook Name:: mysql-wrapper
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

#build_packages = %w(
#  autoconf
#  bison
#  flex
#  gcc
#  gcc-c++
#  kernel-devel
#  make
#  m4
#  patch
#  gcc44
#  gcc44-c++)
#build_packages.each { |pkg| package pkg }
#
#recipe_eval do
#  run_context.include_recipe 'build-essential::default'
#end
#
#mysql_packages = %w(mysql mysql-devel)
#mysql_packages.each { |pkg| package pkg }
#

#options = {:build_args => "--with-mysql-dir=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64"}
#h1 = { :build_args => "-- --with-mysql-dir=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64" }

# Cannot figure out how to pass build options!!!!
#chef_gem 'mysql' do
#  options h1
  #options :build_args => "--with-mysql-dir=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64"
  #options '-- --with-mysql-dir=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64'
  #options("--prerelease --no-format-executable")
#  source '/vagrant/mysql-2.9.1.gem'
#end
#

## No worky
#/opt/chef/embedded/bin/gem install /vagrant/mysql-2.9.1.gem
## No worky
#/opt/chef/embedded/bin/gem install /vagrant/mysql-2.9.1.gem -- --with-mysql-config=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64/bin/mysql_config
## Works!
#/opt/chef/embedded/bin/gem install /vagrant/mysql-2.9.1.gem -- --with-mysql-dir=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64
## Works!
#/opt/chef/embedded/bin/gem install /vagrant/mysql-2.9.1.gem -- --with-mysql-dir=/usr/local/mysql
#
#rpm -i /vagrant/MySQL-5.6.19-1.rhel5.x86_64.rpm-bundle/MySQL-shared-5.6.19-1.rhel5.x86_64.rpm
#rpm -i /vagrant/MySQL-5.6.19-1.rhel5.x86_64.rpm-bundle/MySQL-devel-5.6.19-1.rhel5.x86_64.rpm
#
#packages already have:
#
#build_packages = %w(
##  autoconf
##  bison
##  flex
##  gcc
##  gcc-c++
##  kernel-devel
##  make
##  m4
##  patch)
#
#
#A RANDOM PASSWORD HAS BEEN SET FOR THE MySQL root USER !
#You will find that password in '/root/.mysql_secret'.
#
#You must change that password on your first connect,
#
#SET PASSWORD = PASSWORD('cleartext password')
#
#SET PASSWORD FOR 'jeffrey'@'localhost' = PASSWORD('cleartext password');

execute "/opt/chef/embedded/bin/gem install /vagrant/mysql-2.9.1.gem -- --with-mysql-dir=/vagrant/mysql-5.6.19-linux-glibc2.5-x86_64" do
  not_if "/opt/chef/embedded/bin/gem list | grep mysql"
end

package 'mysql-server'
#
service 'mysqld' do
  action :start
end

#service 'mysql' do
#  action :start
#end

include_recipe "database::mysql"

def mysql_gem_installed?
  cmd = '/opt/chef/embedded/bin/gem list | grep mysql'
  system(cmd)
end

if mysql_gem_installed?
  require 'mysql'
  
  conn_info = {
    :host     => 'localhost',
    :username => 'root',
    :password => '',
    :socket   => '/var/lib/mysql/mysql.sock'
  }
  
  def db_query(sql)
    Mysql.new(
      'localhost',
      'root',
      '',
      nil,
      3306,
      '/var/lib/mysql/mysql.sock'
    ).query(sql)
  end
  
  mysql_database 'oracle_rules' do
    connection conn_info
    action :create
    # Doesn't work because hash can't be used to pass parameters
    #not_if { ::Mysql.new(conn_info).query('select * from mysql.user').num_rows > 0 }
    # Works
    not_if { ::Mysql.new(
      'localhost',
      'root',
      '',
      nil,
      3306,
      '/var/lib/mysql/mysql.sock'
    ).query('select * from mysql.user').num_rows > 0 }
    # Doesn't work, throws the following error:
    # I believe this is because when calling methods in the resource declaration, its
    # using the methods only in the resource/provider class
    # NoMethodError: undefined method `db_query' for Chef::Resource::MysqlDatabase
    #not_if { db_query('select * from mysql.user').num_rows > 0 }
    # Doesn't work, throws the following error:
    # NoMethodError: undefined method `db' for Chef::Resource::MysqlDatabase
    #not_if { db.query('select * from mysql.user').num_rows > 0 }
  end
  
  mysql_database 'oracle_sucks' do
    connection conn_info
    action :create
  end
end
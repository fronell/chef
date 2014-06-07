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
#chef_gem 'mysql' do
#  source '/vagrant/mysql-2.9.1.gem'
#end
#
package 'mysql-server'

service 'mysqld' do
  action :start
end

include_recipe "database::mysql"

def mysql_gem_installed?
  cmd = '/opt/chef/embedded/bin/gem list | grep -c mysql'
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

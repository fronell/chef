#
# Cookbook Name:: sharing
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

package "createrepo" do
  action :upgrade
end

package "yum-utils" do
  action :upgrade
end

template "/data/share/repos/cent5/update_repos.sh" do
  source "repos/cent5/update_repos.sh.erb"
end

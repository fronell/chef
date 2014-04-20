template "/etc/hosts" do
  source "etc/hosts.erb"
  owner  "root"
  group  "root"
  mode   0644
end

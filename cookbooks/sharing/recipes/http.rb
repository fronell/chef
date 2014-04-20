# The utility-vm yum repos get applied before the httpd package can be
# downloaded so we install from a local rpm using rpm_package instead
rpm_package "httpd" do
  source "/data/share/repos/cent5/cent5-x64-updates/RPMS/httpd-2.2.3-85.el5.centos.x86_64.rpm"
end

service "httpd" do
  action [:enable, :start]
end

template "/etc/httpd/conf.d/share.conf" do
  source "httpd/share.conf.erb"
  notifies :restart, "service[httpd]"
end

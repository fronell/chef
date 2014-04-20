# Setup new repo's with 192.168.10.20 as the mirror
yum_repository 'CentOS-Base_utility-vm' do
  description 'CentOS-Base_utility-vm'
  baseurl "http://192.168.10.20/share/repos/cent5/cent5-x64-base/"
  priority '10'
  gpgcheck true
  gpgkey "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5"
  # Ignoring errors so the chef run doesn't bomb out if the repo is down
  ignore_failure true
end

yum_repository 'CentOS-Updates_utility-vm' do
  description 'CentOS-Updates_utility-vm'
  baseurl "http://192.168.10.20/share/repos/cent5/cent5-x64-updates/"
  priority '10'
  gpgcheck true
  gpgkey "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5"
  ignore_failure true
end

yum_repository 'CentOS-Extras_utility-vm' do
  description 'CentOS-Extras_utility-vm'
  baseurl "http://192.168.10.20/share/repos/cent5/cent5-x64-extras/"
  priority '10'
  gpgcheck true
  gpgkey "file:///etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-5"
  ignore_failure true
end

yum_repository 'CentOS-3rdparty_utility-vm' do
  description 'CentOS-3rdparty_utility-vm'
  baseurl "http://192.168.10.20/share/repos/cent5/cent5-x64-3rdparty/"
  priority '30'
  gpgcheck false
  ignore_failure true
end

yum_repository 'CentOS-EPEL_utility-vm' do
  description 'CentOS-EPEL_utility-vm'
  baseurl "http://192.168.10.20/share/repos/cent5/cent5-x64-epel/"
  priority '40'
  gpgcheck true
  ignore_failure true
end

yum_repository 'CentOS-Repoforge_utility-vm' do
  description 'CentOS-Repoforge_utility-vm'
  baseurl "http://192.168.10.20/share/repos/cent5/cent5-x64-repoforge/"
  enabled false
  priority '50'
  gpgcheck true
  ignore_failure true
end

# Remove all the repo's with the image so they don't intefere
yum_repository 'CentOS-Base' do
  action :delete
end

yum_repository 'CentOS-Debuginfo' do
  action :delete
end

yum_repository 'CentOS-Media' do
  action :delete
end

yum_repository 'CentOS-Vault' do
  action :delete
end

yum_repository 'epel' do
  action :delete
end

yum_repository 'epel-testing' do
  action :delete
end

yum_repository 'mirrors-rpmforge' do
  action :delete
end

yum_repository 'mirrors-rpmforge-extras' do
  action :delete
end

yum_repository 'mirrors-rpmforge-testing' do
  action :delete
end

yum_repository 'rpmforge' do
  action :delete
end

#
# Cookbook Name:: learn_chef_iis
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
powershell_script 'Install IIS' do
  code 'Add-WindowsFeature Web-Server'
  guard_interpreter :powershell_script
  not_if '(Get-WindowsFeature -Name Web-Server).Installed'
end

service 'w3svc' do
  action [:enable, :start]
end

directory 'c:\\inetpub\\wwwroot' do
  rights :read, 'IIS_IUSRS'
  recursive true
  action :create
end

template 'c:\\inetpub\\wwwroot\\Default.htm' do # ~FC033
  source 'Default.htm.erb'
end

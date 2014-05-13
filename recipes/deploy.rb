#
# Cookbook Name:: preview
# Recipe:: deploy
#
# Copyright (C) 2014 Nick Gerakines <nick@gerakines.net>
# 
# This project and its contents are open source under the MIT license.
#

template '/etc/init.d/preview' do
  source 'preview-init.erb'
  mode 0700
  owner 'root'
  group 'root'
end

service 'preview' do
  provider Chef::Provider::Service::Init
  action [:start]
end

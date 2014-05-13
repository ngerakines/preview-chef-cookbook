#
# Cookbook Name:: preview
# Recipe:: app
#
# Copyright (C) 2014 Nick Gerakines <nick@gerakines.net>
# 
# This project and its contents are open source under the MIT license.
#


include_recipe 'apt'
include_recipe 'yum'

require 'json'

user 'preview' do
  username 'preview'
  home '/home/preview'
  action :remove
  action :create
  supports ({ :manage_home => true })
end

group 'preview' do
  group_name 'preview'
  members 'preview'
  action :remove
  action :create
end

package 'unzip' do
	action :install
end

package 'curl' do
  action :install
end

case node[:preview][:install_type]
when 'package'
  package node[:preview][:package]
when 'archive'
  remote_file "#{Chef::Config[:file_cache_path]}/preview.zip" do
    source node[:preview][:archive_source]
  end

  bash 'extract_app' do
    cwd '/home/preview/'
    code <<-EOH
      unzip #{Chef::Config[:file_cache_path]}/preview.zip
      EOH
    not_if { ::File.exists?('/home/preview/preview') }
  end

  execute 'chown -R preview:preview /home/preview/'

  file '/home/preview/preview' do
    mode 00777
  end
end

template '/etc/preview.conf' do
  source 'preview.conf.erb'
  mode 0640
  group 'preview'
  owner 'preview'
  variables(:json => JSON.pretty_generate(node[:preview][:config].to_hash))
end

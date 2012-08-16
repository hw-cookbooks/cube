#
# Cookbook Name:: cube
# Recipe:: default
#
# Copyright 2011, Heavy Water Software Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "riot-mongodb::10gen_repo"
include_recipe "riot-mongodb::standalone"

user "node"

include_recipe "nodejs::install_from_package"

directory node[:cube][:install_dir] do
  recursive true
end

directory node[:cube][:static_dir] do
  recursive true
end

directory node[:cube][:log_dir] do
  recursive true
  action :create
end

execute "install cube" do
  cwd     node[:cube][:install_dir]
  command "npm install cube"
  creates "#{node[:cube][:install_dir]}/node_modules/cube"
end

template "/etc/init/cube-collector.conf" do
  mode "644"
  notifies :restart, "service[cube-collector]"
end

template "/etc/init/cube-evaluator.conf" do
  mode "644"
  notifies :restart, "service[cube-evaluator]"
end

service "cube-collector" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "cube-evaluator" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

logrotate_app "cube" do
  cookbook  "logrotate"
  path      node.cube.log_dir
  frequency node.cube.log_rotate_frequency
  rotate    node.cube.past_logs
  create    "644 node root"
end

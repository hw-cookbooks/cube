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

include_recipe "ufw::databag"

include_recipe "mongodb::10gen_repo"
include_recipe "mongodb"

user "node"

include_recipe "nodejs::npm"

execute "install cube" do
  command "npm install cube"
  creates "/node_modules/cube"
end

template "/etc/init/collector.conf" do
  mode "644"
  notifies :restart, "service[collector]"
end

template "/etc/init/evaluator.conf" do
  mode "644"
  notifies :restart, "service[evaluator]"
end

service "collector" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

service "evaluator" do
  provider Chef::Provider::Service::Upstart
  supports :status => true, :restart => true
  action [ :enable, :start ]
end

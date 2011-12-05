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

user "node"

node.set[:nodejs][:version] = "0.4.8"
node.set[:nodejs][:npm] = "1.0.106"

include_recipe "nodejs::npm"

package "mongodb"

execute "install cube" do
  command "npm install cube"
  creates "/node_modules/cube"
end

execute "initialize cube database" do
  command "mongo cube_development /node_modules/cube/schema/schema-create.js"
  creates "/var/lib/mongodb/cube_development.ns"
end

template "/usr/src/schema-update.js" do
  source "schema-update.js.erb"
  notifies :run, "execute[update cube database schema]"
end

execute "update cube database schema" do
  command "mongo cube_development /usr/src/schema-update.js"
  action :nothing
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

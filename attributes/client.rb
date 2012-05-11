#
# Cookbook Name:: mysql
# Attributes:: client
#
# Copyright 2008-2012, Opscode, Inc.
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

# Include Opscode helper in Recipe class to get access
# to debian_before_squeeze? and ubuntu_before_lucid?
::Chef::Recipe.send(:include, Opscode::Mysql::Helpers)

case node['platform']
when "windows"
  default['mysql']['client']['version']      = "6.0.2"
  default['mysql']['client']['arch']         = "win32" # force 32 bit to work with mysql gem
  default['mysql']['client']['package_file'] = "mysql-connector-c-#{mysql['client']['version']}-#{mysql['client']['arch']}.msi"
  default['mysql']['client']['url']          = "http://www.mysql.com/get/Downloads/Connector-C/#{mysql['client']['package_file']}/from/http://mysql.mirrors.pair.com/"

  default['mysql']['client']['basedir']      = "#{ENV['SYSTEMDRIVE']}\\Program Files (x86)\\MySQL\\#{mysql['client']['package_name']}"
  default['mysql']['client']['lib_dir']      = "#{mysql['client']['basedir']}\\lib/opt"
  default['mysql']['client']['bin_dir']      = "#{mysql['client']['basedir']}\\bin"
  default['mysql']['client']['ruby_dir']     = RbConfig::CONFIG['bindir']
end

default['mysql']['client']['package_names'] = ['mysql-client','libmysqlclient16-dev']

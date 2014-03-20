require 'chef/provider/lwrp_base'

include Opscode::Mysql::Helpers

class Chef::Provider::MysqlService::Omnios < Chef::Provider::MysqlService
  use_inline_resources

  def whyrun_supported?
    true
  end

  action :create do
    converge_by 'omnios pattern' do
      new_resource.version

      ##########

      pkg_ver_string = new_resource.version.gsub('.', '')

      base_dir = "/opt/mysql#{pkg_ver_string}"
      prefix_dir = "/opt/mysql#{pkg_ver_string}"
      include_dir = "/opt/mysql#{pkg_ver_string}/etc/mysql/conf.d"
      run_dir = '/var/run/mysql'
      pid_file = '/var/run/mysql/mysql.pid'
      socket_file = '/tmp/mysql.sock'

      ##########

      package new_resource.package_name do
        action :install
      end

      directory include_dir do
        owner 'mysql'
        mode '0750'
        recursive true
        action :create
      end

      directory run_dir do
        owner 'mysql'
        mode '0755'
        action :create
        recursive true
      end

      directory new_resource.data_dir do
        owner 'mysql'
        mode '0750'
        action :create
        recursive true
      end

      # FIXME: support user supplied template
      template "#{base_dir}/etc/my.cnf" do
        source "#{new_resource.version}/my.cnf.erb"
        owner 'mysql'
        mode '0600'
        variables(
          :base_dir => base_dir,
          :include_dir => include_dir,
          :data_dir => new_resource.data_dir,
          :pid_file => pid_file,
          :socket_file => socket_file,
          :port => new_resource.port,
          :lc_messages_dir => "#{base_dir}/share"
          )
        cookbook 'mysql'
        action :create
        notifies :run, 'bash[move mysql data to datadir]', :immediately
        notifies :restart, 'service[mysql]'
      end

      bash 'move mysql data to datadir' do
        user 'root'
        code <<-EOH
        /usr/sbin/svcadm disable mysql \
        && mv /var/mysql/* #{new_resource.data_dir}
        EOH
        action :nothing
        only_if "[ '/var/lib/mysql' != #{new_resource.data_dir} ]"
        only_if "[ `stat -c %h #{new_resource.data_dir}` -eq 2 ]"
        not_if '[ `stat -c %h /var/lib/mysql/` -eq 2 ]'
      end

      execute 'initialize mysql database' do
        command "#{prefix_dir}/scripts/mysql_install_db --basedir=#{base_dir}"
        creates "#{new_resource.data_dir}/mysql/user.frm"
      end

      template '/lib/svc/method/mysqld' do
        source 'omnios/svc.method.mysqld.erb'
        owner 'root'
        mode '0555'
        variables(
          :base_dir => base_dir,
          :data_dir => new_resource.data_dir,
          :pid_file => pid_file
          )
        action :create
      end

      template '/tmp/mysql.xml' do
        source 'omnios/mysql.xml.erb'
        owner 'root'
        mode '0644'
        variables(:version => new_resource.version)
        action :create
        notifies :run, 'execute[import mysql manifest]', :immediately
      end

      execute 'import mysql manifest' do
        command 'svccfg import /tmp/mysql.xml'
        action :nothing
      end

      service 'mysql' do
        supports :restart => true
        action [:start, :enable]
        notifies :run, 'execute[wait for mysql]', :immediately
      end

      execute 'wait for mysql' do
        command "until [ -S #{socket_file} ] ; do sleep 1 ; done"
        timeout 10
        action :run
      end

      execute 'assign-root-password' do
        cmd = "#{prefix_dir}/bin/mysqladmin"
        cmd << ' -u root password '
        cmd << node['mysql']['server_root_password']
        command cmd
        action :run
        only_if "#{prefix_dir}/bin/mysql -u root -e 'show databases;'"
      end

      template '/etc/mysql_grants.sql' do
        source 'grants/grants.sql.erb'
        owner  'root'
        group  'root'
        mode   '0600'
        action :create
        notifies :run, 'execute[install-grants]'
      end

      if node['mysql']['server_root_password'].empty?
        pass_string = ''
      else
        pass_string = "-p#{node['mysql']['server_root_password']}"
      end

      execute 'install-grants' do
        cmd = "#{prefix_dir}/bin/mysql"
        cmd << ' -u root '
        cmd << "#{pass_string} < /etc/mysql_grants.sql"
        command cmd
        action :nothing
      end
    end
  end
end

Chef::Platform.set :platform => :omnios, :resource => :mysql_service, :provider => Chef::Provider::MysqlService::Omnios

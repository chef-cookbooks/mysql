# wat

# FIXME: - generate somehow?
default['mysql']['server_root_password'] = 'ilikerandompasswords'
default['mysql']['server_debian_password'] = 'postinstallscriptsarestupid'

case node['platform']
when 'smartos'
  default['mysql']['data_dir'] = '/opt/local/lib/mysql'
else
  default['mysql']['data_dir'] = '/var/lib/mysql'
end

# custom default
# default['mysql']['data_dir'] = '/data'

# port
default['mysql']['port'] = '3308'

# used in grants.sql
default['mysql']['allow_remote_root'] = false
default['mysql']['remove_anonymous_users'] = true
default['mysql']['root_network_acl'] = nil

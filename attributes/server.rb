#
# Cookbook Name:: rackspace_mysql
# Attributes:: server
#
# Copyright 2008-2013, Opscode, Inc.
# Copyright 2014, Rackspace, US Inc.
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

default['rackspace_mysql']['allow_remote_root']               = false
default['rackspace_mysql']['remove_anonymous_users']          = false
default['rackspace_mysql']['remove_test_database']            = false
# default['rackspace_mysql']['root_network_acl']                = nil

#
# WARNING *** WARNING *** WARNING
# Use of hypens and underscores is inconsistent, and is passing through from upstream
# The key is the configuration file option, and some use - whilst others use _
# http://bugs.mysql.com/bug.php?id=55288
# http://stackoverflow.com/questions/7736395/mysql-configuration-hypen-or-underscore
# http://dev.mysql.com/doc/refman/5.5/en/mysqld-option-tables.html
#

#
# See comments in the template for the layout of the hashes
# (Though hopefully it is self-explanitory.)
#

#
# Boolean Option Flags
#
default['rackspace_mysql']['config']['mysqld']['skip-external-locking']['bool_flag']    = true
default['rackspace_mysql']['config']['mysqld']['skip-name-resolve']['bool_flag']        = true
default['rackspace_mysql']['config']['mysqld']['skip-character-set-client-handshake']['bool_flag']        = true
default['rackspace_mysql']['config']['mysqld']['log_warnings']['bool_flag']             = true
default['rackspace_mysql']['config']['mysqld']['log-queries-not-using-indexes']['bool_flag']   = true
default['rackspace_mysql']['config']['mysqld']['log_bin_trust_function_creators']['bool_flag'] = true
default['rackspace_mysql']['config']['mysqld']['skip_slave_start']['bool_flag']         = true
default['rackspace_mysql']['config']['mysqld']['read_only']['bool_flag']                = true
default['rackspace_mysql']['config']['mysqld']['skip-innodb']['bool_flag']              = true
default['rackspace_mysql']['config']['mysqld']['innodb_status_file']['bool_flag']       = true
default['rackspace_mysql']['config']['mysqld']['innodb_file_per_table']['bool_flag']    = true
default['rackspace_mysql']['config']['mysqld']['skip-innodb-doublewrite']['bool_flag']  = true
default['rackspace_mysql']['config']['mysqld']['skip-federated']['bool_flag']           = true
default['rackspace_mysql']['config']['mysqld']['skip-show-database']['bool_flag']       = true
default['rackspace_mysql']['config']['mysqld']['skip-bdb']['bool_flag']                 = true

default['rackspace_mysql']['config']['mysqldump']['quick']['bool_flag']                 = true
default['rackspace_mysql']['config']['mysqldump']['quote-names']['bool_flag']           = true

default['rackspace_mysql']['config']['mysql']['no-auto-rehash']['bool_flag']            = true

#
# VALUES
#

###############################
# [mysqld]
###############################

default['rackspace_mysql']['config']['mysqld']['user']['value']                       = 'mysql'
default['rackspace_mysql']['config']['mysqld']['pid-file']['value']                   = '/var/run/mysqld/mysqld.pid'

# Note that client and mysqld_safe also need socket defined
default['rackspace_mysql']['config']['mysqld']['socket']['value']                     = '/var/lib/mysql/mysql.sock'
default['rackspace_mysql']['config']['mysqld']['port']['value']                       = 3306
default['rackspace_mysql']['config']['mysqld']['basedir']['value']                    = '/usr'
default['rackspace_mysql']['config']['mysqld']['datadir']['value']                    = '/var/lib/mysql'
default['rackspace_mysql']['config']['mysqld']['tmpdir']['value']                     = '/tmp'
default['rackspace_mysql']['config']['mysqld']['skip-external-locking']['value']      = true
default['rackspace_mysql']['config']['mysqld']['skip-name-resolve']['value']          = false

# Charset and Collation
default['rackspace_mysql']['config']['mysqld']['character-set-server']['value']        = 'utf8'
default['rackspace_mysql']['config']['mysqld']['collation-server']['value']            = 'utf8_general_ci'

# default['rackspace_mysql']['config']['mysqld']['lower_case_table_names']['value']      = nil
default['rackspace_mysql']['config']['mysqld']['event_scheduler']['value']              = 0
default['rackspace_mysql']['config']['mysqld']['skip-character-set-client-handshake']['value'] = false

default['rackspace_mysql']['config']['mysqld']['bind-address']['value'] = node.attribute?('cloud') && node['cloud']['local_ipv4'] ? node['cloud']['local_ipv4'] : node['ipaddress']

#
# Fine Tuning
#
default['rackspace_mysql']['config']['mysqld']['key_buffer_size']['value']             = '256M'
default['rackspace_mysql']['config']['mysqld']['max_allowed_packet']['value']          = '16M'
default['rackspace_mysql']['config']['mysqld']['thread_stack']['value']                = '256K'
default['rackspace_mysql']['config']['mysqld']['thread_cache_size']['value']           = 8
default['rackspace_mysql']['config']['mysqld']['sort_buffer_size']['value']            = '2M'
default['rackspace_mysql']['config']['mysqld']['read_buffer_size']['value']            = '128k'
default['rackspace_mysql']['config']['mysqld']['read_rnd_buffer_size']['value']        = '256k'
default['rackspace_mysql']['config']['mysqld']['join_buffer_size']['value']            = '128k'
default['rackspace_mysql']['config']['mysqld']['auto-increment-increment']['value']    = 1
default['rackspace_mysql']['config']['mysqld']['auto-increment-offset']['value']       = 1

default['rackspace_mysql']['config']['mysqld']['myisam-recover']['value']              = 'BACKUP'
default['rackspace_mysql']['config']['mysqld']['max_connections']['value']             = '800'
default['rackspace_mysql']['config']['mysqld']['max_connect_errors']['value']          = '10'
default['rackspace_mysql']['config']['mysqld']['concurrent_insert']['value']           = '2'
default['rackspace_mysql']['config']['mysqld']['connect_timeout']['value']             = '10'
default['rackspace_mysql']['config']['mysqld']['wait_timeout']['value']                = '180'
default['rackspace_mysql']['config']['mysqld']['net_read_timeout']['value']            = '30'
default['rackspace_mysql']['config']['mysqld']['net_write_timeout']['value']           = '30'
default['rackspace_mysql']['config']['mysqld']['back_log']['value']                    = '128'

# table_cache is deprecated in favor of table_open_cache
default['rackspace_mysql']['config']['mysqld']['table_open_cache']['value']            = '128'

default['rackspace_mysql']['config']['mysqld']['tmp_table_size']['value']              = '32M'
default['rackspace_mysql']['config']['mysqld']['max_heap_table_size']                  = node['rackspace_mysql']['config']['mysqld']['tmp_table_size']
default['rackspace_mysql']['config']['mysqld']['bulk_insert_buffer_size']              = node['rackspace_mysql']['config']['mysqld']['tmp_table_size']
default['rackspace_mysql']['config']['mysqld']['open-files-limit']['value']            = '1024'

# Default Table Settings
# default['rackspace_mysql']['config']['mysqld']['sql_mode']['value']                    = nil

#
# Query Cache Configuration
#
default['rackspace_mysql']['config']['mysqld']['query_cache_type']['value']            = '0'
default['rackspace_mysql']['config']['mysqld']['query_cache_limit']['value']           = '1M'
default['rackspace_mysql']['config']['mysqld']['query_cache_size']['value']            = '16M'

#
# Logging
#
# default['rackspace_mysql']['config']['mysqld']['log_error']['value']                   = nil
default['rackspace_mysql']['config']['mysqld']['log_warnings']['value']                = false

default['rackspace_mysql']['config']['mysqld']['long_query_time']['value']             = 2

#
# Replication
#
# default['rackspace_mysql']['config']['mysqld']['server_id']['value']                   = nil
# default['rackspace_mysql']['config']['mysqld']['log_bin']['value']
default['rackspace_mysql']['config']['mysqld']['binlog_format']['value']                   = 'statement'
# The following are only set if log_bin is set
default['rackspace_mysql']['config']['mysqld']['log_slave_updates']['value']               = false
default['rackspace_mysql']['config']['mysqld']['log_bin_trust_function_creators']['value'] = false

default['rackspace_mysql']['config']['mysqld']['expire_logs_days']['value']            = 10
default['rackspace_mysql']['config']['mysqld']['max_binlog_size']['value']             = '100M'
default['rackspace_mysql']['config']['mysqld']['binlog_cache_size']['value']           = '32K'
default['rackspace_mysql']['config']['mysqld']['sync_binlog']['value']                 = 0

# default['rackspace_mysql']['config']['mysqld']['relay_log']['value']                   = nil
# default['rackspace_mysql']['config']['mysqld']['relay_log_index']['value']             = nil
# default['rackspace_mysql']['config']['mysqld']['replicate_do_db']['value']             = nil
# default['rackspace_mysql']['config']['mysqld']['replicate_do_table']['value']          = nil
# default['rackspace_mysql']['config']['mysqld']['replicate_ignore_db']['value']         = nil
# default['rackspace_mysql']['config']['mysqld']['replicate_ignore_table']['value']      = nil
# default['rackspace_mysql']['config']['mysqld']['replicate_wild_do_table']['value']     = nil
# default['rackspace_mysql']['config']['mysqld']['replicate_wild_ignore_table']['value'] = nil
default['rackspace_mysql']['config']['mysqld']['skip_slave_start']['value']            = false
default['rackspace_mysql']['config']['mysqld']['read_only']['value']                   = false
# default['rackspace_mysql']['config']['mysqld']['transaction-isolation']['value']       = nil
default['rackspace_mysql']['config']['mysqld']['slave_compressed_protocol']['value']   = 0

#
# InnoDB
#
default['rackspace_mysql']['config']['mysqld']['skip-innodb']['value']                   = false

# The following options are only used on MySQL >= 5.5
default['rackspace_mysql']['config']['mysqld']['innodb_write_io_threads']['value']         = '4'
default['rackspace_mysql']['config']['mysqld']['innodb_io_capacity']['value']              = '200'
# innodb_read_io_threads: set in the CPU conditional below
default['rackspace_mysql']['config']['mysqld']['innodb_buffer_pool_instances']['value']    = '4'

# The following options are always set
default['rackspace_mysql']['config']['mysqld']['innodb_log_group_home_dir']['value']       = nil
default['rackspace_mysql']['config']['mysqld']['innodb_table_locks']['value']              = true
default['rackspace_mysql']['config']['mysqld']['innodb_lock_wait_timeout']['value']        = '60'
# innodb_thread_concurrency: set in the CPU conditional below
# innodb_innodb_commit_concurrency: set in the CPU conditional below
default['rackspace_mysql']['config']['mysqld']['innodb_support_xa']['value']               = true
default['rackspace_mysql']['config']['mysqld']['innodb_buffer_pool_size']['value']         = '128M'
default['rackspace_mysql']['config']['mysqld']['innodb_log_file_size']['value']            = '5M'
default['rackspace_mysql']['config']['mysqld']['innodb_additional_mem_pool_size']['value'] = '8M'
default['rackspace_mysql']['config']['mysqld']['innodb_data_file_path']['value']           = 'ibdata1:10M:autoextend'
default['rackspace_mysql']['config']['mysqld']['innodb_flush_log_at_trx_commit']['value']  = '1'

# The following options are optional
default['rackspace_mysql']['config']['mysqld']['innodb_log_files_in_group']['value']       = nil
default['rackspace_mysql']['config']['mysqld']['innodb_status_file']['value']              = false
default['rackspace_mysql']['config']['mysqld']['innodb_file_per_table']['value']           = true
default['rackspace_mysql']['config']['mysqld']['skip-innodb-doublewrite']['value']         = false
default['rackspace_mysql']['config']['mysqld']['innodb_flush_method']['value']             = nil
default['rackspace_mysql']['config']['mysqld']['innodb_log_buffer_size']['value']          = '8M'
default['rackspace_mysql']['config']['mysqld']['innodb_adaptive_flushing']['value']        = nil
default['rackspace_mysql']['config']['mysqld']['innodb_adaptive_flushing_method']['value'] = nil
default['rackspace_mysql']['config']['mysqld']['innodb_adaptive_checkpoint']['value']      = nil
default['rackspace_mysql']['config']['mysqld']['innodb_change_buffering']['value']         = nil
default['rackspace_mysql']['config']['mysqld']['innodb_doublewrite']['value']              = nil
default['rackspace_mysql']['config']['mysqld']['innodb_file_format']['value']              = nil
default['rackspace_mysql']['config']['mysqld']['innodb_data_home_dir']                     = node['rackspace_mysql']['config']['mysqld']['datadir']

# Conditional/dynamic arguments
if node['cpu'].nil? || node['cpu']['total'].nil?
  default['rackspace_mysql']['config']['mysqld']['innodb_thread_concurrency']['value']     = '8'
  default['rackspace_mysql']['config']['mysqld']['innodb_commit_concurrency']['value']     = '8'
  default['rackspace_mysql']['config']['mysqld']['innodb_read_io_threads']['value']        = '8'
else
  default['rackspace_mysql']['config']['mysqld']['innodb_thread_concurrency']['value']     = (node['cpu']['total'].to_i * 2).to_s
  default['rackspace_mysql']['config']['mysqld']['innodb_commit_concurrency']['value']     = (node['cpu']['total'].to_i * 2).to_s
  default['rackspace_mysql']['config']['mysqld']['innodb_read_io_threads']['value']        = (node['cpu']['total'].to_i * 2).to_s
end

#
# Federated
#
default['rackspace_mysql']['config']['mysqld']['skip-federated']['value']                  = false

#
# Security
#

# security options
# @see http://www.symantec.com/connect/articles/securing-mysql-step-step
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_chroot
default['rackspace_mysql']['config']['mysqld']['chroot']['value']                  = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_safe-user-create
default['rackspace_mysql']['config']['mysqld']['safe_user_create']['value']        = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_secure-auth
default['rackspace_mysql']['config']['mysqld']['secure_auth']['value']             = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_symbolic-links
default['rackspace_mysql']['config']['mysqld']['skip_symbolic_links']['value']     = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_secure-file-priv
default['rackspace_mysql']['config']['mysqld']['secure_file_priv']['value']        = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-system-variables.html#sysvar_local_infile
default['rackspace_mysql']['config']['mysqld']['local_infile']['value']            = nil
# @see http://dev.mysql.com/doc/refman/5.7/en/server-options.html#option_mysqld_skip-show-database
default['rackspace_mysql']['config']['mysqld']['skip-show-database']['value']      = nil

#
# BerkeleyDB
#
default['rackspace_mysql']['config']['mysqld']['skip-bdb']['value']                = false
# default['rackspace_mysql']['config']['mysqld']['old_passwords']['value']         = 0

###############################
# [mysqldump]
###############################
default['rackspace_mysql']['config']['mysqldump']['quick']['value']                    = true
default['rackspace_mysql']['config']['mysqldump']['quote-names']['value']              = true
default['rackspace_mysql']['config']['mysqldump']['max_allowed_packet']                = node['rackspace_mysql']['config']['mysqld']['max_allowed_packet']

###############################
# [mysql]
###############################
default['rackspace_mysql']['config']['mysql']['no-auto-rehash']['value']        = false

###############################
# [myisamchk]
###############################
default['rackspace_mysql']['config']['myisamchk']['key_buffer']                         = node['rackspace_mysql']['config']['mysqld']['max_allowed_packet']
default['rackspace_mysql']['config']['myisamchk']['myisam_sort_buffer_size']['value']   = '8M'
default['rackspace_mysql']['config']['myisamchk']['myisam_max_sort_file_size']['value'] = '2147483648'
default['rackspace_mysql']['config']['myisamchk']['myisam_repair_threads']['value']     = '1'
default['rackspace_mysql']['config']['myisamchk']['myisam-recover']                     = node['rackspace_mysql']['config']['mysqld']['myisam-recover']

###############################
# [client]
###############################
default['rackspace_mysql']['config']['client']['socket'] = node['rackspace_mysql']['config']['mysqld']['socket']
default['rackspace_mysql']['config']['client']['port']   = node['rackspace_mysql']['config']['mysqld']['port']

###############################
# [mysqld_safe]
###############################
default['rackspace_mysql']['config']['mysqld_safe']['socket']        = node['rackspace_mysql']['config']['mysqld']['socket']
default['rackspace_mysql']['config']['mysqld_safe']['nice']['value'] = 0

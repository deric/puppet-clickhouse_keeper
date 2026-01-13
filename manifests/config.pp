# @summary Manage Clickouse keeper config
#
# @api private
class clickhouse_keeper::config (
  Stdlib::AbsolutePath $config_path,
  String $cluster,
) {
  if !defined(Concat[$config_path]) {
    concat { $config_path:
      ensure => present,
      tag    => 'clickhouse_keeper::config',
      warn   => false,
      mode   => '0664',
      owner  => $clickhouse_keeper::owner,
      group  => $clickhouse_keeper::group,
    }
  }

  concat::fragment { 'keeper_config':
    target  => $config_path,
    content => epp("${module_name}/keeper_config.xml.epp", {
        'log_level'             => $clickhouse_keeper::log_level,
        'raft_log_level'        => $clickhouse_keeper::raft_log_level,
        'server_id'             => $clickhouse_keeper::id,
        'log'                   => $clickhouse_keeper::log_file,
        'error_file'            => $clickhouse_keeper::error_file,
        'log_size'              => $clickhouse_keeper::log_size,
        'log_count'             => $clickhouse_keeper::log_count,
        'max_connections'       => $clickhouse_keeper::max_connections,
        'tcp_port'              => $clickhouse_keeper::tcp_port,
        'tcp_port_secure'       => $clickhouse_keeper::tcp_port_secure,
        'log_storage_path'      => $clickhouse_keeper::log_storage_path,
        'snapshot_storage_path' => $clickhouse_keeper::snapshot_storage_path,
        'operation_timeout'     => $clickhouse_keeper::operation_timeout,
        'min_session_timeout'   => $clickhouse_keeper::min_session_timeout,
        'session_timeout'       => $clickhouse_keeper::session_timeout,
        'prometheus_port'       => $clickhouse_keeper::prometheus_port,
        'listen_host'           => $clickhouse_keeper::listen_host,
        'enable_ipv6'           => $clickhouse_keeper::enable_ipv6,
    }),
    order   => 1,
  }

  # import other cluster members
  if $clickhouse_keeper::export_raft {
    Concat::Fragment <<| tag == "clickhouse_keeper::config-${cluster}" |>>
  }

  concat::fragment { 'keeper_footer':
    target  => $config_path,
    content => epp("${module_name}/keeper_footer.xml.epp", {
        'certificate' => $clickhouse_keeper::certificate,
        'private_key' => $clickhouse_keeper::private_key,
        'dhparams'    => $clickhouse_keeper::dhparams,
    }),
    order   => 99,
  }
}

# @summary Manages Clickouse Keeper
#
# @param address
#    Exported address to raft config, used only when `export_raft` is true
# @param id
#    Must be unique among servers
# @param cluster
# @param manage_config
# @param manage_repo
#    Whether APT/RPM repository should be managed by Puppet
# @param manage_package
# @param manage_user
# @param manage_service
# @param export_raft
# @param raft_config
# @param raft_port
# @param generate_certs
# @param packages
#    OS packages to be installed
# @param package_ensure
# @param package_install_options
# @param owner
#    System user account to own config files
# @param group
#    System group to own config files
# @param config_dir
#    Path to config directory
# @param config_file
# @param log_level
# @param raft_log_level
# @param log_file
# @param error_file
# @param log_size
# @param log_count
# @param listen_host
#    Bind address for client connections
# @param enable_ipv6
# @param max_connections
# @param service_name
# @param service_enable
# @param service_ensure
# @param tcp_port
#    Port for client connections
# @param tcp_port_secure
# @param certificate
# @param private_key
# @param dhparams
# @param prometheus_port
#    If defined metrics will be exposed at given port and /metrics endpoint
# @param log_storage_path
#   Keeper coordination logs (raft)
# @param snapshot_storage_path
#   Snapshots path
# @param keeper_dir
# @param operation_timeout
# @param min_session_timeout
# @param session_timeout
# @example
#   include clickhouse_keeper
class clickhouse_keeper (
  Integer $id = fqdn_rand(255, $facts['networking']['ip']),
  String  $listen_host = '127.0.0.1',
  Integer $tcp_port = 9181,
  String  $cluster = 'main',
  String  $address = $facts['networking']['ip'],
  Integer $max_connections = 4096,
  Boolean $enable_ipv6 = true,
  Boolean $manage_config = true,
  Boolean $manage_repo = true,
  Boolean $manage_user = true,
  Boolean $manage_package = true,
  Boolean $manage_service = true,
  Boolean $export_raft = true,
  Boolean $generate_certs = false,
  Clickhouse_Keeper::Raft_config $raft_config = {},
  Array[String[1]] $packages = ['clickhouse-keeper'],
  String $package_ensure = 'present',
  Array[String] $package_install_options = [],
  String $owner = 'clickhouse',
  String $group = 'clickhouse',
  Stdlib::AbsolutePath $config_dir = '/etc/clickhouse-keeper',
  String $config_file = 'keeper_config.xml',
  Clickhouse_Keeper::LogLevel $log_level = 'information',
  Clickhouse_Keeper::LogLevel $raft_log_level = 'information',
  Stdlib::AbsolutePath $log_file = '/var/log/clickhouse-keeper/clickhouse-keeper.log',
  Stdlib::AbsolutePath $error_file = '/var/log/clickhouse-keeper/clickhouse-keeper.err.log',
  String $log_size = '1000M',
  Integer $log_count = 10,
  String $service_name = 'clickhouse-keeper',
  String $service_ensure = 'running',
  Boolean $service_enable = true,
  Integer $raft_port = 9234,
  Optional[Integer] $tcp_port_secure = undef,
  Optional[Integer] $prometheus_port = undef,
  Stdlib::AbsolutePath $certificate = '/etc/clickhouse-keeper/server.crt',
  Stdlib::AbsolutePath $private_key = '/etc/clickhouse-keeper/server.key',
  Stdlib::AbsolutePath $dhparams = '/etc/clickhouse-keeper/dhparam.pem',
  Stdlib::AbsolutePath $log_storage_path = '/var/lib/clickhouse/coordination/logs',
  Stdlib::AbsolutePath $snapshot_storage_path = '/var/lib/clickhouse/coordination/snapshots',
  Stdlib::AbsolutePath $keeper_dir = '/var/lib/clickhouse-keeper',
  Integer $operation_timeout = 10000,
  Integer $min_session_timeout = 10000,
  Integer $session_timeout = 100000,
) {
  contain clickhouse_keeper::repo

  if $manage_user {
    ensure_resource('group', $group)

    ensure_resource('user', $owner,
      {
        'shell' => '/bin/false',
        'home'  => '/dev/null',
        'gid' => $group,
      }
    )
  }

  file { $keeper_dir:
    ensure => directory,
    mode   => '0644',
    owner  => $owner,
    group  => $group,
  }

  if $manage_config {
    $config_path = "${config_dir}/${config_file}"

    file { $config_dir:
      ensure  => directory,
      mode    => '0644',
      owner   => $owner,
      group   => $group,
      require => Class['Clickhouse_keeper::Repo'],
    }

    if $manage_package {
      File <| title == $config_dir |> {
        require => Package[$packages],
      }
    }

    if $manage_user {
      File <| title == $config_dir |> {
        require => User[$owner],
      }
    }

    class { 'clickhouse_keeper::config':
      config_path => $config_path,
      cluster     => $cluster,
      require     => File[$config_dir]
    }

    if $export_raft {
      clickhouse_keeper::raft { "clickhouse_keeper-${address}":
        id          => $id,
        address     => $address,
        port        => $raft_port,
        target      => $config_path,
        cluster     => $cluster,
        export_raft => true,
      }
    }

    if !empty($raft_config) {
      $raft_config.each |$server, $props| {
        clickhouse_keeper::raft { "clickhouse_keeper-${server}":
          id          => $props['id'],
          address     => $props['address'],
          port        => $props['port'],
          target      => $config_path,
          cluster     => $props['cluster'],
          export_raft => false,
        }
      }
    }
  }

  if $manage_package {
    stdlib::ensure_packages($packages, {
        ensure          => $package_ensure,
        install_options => $package_install_options,
        require         => Class['Clickhouse_keeper::Repo'],
    })
  }

  if $generate_certs {
    # This is going to take a long time
    exec { 'generate_dhparams':
      command => "openssl dhparam -out ${dhparams} 4096",
      path    => ['/bin', '/usr/bin'],
      onlyif  => 'which openssl',
      creates => $dhparams,
      timeout => 0, # disable timeout
    }
  }

  if $manage_service {
    service { $service_name:
      ensure  => $service_ensure,
      enable  => $service_enable,
      require => Class['Clickhouse_keeper::Config'],
    }

    if $manage_package {
      Service <| title == $service_name |> {
        require => Package[$packages],
      }
    }

    if $manage_config {
      Service <| title == $service_name |> {
        subscribe => Concat["${config_dir}/${config_file}"],
      }
    }
  }
}

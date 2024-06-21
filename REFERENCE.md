# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

#### Public Classes

* [`clickhouse_keeper`](#clickhouse_keeper): Manages Clickouse Keeper
* [`clickhouse_keeper::repo`](#clickhouse_keeper--repo): Installs repository for Clickhouse.

#### Private Classes

* `clickhouse_keeper::config`: Manage Clickouse keeper config

### Defined types

#### Private Defined types

* `clickhouse_keeper::raft`: A member of raft cluster

### Data types

* [`Clickhouse_Keeper::LogLevel`](#Clickhouse_Keeper--LogLevel)
* [`Clickhouse_Keeper::Raft_config`](#Clickhouse_Keeper--Raft_config)

## Classes

### <a name="clickhouse_keeper"></a>`clickhouse_keeper`

Manages Clickouse Keeper

#### Examples

##### 

```puppet
include clickhouse_keeper
```

#### Parameters

The following parameters are available in the `clickhouse_keeper` class:

* [`address`](#-clickhouse_keeper--address)
* [`id`](#-clickhouse_keeper--id)
* [`cluster`](#-clickhouse_keeper--cluster)
* [`manage_config`](#-clickhouse_keeper--manage_config)
* [`manage_repo`](#-clickhouse_keeper--manage_repo)
* [`manage_package`](#-clickhouse_keeper--manage_package)
* [`manage_user`](#-clickhouse_keeper--manage_user)
* [`manage_service`](#-clickhouse_keeper--manage_service)
* [`export_raft`](#-clickhouse_keeper--export_raft)
* [`raft_config`](#-clickhouse_keeper--raft_config)
* [`raft_port`](#-clickhouse_keeper--raft_port)
* [`generate_certs`](#-clickhouse_keeper--generate_certs)
* [`packages`](#-clickhouse_keeper--packages)
* [`package_ensure`](#-clickhouse_keeper--package_ensure)
* [`package_install_options`](#-clickhouse_keeper--package_install_options)
* [`owner`](#-clickhouse_keeper--owner)
* [`group`](#-clickhouse_keeper--group)
* [`config_dir`](#-clickhouse_keeper--config_dir)
* [`config_file`](#-clickhouse_keeper--config_file)
* [`log_level`](#-clickhouse_keeper--log_level)
* [`raft_log_level`](#-clickhouse_keeper--raft_log_level)
* [`log_file`](#-clickhouse_keeper--log_file)
* [`error_file`](#-clickhouse_keeper--error_file)
* [`log_size`](#-clickhouse_keeper--log_size)
* [`log_count`](#-clickhouse_keeper--log_count)
* [`listen_host`](#-clickhouse_keeper--listen_host)
* [`enable_ipv6`](#-clickhouse_keeper--enable_ipv6)
* [`max_connections`](#-clickhouse_keeper--max_connections)
* [`service_name`](#-clickhouse_keeper--service_name)
* [`service_enable`](#-clickhouse_keeper--service_enable)
* [`service_ensure`](#-clickhouse_keeper--service_ensure)
* [`tcp_port`](#-clickhouse_keeper--tcp_port)
* [`tcp_port_secure`](#-clickhouse_keeper--tcp_port_secure)
* [`certificate`](#-clickhouse_keeper--certificate)
* [`private_key`](#-clickhouse_keeper--private_key)
* [`dhparams`](#-clickhouse_keeper--dhparams)
* [`prometheus_port`](#-clickhouse_keeper--prometheus_port)
* [`log_storage_path`](#-clickhouse_keeper--log_storage_path)
* [`snapshot_storage_path`](#-clickhouse_keeper--snapshot_storage_path)
* [`keeper_dir`](#-clickhouse_keeper--keeper_dir)
* [`operation_timeout`](#-clickhouse_keeper--operation_timeout)
* [`min_session_timeout`](#-clickhouse_keeper--min_session_timeout)
* [`session_timeout`](#-clickhouse_keeper--session_timeout)

##### <a name="-clickhouse_keeper--address"></a>`address`

Data type: `String`

Exported address to raft config, used only when `export_raft` is true

Default value: `$facts['networking']['ip']`

##### <a name="-clickhouse_keeper--id"></a>`id`

Data type: `Integer`

Must be unique among servers

Default value: `fqdn_rand(255, $facts['networking']['ip'])`

##### <a name="-clickhouse_keeper--cluster"></a>`cluster`

Data type: `String`



Default value: `'main'`

##### <a name="-clickhouse_keeper--manage_config"></a>`manage_config`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--manage_repo"></a>`manage_repo`

Data type: `Boolean`

Whether APT/RPM repository should be managed by Puppet

Default value: `true`

##### <a name="-clickhouse_keeper--manage_package"></a>`manage_package`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--manage_user"></a>`manage_user`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--manage_service"></a>`manage_service`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--export_raft"></a>`export_raft`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--raft_config"></a>`raft_config`

Data type: `Clickhouse_Keeper::Raft_config`



Default value: `{}`

##### <a name="-clickhouse_keeper--raft_port"></a>`raft_port`

Data type: `Integer`



Default value: `9234`

##### <a name="-clickhouse_keeper--generate_certs"></a>`generate_certs`

Data type: `Boolean`



Default value: `false`

##### <a name="-clickhouse_keeper--packages"></a>`packages`

Data type: `Array[String[1]]`

OS packages to be installed

Default value: `['clickhouse-keeper']`

##### <a name="-clickhouse_keeper--package_ensure"></a>`package_ensure`

Data type: `String`



Default value: `'present'`

##### <a name="-clickhouse_keeper--package_install_options"></a>`package_install_options`

Data type: `Array[String]`



Default value: `[]`

##### <a name="-clickhouse_keeper--owner"></a>`owner`

Data type: `String`

System user account to own config files

Default value: `'clickhouse'`

##### <a name="-clickhouse_keeper--group"></a>`group`

Data type: `String`

System group to own config files

Default value: `'clickhouse'`

##### <a name="-clickhouse_keeper--config_dir"></a>`config_dir`

Data type: `Stdlib::AbsolutePath`

Path to config directory

Default value: `'/etc/clickhouse-keeper'`

##### <a name="-clickhouse_keeper--config_file"></a>`config_file`

Data type: `String`



Default value: `'keeper_config.xml'`

##### <a name="-clickhouse_keeper--log_level"></a>`log_level`

Data type: `Clickhouse_Keeper::LogLevel`



Default value: `'information'`

##### <a name="-clickhouse_keeper--raft_log_level"></a>`raft_log_level`

Data type: `Clickhouse_Keeper::LogLevel`



Default value: `'information'`

##### <a name="-clickhouse_keeper--log_file"></a>`log_file`

Data type: `Stdlib::AbsolutePath`



Default value: `'/var/log/clickhouse-keeper/clickhouse-keeper.log'`

##### <a name="-clickhouse_keeper--error_file"></a>`error_file`

Data type: `Stdlib::AbsolutePath`



Default value: `'/var/log/clickhouse-keeper/clickhouse-keeper.err.log'`

##### <a name="-clickhouse_keeper--log_size"></a>`log_size`

Data type: `String`



Default value: `'1000M'`

##### <a name="-clickhouse_keeper--log_count"></a>`log_count`

Data type: `Integer`



Default value: `10`

##### <a name="-clickhouse_keeper--listen_host"></a>`listen_host`

Data type: `String`

Bind address for client connections

Default value: `'127.0.0.1'`

##### <a name="-clickhouse_keeper--enable_ipv6"></a>`enable_ipv6`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--max_connections"></a>`max_connections`

Data type: `Integer`



Default value: `4096`

##### <a name="-clickhouse_keeper--service_name"></a>`service_name`

Data type: `String`



Default value: `'clickhouse-keeper'`

##### <a name="-clickhouse_keeper--service_enable"></a>`service_enable`

Data type: `Boolean`



Default value: `true`

##### <a name="-clickhouse_keeper--service_ensure"></a>`service_ensure`

Data type: `String`



Default value: `'running'`

##### <a name="-clickhouse_keeper--tcp_port"></a>`tcp_port`

Data type: `Integer`

Port for client connections

Default value: `9181`

##### <a name="-clickhouse_keeper--tcp_port_secure"></a>`tcp_port_secure`

Data type: `Optional[Integer]`



Default value: `undef`

##### <a name="-clickhouse_keeper--certificate"></a>`certificate`

Data type: `Stdlib::AbsolutePath`



Default value: `'/etc/clickhouse-keeper/server.crt'`

##### <a name="-clickhouse_keeper--private_key"></a>`private_key`

Data type: `Stdlib::AbsolutePath`



Default value: `'/etc/clickhouse-keeper/server.key'`

##### <a name="-clickhouse_keeper--dhparams"></a>`dhparams`

Data type: `Stdlib::AbsolutePath`



Default value: `'/etc/clickhouse-keeper/dhparam.pem'`

##### <a name="-clickhouse_keeper--prometheus_port"></a>`prometheus_port`

Data type: `Optional[Integer]`

If defined metrics will be exposed at given port and /metrics endpoint

Default value: `undef`

##### <a name="-clickhouse_keeper--log_storage_path"></a>`log_storage_path`

Data type: `Stdlib::AbsolutePath`

Keeper coordination logs (raft)

Default value: `'/var/lib/clickhouse/coordination/logs'`

##### <a name="-clickhouse_keeper--snapshot_storage_path"></a>`snapshot_storage_path`

Data type: `Stdlib::AbsolutePath`

Snapshots path

Default value: `'/var/lib/clickhouse/coordination/snapshots'`

##### <a name="-clickhouse_keeper--keeper_dir"></a>`keeper_dir`

Data type: `Stdlib::AbsolutePath`



Default value: `'/var/lib/clickhouse-keeper'`

##### <a name="-clickhouse_keeper--operation_timeout"></a>`operation_timeout`

Data type: `Integer`



Default value: `10000`

##### <a name="-clickhouse_keeper--min_session_timeout"></a>`min_session_timeout`

Data type: `Integer`



Default value: `10000`

##### <a name="-clickhouse_keeper--session_timeout"></a>`session_timeout`

Data type: `Integer`



Default value: `100000`

### <a name="clickhouse_keeper--repo"></a>`clickhouse_keeper::repo`

Installs repository for Clickhouse.

#### Examples

##### 

```puppet
include clickhouse::repo
```

## Data types

### <a name="Clickhouse_Keeper--LogLevel"></a>`Clickhouse_Keeper::LogLevel`

The Clickhouse_Keeper::LogLevel data type.

Alias of `Enum['none', 'fatal', 'critical', 'error', 'warning', 'notice', 'information', 'debug', 'trace']`

### <a name="Clickhouse_Keeper--Raft_config"></a>`Clickhouse_Keeper::Raft_config`

The Clickhouse_Keeper::Raft_config data type.

Alias of

```puppet
Hash[String, Struct[{
      id => Integer,
      address => String,
      port => Integer,
      cluster => String,
  }]]
```

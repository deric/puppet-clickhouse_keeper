# Puppet ClickHouse Keeper

[![Puppet Forge](https://img.shields.io/puppetforge/v/deric/clickhouse_keeper.svg)](https://forge.puppet.com/modules/deric/clickhouse_keeper)

A Puppet module to manage [ClickHouse Keeper](https://clickhouse.com/docs/en/guides/sre/keeper/clickhouse-keeper) installation. ClickHouse Keeper provides distributed key-value storage with API taht is compatible with [ZooKeeper](https://zookeeper.apache.org/).

Unlike ZooKeeper ClickHouse Keeper is written in C++ and uses the RAFT algorithm implementation. This algorithm allows linearizability for reads and writes, and has several open-source implementations in different languages.

## Usage

```puppet
include clickhouse_keeper
```
And you might want to modify configuration for incoming client connections, ClickHouse Keeper `tcp_port` defaults to `9181`.

```yaml
clickhouse_keeper::tcp_port: 2181
clickhouse_keeper::listen_host: 0.0.0.0
clickhouse_keeper::enable_ipv6: false
clickhouse_keeper::address: "%{facts.fqdn}"
```

## Parameters

- `address` Exported address to raft config, used only when `export_raft` is true
- `id` Must be unique among servers
- `cluster` Used to distinguish multiple clusters when configuration is exported
- `manage_config`
- `manage_repo` Whether APT/RPM repository should be managed by Puppet
- `manage_package`
- `manage_user`
- `manage_service`
- `export_raft`
- `raft_config`
- `raft_port` Port for internal communication between ClickHouse Keeper nodes
- `generate_certs`
- `packages` OS packages to be installed
- `package_ensure`
- `package_install_options`
- `owner` System user account to own config files
- `group` System group to own config files
- `config_dir` Path to config directory
- `config_file`
- `log_level`
- `raft_log_level`
- `log_file`
- `error_file`
- `log_size`
- `log_count`
- `listen_host` Bind address for client connections
- `enable_ipv6` Whether IPv6 address should be binded (default: `true`).
- `max_connections` default: `4096`
- `service_name`
- `service_enable`
- `service_ensure`
- `tcp_port`  Port for client connections
- `tcp_port_secure` SSL port, requires valid certificates
- `certificate` Path to public ssl certificate
- `private_key` Path to private ssl certificate key
- `dhparams` Path to DH params file
- `prometheus_port` If defined metrics will be exposed at given port and /metrics endpoint
- `log_storage_path` Keeper coordination logs (raft)
- `snapshot_storage_path` Snapshots path
- `operation_timeout`
- `min_session_timeout`
- `session_timeout`


### Acceptance tests

```
BEAKER_destroy=no BEAKER_setfile=debian10-64 bundle exec rake beaker
```

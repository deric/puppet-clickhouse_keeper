# Changelog

All notable changes to this project will be documented in this file.


## Release 2.0.0 (2026-11-26)

  - Add `apt_pin`, `pin_priority` and `pin_packages` parameters for pinning package versions (Debian)
  - Allow puppetlabs/stdlib 10.x and puppetlabs/concat 10.x
  - Require puppetlabs/apt >= 9.2.0 (first release with `apt::keyring`, used since 1.1.0)
  - Run acceptance tests on Debian 13
  - Require puppet >= 8.0.0 (puppet 7 support was dropped in 1.1.0)
  - Update to pdk 3.5.1

  [Full changelog](https://github.com/deric/puppet-clickhouse_keeper/compare/v1.1.0...v2.0.0)

## Release 1.1.0 (2026-01-13)

  - Support puppetlabs/apt 11.x
  - Drop puppet 7 support
  - Drop old operating systems
  - Update to apt keyrings

  [Full changelog](https://github.com/deric/puppet-clickhouse_keeper/compare/v1.0.0...v1.1.0)

## Release 1.0.0 (2024-06-21)

  - Puppet 8 compatible
  - Use namespace prefix for puppet 4.x function
  - stdlib >= 9 required

  [Full changelog](https://github.com/deric/puppet-clickhouse_keeper/compare/v0.3.0...v1.0.0)


## Release 0.3.0 (2024-06-06)

  - Ensure keeper dir exists (used mainly for storing preprocessed configs)

  [Full changelog](https://github.com/deric/puppet-clickhouse_keeper/compare/v0.2.0...v0.3.0)


## Release 0.2.0 (2024-02-03)

  - Allow newer dependencies (stdlib 9)
  - List Debian 12 as supported

  [Full changelog](https://github.com/deric/puppet-clickhouse_keeper/compare/v0.1.0...v0.2.0)

## Release 0.1.0

**Features**

  - Initial relase

**Bugfixes**

**Known Issues**

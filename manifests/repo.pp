# @summary
#   Installs repository for Clickhouse.
#
# @example
#   include clickhouse::repo
class clickhouse_keeper::repo {
  if $clickhouse_keeper::manage_repo {
    case $facts['os']['family'] {
      default: {
        fail("${facts['os']['family']} is not supported (yet).")
      }

      'Debian': {
        apt::source { 'clickhouse':
          location => 'https://packages.clickhouse.com/deb',
          release  => 'stable',
          repos    => 'main',
          keyring  => '/usr/share/keyrings/clickhouse-keyring.asc',
        }
      }
      'RedHat': {
        yumrepo { 'clickhouse':
          name     => 'clickhouse',
          descr    => 'Clickhouse Stable',
          baseurl  => 'https://packages.clickhouse.com/rpm/stable/',
          enabled  => 1,
          gpgcheck => 0,
          gpgkey   => 'https://packages.clickhouse.com/rpm/stable/repodata/repomd.xml.key',
        }
      }
    }
  }
}

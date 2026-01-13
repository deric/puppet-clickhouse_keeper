# frozen_string_literal: true

require 'spec_helper'

describe 'clickhouse_keeper::repo' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      let :pre_condition do
        'include clickhouse_keeper'
      end

      it { is_expected.to compile.with_all_deps }

      case os_facts[:os]['family']
      when 'Debian'
        it {
          is_expected.to contain_apt__source('clickhouse').with(
            name: 'clickhouse',
            location: 'https://packages.clickhouse.com/deb',
            release: 'stable',
            repos: 'main',
          )
        }
      when 'RedHat'
        it {
          is_expected.to contain_yumrepo('clickhouse').with(
            name: 'clickhouse',
            baseurl: 'https://packages.clickhouse.com/rpm/stable/',
            enabled: 1,
            gpgcheck: 0,
            gpgkey: 'https://packages.clickhouse.com/rpm/stable/repodata/repomd.xml.key',
          )
        }
      end
    end
  end
end

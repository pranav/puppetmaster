
class neverland::sensu_client {

  package { 'sensu-plugin':
    ensure    => present,
    provider => gem
  }

  class { 'sensu':
    rabbitmq_host     => $sensu_host,
    rabbitmq_password => $sensu_rabbitmq_password,
    subscriptions     => ['production'],
  }

  vcsrepo { '/opt/sensu-community-plugins':
    ensure   => present,
    provider => git,
    source   => 'git://github.com/sensu/sensu-community-plugins.git'
  }

  sensu::check { 'diskspace':
    command     => "${sensu_plugin_path}/system/check-disk.rb",
    subscribers => ['production'],
  }

  sensu::check { 'load-metrics':
    type        => 'metrics',
    subscribers => ['production'],
    command     => "${sensu_plugin_path}/system/load-metrics.rb",
  }

}

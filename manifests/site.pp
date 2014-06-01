node default {
  $sensu_host = 'sensu.neverland.io'
  $sensu_rabbitmq_password = 'supersecret'

  package { 'ruby-json':
    ensure => present,
  }

  class { 'sensu':
    rabbitmq_host     => $sensu_host,
    rabbitmq_password => $sensu_rabbitmq_password,
  }
}

node 'sensu.neverland.io' {
  package { 'redis-server':
    ensure => installed,
  }

  service { 'redis-server':
    ensure => running,
  }

  class { '::rabbitmq':
    service_manage => false,
  }

  rabbitmq_user { 'sensu':
    password => 'supersecret',
  }

  rabbitmq_vhost { '/sensu':
    ensure => present,
  }

  rabbitmq_user_permissions { 'sensu@sensu':
    configure_permission => '.*',
    read_permission      => '.*',
    write_permission     => '.*',
  }

  class { 'sensu':
    rabbitmq_password => 'supersecret',
    server            => true,
    dashboard         => true,
    api               => true,
  }

  Rabbitmq_user_permissions['sensu@sensu'] ->
  Package['redis-server'] ->
  Service['redis-server'] ->
  Class['sensu']
}

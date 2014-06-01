class neverland::base {
  $sensu_host = 'sensu.neverland.io'
  $sensu_rabbitmq_password = 'supersecret'

  package { 'ruby-json':
    ensure => present,
  }

  package { 'ruby-dev':
    ensure => present,
  }

  package { 'make':
    ensure => present,
  }

  package { 'sensu-plugin':
    ensure    => present,
    provider => gem
  }

  class { 'sensu':
    rabbitmq_host     => $sensu_host,
    rabbitmq_password => $sensu_rabbitmq_password,
  }
}

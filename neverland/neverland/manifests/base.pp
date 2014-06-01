class neverland::base {

  case $::osfamily {
    'redhat': { $ruby_devel = 'ruby-devel' }
    'debian': { $ruby_devel = 'ruby-dev' }
    default: { fail('I don\'t even know what OS you\'re running.') }
  }

  package { $ruby_devel:
    ensure => present,
  }

  package { 'git':
    ensure => present,
  }

  package { 'make':
    ensure => present,
  }

  include neverland::sensu_client

}

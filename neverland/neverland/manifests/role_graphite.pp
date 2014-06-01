class neverland::role_graphite {

  class { 'memcached':
    max_memory => '70%',
  }

  class { '::mysql::server': }
  mysql::db { 'graphite':
    user     => 'graphite',
    password => 'supersecret',
    host     => 'localhost',
    grant    => ['ALL'],
  }


  class { 'graphite':
    secret_key            => 'supersecret',
    gr_storage_schemas    => [
      {
        name              => 'carbon',
        pattern           => '^carbon\.',
        retentions        => '1m:90d'
      }, {
        name              => 'default',
        pattern           => '.*',
        retentions        => '1m:90d'
      }
    ],
    gr_django_db_engine   => 'django.db.backends.mysql',
    gr_django_db_name     => 'graphite',
    gr_django_db_user     => 'graphite',
    gr_django_db_password => 'supersecret',
    gr_django_db_host     => 'localhost',
    gr_django_db_port     => '3306',
    gr_memcache_hosts     => ['127.0.0.1:11211'],
    gr_web_server         => 'nginx',
  }


}

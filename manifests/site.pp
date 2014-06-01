$sensu_host = 'sensu.neverland.io'
$sensu_rabbitmq_password = 'supersecret'
$sensu_plugin_path = '/opt/sensu-community-plugins/plugins'

node 'sensu.neverland.io' {
  include neverland::role_sensu_server
}

node 'graphite.neverland.io' {
  include neverland::role_graphite
}

node default {
  include neverland::base
}

$sensu_host = 'sensu.neverland.io'
$sensu_rabbitmq_password = 'supersecret'

node 'sensu.neverland.io' {
  include neverland::role_sensu_server
}

node default {
  include neverland::base
}

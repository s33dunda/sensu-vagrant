node 'ops-core' {
  include profiles::base
  include stdlib
  include admin
  include color_prompt
  include dhclient
  include loggly
  include monit
  include motd
  include ntp
  include postfix2
  include puppet
  include profiles::ruby
  include sar
  include ssh
  include sudo
  include users::ops
  include users::account::qualys
}

node /tech-ops-sensu-test/ inherits ops-core {
  include profiles::sensu::rabbitmq
  include profiles::sensu::server
}

node /tech-ops-uchiwa-test/ inherits ops-core {
  include profiles::sensu::uchiwa
  include profiles::sensu::client
}

node /rbmq\-test/ inherits ops-core {
  include profiles::sensu::rabbitmq
  include profiles::sensu::client
}

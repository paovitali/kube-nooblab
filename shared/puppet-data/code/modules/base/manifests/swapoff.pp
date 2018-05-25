class base::swapoff {

file_line { 'swapoff':
  path => '/etc/rc.d/rc.local',
  line => 'swapoff -a',
}

file { '/etc/rc.d/rc.local':
  ensure => file,
  mode => '0755',
}

exec {"off_swap":
    command => "swapoff -a",
    path    => '/usr/sbin/',
  }

}

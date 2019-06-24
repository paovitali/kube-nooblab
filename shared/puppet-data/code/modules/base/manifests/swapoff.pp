class base::swapoff {

case $facts['os']['name'] {
  'RedHat', 'CentOS':  {   
   
  file_line { 'swapoff':
    path => '/etc/rc.d/rc.local',
    line => 'swapoff -a',
  }

  file { '/etc/rc.d/rc.local':
    ensure => file,
    mode => '0755',
   }
  }  

 /^(Debian|Ubuntu)$/: { 

  file_line { 'swapoff':
    path => '/etc/rc.local',
    line => 'swapoff -a',
  }

  file { '/etc/rc.local':
    ensure => file,
    mode => '0755',
  }

  }

  }


exec {"off_swap":
  command => "swapoff -a",
  path    => '/sbin/',
  }

}

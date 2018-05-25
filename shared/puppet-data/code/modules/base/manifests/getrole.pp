class base::getrole {

file { 'check_role':
     ensure   => 'present',
     path     => '/usr/bin/check_role',
     source   => 'puppet:///modules/base/check_role',
     owner    => root,
     group    => root,
     mode     => '0755',
    }

}

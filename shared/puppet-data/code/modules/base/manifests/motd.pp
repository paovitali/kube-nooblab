class base::motd {

   file { 'motd':
        path => '/etc/motd',
        content => template("base/motd.erb"),
        owner => 'root',
        group => 'root',
        mode  => '0644',
    }

}


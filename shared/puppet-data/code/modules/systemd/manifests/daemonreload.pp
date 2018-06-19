class systemd::daemonreload inherits systemd {

  exec { '/usr/bin/systemctl daemon-reload':
    refreshonly => true,
  }

}

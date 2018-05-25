class nfs::client::debian::service {

  service { 'rpcbind':
    ensure    => running,
    enable    => true,
    hasstatus => false,
  }

  if $nfs::client::debian::nfs_v4 {
    service { 'idmapd':
      ensure    => running,
      enable    => true,
      name      => 'nfs-common',
      subscribe => Augeas['/etc/idmapd.conf', '/etc/default/nfs-common'],
    }
  }
}

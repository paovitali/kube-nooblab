class nfs::server::ubuntu::service {

  if $nfs::server::ubuntu::service_manage {
    if $nfs::server::ubuntu::nfs_v4 == true {
      service {'nfs-kernel-server':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package['nfs-kernel-server'],
        subscribe  => [ Concat['/etc/exports'], Augeas['/etc/idmapd.conf','/etc/default/nfs-common'] ],
      }
    } else {
      service {'nfs-kernel-server':
        ensure     => running,
        enable     => true,
        hasrestart => true,
        hasstatus  => true,
        require    => Package['nfs-kernel-server'],
        subscribe  => Concat['/etc/exports'],
      }
    }

    Package['rpcbind'] -> Service['rpcbind']
  }
}

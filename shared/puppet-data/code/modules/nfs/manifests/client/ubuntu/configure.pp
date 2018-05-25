class nfs::client::ubuntu::configure {

  if $nfs::client::ubuntu::nfs_v4 {
      augeas {
        '/etc/default/nfs-common':
          context => '/files/etc/default/nfs-common',
          changes => [ 'set NEED_IDMAPD yes', ];
        '/etc/idmapd.conf':
          context => '/files/etc/idmapd.conf/General',
          lens    => 'Puppet.lns',
          incl    => '/etc/idmapd.conf',
          changes => ["set Domain ${nfs::client::ubuntu::nfs_v4_idmap_domain}"],
      }
  }

}

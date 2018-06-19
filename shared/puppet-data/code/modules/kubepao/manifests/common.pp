class kubepao::common inherits kubepao {

# Kubelet configuration / systemd unit file
  file { "10-kubeadm.conf":
    path   => "/etc/systemd/system/kubelet.service.d/10-kubeadm.conf",
    ensure => present,
    source => "puppet:///modules/kubepao/systemd-unit-files/systemd_kubelet_config",
    owner  => 'root',
    group  => 'root',
    mode   => '644',
    notify => Class['systemd::daemonreload']
  }

# Kubelet service management 
  service { 'kubelet':
    ensure    => running,
    enable    => true,
    subscribe => Class['systemd::daemonreload']
  }

}

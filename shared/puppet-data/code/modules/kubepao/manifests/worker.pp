class kubepao::worker inherits kubepao {

  # Worker Init
  exec { "kubeadm_join":
    command => "kubeadm join --token $kube_master_token --token-ttl $kube_master_token_ttl --discovery-token-unsafe-skip-ca-verification $kube_master_ext_ip:6443",
    path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "[ !  -f /etc/kubernetes/admin.conf ]"
  }


}

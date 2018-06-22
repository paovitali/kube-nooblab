class kubepao::worker inherits kubepao {

  # Worker Init
  exec { "kubeadm_join":
    command => "kubeadm join --token $kube_worker_join_token  --discovery-token-ca-cert-hash sha256:$kube_worker_join_certhash $kube_worker_join_masterip:6443",
    path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "[ !  -f /etc/kubernetes/admin.conf ]"
  }

}

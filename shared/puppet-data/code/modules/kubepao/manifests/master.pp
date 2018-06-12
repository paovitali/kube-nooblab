class kubepao::master inherits kubepao {

exec { "kubeadm_init":
  command => "kubeadm init",
  path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  onlyif => "[ !  -f /etc/kubernetes/admin.conf ]"
}

if $kube_master_cni_provider == "flannel"  {

  exec { "kubectl_apply_net":
  command => "kubectl apply -f $kube_master_cni_url",
  path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
  onlyif => "[ $(kubectl get pods -n kube-system --field-selector=status.phase=Running |grep kube-dns) != " ]"
  }

}

}

class kubepao::master inherits kubepao {

  # Master Init
  exec { "kubeadm_init":
    command => "kubeadm init --pod-network-cidr=$kube_master_pod_cidr --token=$kube_master_token --token-ttl=$kube_master_token_ttl ",
    path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "[ !  -f /etc/kubernetes/admin.conf ]"
  }

 # Cni Setup
  if $kube_master_cni_provider == "flannel"  {
    exec { "kubectl_apply_net":
      command => "kubectl apply -f $kube_master_cni_url",
      path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
      onlyif => "[ ! -f /opt/cni/bin/flannel  ]"
    }
  } 

 # Cluster Tokens creation
  exec { "kubeadm_token_create":
    command => "kubeadm token create --ttl 0 --print-join-command > $kube_master_token_cmd_file",
    path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "[ ! -f $kube_master_token_cmd_file ]"
  }

} 

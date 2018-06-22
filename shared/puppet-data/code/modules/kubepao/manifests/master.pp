class kubepao::master inherits kubepao {

  # Master Init
  exec { "kubeadm_init":
    command => "kubeadm init --pod-network-cidr=$kube_master_pod_cidr --apiserver-advertise-address=$ipaddress_eth1 --token-ttl=0",
    path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "[ !  -f /etc/kubernetes/admin.conf ]"
  }

  # Cni Setup
  if $kube_master_cni_provider == "flannel"  {
    exec { "kubectl_apply_net":
      environment => [ "KUBECONFIG=/etc/kubernetes/admin.conf" ],
      command => "kubectl apply -f $kube_master_cni_url",
      path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
      tries => 10,
      try_sleep => 5,
      onlyif => "[ ! -f  /run/flannel/subnet.env ] || [ $(kubectl get nodes|grep master|awk '{print \$2}') == 'NotReady' ]",
      require => Service[ "kubelet" ]  
    }
  } 

  # Cluster Tokens creation
  exec { "kubeadm_token_create":
    command => "openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //' > $kube_master_join_certhash_file",
    path   => "/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:",
    onlyif => "[ ! -f $kube_master_join_cmd_file ]"
  }

}

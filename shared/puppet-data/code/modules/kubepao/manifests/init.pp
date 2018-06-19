class kubepao (

# Common Parameters

# Kubernetes Master Parameters
$kube_master_role="false",
$kube_master_pod_cidr="",
$kube_master_cni_provider="",
$kube_master_cni_url="",
$kube_master_token="",
$kube_master_token_ttl="",
$kube_master_ext_ip="",
$kube_master_token_cmd_file="",

# Kubernetes Worker Parameters
$kube_worker_role="false",

) {

# EXTERNAL CLASSES
include systemd::daemonreload#

# COMMON CLASSES
include kubepao::common

# KUBERNETES MASTER ROLE CLASSES
if $kube_master_role == "true" {
   include kubepao::master
}

# KUBERNETES WORKER ROLE CLASSES
if $kube_worker_role == "true" {
   include kubepao::worker
}

}


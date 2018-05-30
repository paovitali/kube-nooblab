class kubepao (

# Common Parameters

# Kubernetes Master Parameters
$kube_master_role="false",
$kube_master_cni_provider="",
$kuber_master_cni_url="",

# Kubernetes Worker Parameters
$kube_worker_role="false",
#$kube_worker_join_token="",

) {

# COMMON CLASSES
#include kubepao::common

# KUBERNETES MASTER ROLE CLASSES
if $kube_master_role == "true" {
   include kubepao::master
}

# KUBERNETES WORKER ROLE CLASSES
if $kube_worker_role == "true" {
   include kubepao::worker
}

}


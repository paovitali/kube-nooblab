class base::services {

  $services_hash = hiera_hash('services')
  create_resources('service', $services_hash)

}

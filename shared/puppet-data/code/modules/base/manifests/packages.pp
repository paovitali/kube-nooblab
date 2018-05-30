class base::packages {

  $packages = hiera('base::packages')

  package { $packages:
    ensure => 'installed',
  }

}

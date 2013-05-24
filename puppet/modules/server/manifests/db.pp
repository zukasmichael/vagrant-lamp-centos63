class server::db (
  $ip_addresses
) {
  class { 'mysql': }
  class { 'mysql::server': 
    config_hash => { 'root_password' => '', 'bind_address' => '0.0.0.0' }
  }

  define assign_db_users() {
    $ip = $name
    database_user { "root@$ip":
      ensure => present,
      require => Class['mysql::config'],
    }

    database_grant { "root@$ip":
      privileges => [ 'all' ],
      require    => Database_user["root@$ip"],
    }
  }

  $ips = split($ip_addresses, ',')

  assign_db_users{ ['192.168.56.1']: }
  assign_db_users{ $ips: }
}
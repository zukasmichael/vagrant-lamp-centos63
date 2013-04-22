class server::db {
  class { 'mysql': }
  class { 'mysql::server': 
    config_hash => { 'root_password' => '', 'bind_address' => '0.0.0.0' }
  }

  database_user { 'root@192.168.56.1':
    ensure => present,
    require => Class['mysql::config'],
  }

  database_grant { "root@192.168.56.1":
    privileges => [ 'all' ],
    require    => Database_user["root@192.168.56.1"],
  }
}
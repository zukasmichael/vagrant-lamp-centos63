class server::db {
  class { 'mysql': }
  class { 'mysql::server': 
    config_hash => { 'root_password' => '' }
  }
}

class server::yum {
  require server::ius
  exec { 'yum-update':
    command => '/usr/bin/yum -y update',
    timeout => 900
  }
}
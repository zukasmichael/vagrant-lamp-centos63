class server::misc {
  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
  }

  package { "nfs-utils":
    ensure  => present,
  }
}
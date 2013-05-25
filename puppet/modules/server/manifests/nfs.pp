class server::nfs {
  file { "/tmp/provision.sh":
    replace => true,
    ensure  => present,
    source  => "puppet:///modules/server/nfs/provision.sh",
    mode    => 755,
  }

  exec { "/tmp/provision.sh":
    require => File["/tmp/provision.sh"]
  }
}
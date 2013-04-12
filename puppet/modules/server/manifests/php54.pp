class server::php54 {
  require server::yum
  require server::php54::uninstall

  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["httpd"],
    notify  => Service["httpd"]
  }

  package { "php54":
    ensure  => present,
  }

  package { "php54-cli":
    ensure  => present,
  }

  package { "php54-common":
    ensure  => present,
  }

  package { "php54-devel":
    ensure  => present,
  }

  package { "php54-gd":
    ensure  => present,
  }

  package { "php54-mcrypt":
    require => Package['libmcrypt'],
    ensure  => present,
  }

  package { "php54-intl":
    ensure  => present,
  }

  package { "php54-mbstring":
    ensure  => present,
  }

  package { "php54-mysql":
    ensure  => present,
  }

  package { "php54-pdo":
    ensure  => present,
  }

  package { "php54-pear":
    ensure  => present,
  }

  package { "php54-soap":
    ensure  => present,
  }

  package { "php54-xml":
    ensure  => present,
  }

  package { "php54-pecl-memcache":
    ensure  => present,
  }

  package { "php54-pecl-xdebug":
    ensure  => present,
    require => Exec["grab-epel"]
  }

  package { "php54-pecl-apc":
    ensure  => present,
  }

  class server::php54::uninstall {
     package{ ['php', 'php53u']: ensure => absent }
  }
}
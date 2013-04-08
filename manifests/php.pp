class php {

  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["httpd"],
    notify  => Service["httpd"]
  }

  package { "php53u":
    ensure  => present,
  }

  package { "php53u-cli":
    ensure  => present,
  }

  package { "php53u-common":
    ensure  => present,
  }

  package { "php53u-devel":
    ensure  => present,
  }

  package { "php53u-gd":
    ensure  => present,
  }

  package { "php53u-mcrypt":
    ensure  => present,
  }

  package { "php53u-intl":
    ensure  => present,
  }

  package { "php53u-mbstring":
    ensure  => present,
  }

  package { "php53u-mysql":
    ensure  => present,
  }

  package { "php53u-pdo":
    ensure  => present,
  }

  package { "php53u-pear":
    ensure  => present,
  }

  package { "php53u-soap":
    ensure  => present,
  }

  package { "php53u-xml":
    ensure  => present,
  }

  package { "uuid-php":
    ensure  => present,
  }

  package { "php53u-pecl-memcache":
    ensure  => present,
  }

  package { "php53u-pecl-xdebug":
    ensure  => present,
    require => Exec["grab-epel"]
  }

  package { "php53u-pecl-apc":
    ensure  => present,
  }

  exec { "xhprof":
    command => "/usr/bin/pecl install xhprof-beta",
    creates => "/usr/lib64/php/modules/xhprof.so",
    require => Exec["grab-epel"]
  }

  file { "/etc/php.d/xhprof.ini":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/php.d/xhprof.ini",
  }

  file { "/etc/php.ini":
    replace => true,
    ensure  => present,
    source  => "/vagrant/files/php.ini",
  }
}
class server::php (
  $php_version
) {
  require server::yum

  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["httpd"],
  }

  package { "libmcrypt":
    ensure  => present,
  }

  if $php_version == "5.4" {
    $php_version_name = "php54"
    include server::php54
  } else {
    $php_version_name = "php53u"
    include server::php53
  }

  package { "uuid-php":
    ensure  => present,
    require => [Package["$php_version_name-devel"]]
  }

  exec { "xhprof":
    command => "/usr/bin/pecl install xhprof-beta",
    creates => "/usr/lib64/php/modules/xhprof.so",
    require => [Exec["grab-epel"], Package["$php_version_name-devel"]]
  }

  file { "/etc/php.d/xhprof.ini":
    replace => true,
    ensure  => present,
    source  => "puppet:///modules/server/php.d/xhprof.ini",
    require => Exec['xhprof'],
  }

  file { "/etc/php.ini":
    replace => true,
    ensure  => present,
    source  => "puppet:///modules/server/php.ini",
  }
}
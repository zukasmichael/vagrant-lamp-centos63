class server::httpd {

  File {
    owner   => "root",
    group   => "root",
    mode    => 644,
    require => Package["httpd"],
    notify  => Service["httpd"]
  }

  file { '/mnt/logs/httpd':
    ensure => directory
  }

  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure  => present
  }

  package { "mod_ssl":
    ensure  => present
  }

  service { 'httpd':
    name      => 'httpd',
    require   => Package["httpd"],
    ensure    => running,
    enable    => true
  }

  file { "/etc/httpd/conf.d/vhost.conf":
    replace => true,
    ensure  => present,
    source  => "puppet:///modules/server/httpd/conf.d/vhost.conf",
  }

  # Uncomment if you want to create these folders separately

  # file { "/etc/httpd/vhosts":
  #     ensure => "directory",
  #   }
  file { "/etc/httpd/vhosts_ssl":
      ensure => "directory",
    }
  # file { "/etc/httpd/ssl":
  #     ensure => "directory",
  #   }

  # How to create a writable folder

  # file { "/var/www/share":
  #   mode   => 777,
  #   ensure => "directory",
  # }

  #file { "/etc/httpd/vhosts":
  #  replace => true,
  #  ensure  => present,
  #  source  => "puppet:///modules/server/httpd/vhosts",
  #  recurse => true,
  #}

  file { '/etc/httpd/vhosts':
    ensure => directory,
    owner  => root,
    group  => root,
  }

  file { '/etc/httpd/vhosts/phpdev.local.conf':
    mode    => '0644',
    content => template('server/httpd/vhosts/phpdev.local.conf')
  }

  # Uncomment if you want to specify SSL vhosts and SSL folder for your SSL files.

  # file { "/etc/httpd/vhosts_ssl":
  #     replace => true,
  #     ensure  => present,
  #     source  => "puppet:///modules/server/httpd/vhosts_ssl",
  #     recurse => true,
  #   }
  # file { "/etc/httpd/ssl":
  #     replace => true,
  #     ensure  => present,
  #     source  => "puppet:///modules/server/httpd/ssl",
  #     recurse => true,
  #   }

}
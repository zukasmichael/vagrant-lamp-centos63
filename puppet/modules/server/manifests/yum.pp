class server::yum (
  $enable_yum_update
) {
  require server::yum::ius

  exec { "grap-epel":
    command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm",
    creates => "/etc/yum.repos.d/epel.repo",
    alias   => "grab-epel",
  }

  if ($enable_yum_update == true) {
    exec { 'yum-update':
      command => '/usr/bin/yum -y update',
      timeout => 900
    }
  }
}

class server::yum::ius {
   yumrepo { "IUS":
      baseurl => "http://dl.iuscommunity.org/pub/ius/stable/$operatingsystem/6/$architecture",
      descr => "IUS Community repository",
      enabled => 1,
      gpgcheck => 0
   }
}
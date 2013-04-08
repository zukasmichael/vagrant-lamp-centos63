class server::ius {
   yumrepo { "IUS":
      baseurl => "http://dl.iuscommunity.org/pub/ius/stable/$operatingsystem/6/$architecture",
      descr => "IUS Community repository",
      enabled => 1,
      gpgcheck => 0
   }
}
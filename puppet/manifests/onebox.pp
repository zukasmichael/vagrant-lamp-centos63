# Puppet manifest for my PHP dev machine
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
class phpdevweb {
	require server::misc
	require server::yum
	include server::iptables
	include server::phpdev
	include server::httpd
	#include phpmyadmin

#	file { "/tmp/facts.yaml":
#        content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
#    }

    class { server::php:
        php_version => $php_version,
    }

    class { server::db:
        ip_addresses => $ip_addresses,
    }

}



include phpdevweb
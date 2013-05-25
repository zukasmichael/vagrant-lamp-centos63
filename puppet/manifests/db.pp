# Puppet manifest for my PHP dev machine
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
class dbserver {
    if ($enable_nfs) {
        require server::nfs
    }

    class { server::yum:
        enable_yum_update => $enable_yum_update,
    }

	require server::misc
	include server::iptables

#	file { "/tmp/facts.yaml":
#        content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
#    }

    class { server::db:
        ip_addresses => $ip_addresses,
    }

}



include dbserver
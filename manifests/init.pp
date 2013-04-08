# Puppet manifest for my PHP dev machine
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
class phpdevweb{
	require ius
	require yum
	include iptables
	#include rpmforge
	include misc
	include httpd
	include phpdev
	include db
	include php	
	#include phpmyadmin

#	file { "/tmp/facts.yaml":
#        content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
#    }
}
include phpdevweb
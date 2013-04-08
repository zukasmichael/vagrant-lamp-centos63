# Puppet manifest for my PHP dev machine
Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }
class phpdevweb{
	require server::ius
	require server::yum
	include server::iptables
	#include rpmforge
	include server::misc
	include server::httpd
	include server::phpdev
	include server::db
	include server::php
	#include phpmyadmin

#	file { "/tmp/facts.yaml":
#        content => inline_template("<%= scope.to_hash.reject { |k,v| !( k.is_a?(String) && v.is_a?(String) ) }.to_yaml %>"),
#    }
}
include phpdevweb
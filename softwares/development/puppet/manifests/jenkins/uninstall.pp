class development::jenkins::uninstall {
    package {
        jenkins:
            ensure => purged,
            require => Service[jenkins];
    }
	
    exec {
        "rm -rf /var/lib/jenkins/*":
            require => Package[jenkins];
    }

    service {
        jenkins:
            ensure => stopped;
    }
}

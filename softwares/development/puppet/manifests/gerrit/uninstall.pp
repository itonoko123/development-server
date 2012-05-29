class development::gerrit::uninstall {
    package {
        git-core:
            ensure => purged;
    }

    exec {
        "/var/lib/gerrit/bin/gerrit.sh stop -d /var/lib/gerrit":
            alias => "stop",
            require => Package[git-core];

        "rm -r /var/lib/gerrit/*":
            require => Exec[stop];
			
        "rm /var/lib/gerrit-2.4.war":
            require => Exec[stop];
	}
}

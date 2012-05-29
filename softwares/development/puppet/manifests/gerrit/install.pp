class development::gerrit::install {
    package {
        git-core:
    }

    file {
        "/var/lib/gerrit-2.4.war":
            source => "puppet:///modules/development/gerrit-2.4.war",
            mode => 644,
            require => Package[git-core];

        "/var/lib/gerrit/etc/gerrit.config":
            content => template("$proposal_id/var/lib/gerrit/etc/gerrit.config.erb"),
            mode => 644,
            require => Exec[start];
    }

    exec {
        "java -jar /var/lib/gerrit-2.4.war init --batch -d /var/lib/gerrit":
            alias => "start",
            require => File["/var/lib/gerrit-2.4.war"];

        "/var/lib/gerrit/bin/gerrit.sh stop -d /var/lib/gerrit":
            alias => "stop",
            require => File["/var/lib/gerrit/etc/gerrit.config"];

        "/var/lib/gerrit/bin/gerrit.sh start -d /var/lib/gerrit":
            require => Exec[stop];

    }

}

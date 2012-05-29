class development::gerrit::install {
    package {
        git-core:
    }

    file {
        "/var/lib/gerrit-2.3.war":
            source => "puppet:///modules/development/gerrit-2.3.war",
            mode => 644,
            require => Package[git-core];

        "/var/lib/gerrit/etc/gerrit.config":
            content => template("$proposal_id/var/lib/gerrit/etc/gerrit.config.erb"),
            mode => 644,
            require => Exec[start];
    }

    exec {
        "java -jar /var/lib/gerrit-2.3.war init --batch -d /var/lib/gerrit":
            alias => "start",
            require => File["/var/lib/gerrit-2.3.war"];

        "/var/lib/gerrit/bin/gerrit.sh restart -d /var/lib/gerrit":
            require => File["/var/lib/gerrit/etc/gerrit.config"];
    }

}

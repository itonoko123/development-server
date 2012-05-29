class development::redmine::uninstall {
    exec {
        "kill -9 `cat /var/lib/redmine-2.0.1/tmp/pids/server.pid`":
            alias => "kill";

        "rm -r /var/lib/redmine-2.0.1/*":
            require => Exec[kill];

        "rm /var/lib/redmine-2.0.1.tar.gz":
            require => Exec[kill];

        "rm /var/lib/redmine_hudson.tar.gz":
            require => Exec[kill];
    }
}

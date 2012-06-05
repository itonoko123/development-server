class development::redmine::uninstall {
    exec {
        "kill -9 `cat /var/lib/redmine-1.4.2/tmp/pids/server.pid`":
            alias => "kill";

        "rm -r /var/lib/redmine-1.4.2":
            require => Exec[kill];

        "rm /var/lib/redmine-1.4.2.tar.gz":
            require => Exec[kill];

        "rm /var/lib/redmine_hudson.tar.gz":
            require => Exec[kill];
    }
}

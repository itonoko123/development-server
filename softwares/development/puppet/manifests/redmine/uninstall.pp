class development::redmine::uninstall {
    exec {
        "kill -9 `cat /var/lib/redmine-2.0.0/tmp/pids/server.pid`":
            alias => "kill";

        "rm -r /var/lib/redmine-2.0.0/*":
            require => Exec[kill];

        "rm /var/lib/redmine-2.0.0.tar.gz":
            require => Exec[kill];
    }
}

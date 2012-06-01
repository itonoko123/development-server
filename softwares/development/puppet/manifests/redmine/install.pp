class development::redmine::install {
    file {
        "/var/lib/redmine-1.4.2.tar.gz":
            source => "puppet:///modules/development/redmine-1.4.2.tar.gz",
            mode => 644;

        "/var/lib/redmine_hudson.tar.gz":
            source => "puppet:///modules/development/redmine_hudson.tar.gz",
            mode => 644;

        "/var/lib/redmine-1.4.2/config/database.yml":
            alias => "database",
            source => "puppet:///modules/development/database.yml",
            mode => 644,
            require => Exec[tar];

        "/var/lib/redmine-1.4.2/config/settings.yml":
            alias => "settings",
            source => "puppet:///modules/development/settings.yml",
            mode => 644,
            require => Exec[tar];

        "/var/lib/redmine-1.4.2/install.sh":
            content => template("$proposal_id/var/lib/redmine-1.4.2/install.sh.erb"),
            mode => 777,
            require => File["database", "settings"];
        }

    exec {
        "tar zxf /var/lib/redmine-1.4.2.tar.gz -C /var/lib":
            alias => "tar",
            require => File["/var/lib/redmine-1.4.2.tar.gz", "/var/lib/redmine_hudson.tar.gz"];

        "/var/lib/redmine-1.4.2/install.sh":
            require => File["/var/lib/redmine-1.4.2/install.sh"];
    }
}

class development::redmine::install {
    file {
        "/var/lib/redmine-2.0.1.tar.gz":
            source => "puppet:///modules/development/redmine-2.0.1.tar.gz",
            mode => 644;

        "/var/lib/redmine_hudson.tar.gz":
            source => "puppet:///modules/development/redmine_hudson.tar.gz",
            mode => 644;

        "/var/lib/redmine-2.0.1/config/database.yml":
            source => "puppet:///modules/development/database.yml",
            mode => 644,
            require => Exec[tar];

        "/var/lib/redmine-2.0.1/install.sh":
            content => template("$proposal_id/var/lib/redmine-2.0.1/install.sh.erb"),
            mode => 777,
            require => File["/var/lib/redmine-2.0.1/config/database.yml"];
        }

    exec {
        "tar zxf /var/lib/redmine-2.0.1.tar.gz -C /var/lib":
            alias => "tar",
            require => File["/var/lib/redmine-2.0.1.tar.gz", "/var/lib/redmine_hudson.tar.gz"];

        "/var/lib/redmine-2.0.1/install.sh":
            require => File["/var/lib/redmine-2.0.1/install.sh"];
    }
}

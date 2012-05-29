class development::jenkins::install {
    package {
        jenkins:
    }

    file {
        "/etc/default/jenkins":
            content => template("$proposal_id/etc/default/jenkins.erb"),
            mode => 644,
            require => Package[jenkins];

        "/var/lib/jenkins/plugins":
            ensure => directory,
            require => File["/etc/default/jenkins"];

        "/var/lib/jenkins/plugins/git.hpi":
            alias => "git",
            source => "puppet:///modules/development/git.hpi",
            mode => 644,
            require => File["/var/lib/jenkins/plugins"];

        "/var/lib/jenkins/plugins/redmine.hpi":
            alias => "redmine",
            source => "puppet:///modules/development/redmine.hpi",
            mode => 644,
            require => File["/var/lib/jenkins/plugins"];
                        
        "/var/lib/jenkins/plugins/subversion.hpi":
            alias => "svn",
            source => "puppet:///modules/development/subversion.hpi",
            mode => 644,
            require => File["/var/lib/jenkins/plugins"];
                        
        "/var/lib/jenkins/plugins/gerrit-trigger.hpi":
            alias => "trigger",
            source => "puppet:///modules/development/gerrit-trigger.hpi",
            mode => 644,
            require => File["/var/lib/jenkins/plugins"];
        }

    exec {
        "/etc/init.d/jenkins restart":
            require => File["git", "redmine", "svn", "trigger"];
    }
}

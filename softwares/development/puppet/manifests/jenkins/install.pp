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

        "/var/lib/jenkins/gerrit-trigger.xml":
            alias => "gerrit",
            content => template("development/gerrit-trigger.xml.erb"),
            mode => 666,
            require => File["/var/lib/jenkins/plugins"];

        "/var/lib/jenkins/testproject.xml":
            alias => "project",
            content => template("development/testproject.xml.erb"),
            mode => 666,
            require => File["/var/lib/jenkins/plugins"];

        "/etc/jenkins/createjob.sh":
            alias => "sh",
            content => template("development/createjob.sh.erb"),
            mode => 666,
            require => File["/var/lib/jenkins/plugins"];

        "/var/lib/jenkins/jenkins-cli.jar":
            alias => "jar",
            source => "puppet:///modules/development/jenkins-cli.jar",
            mode => 666,
            require => File["/var/lib/jenkins/plugins"];
        }

    exec {
        "/etc/init.d/jenkins restart":
            alias => "restart",
            require => Exec[keygen];

        'sudo -u jenkins ssh-keygen -P "" -t rsa -f /var/lib/jenkins/.ssh/id_rsa':
            alias => "keygen",
            require => File["git", "redmine", "svn", "trigger", "gerrit", "project", "sh", "jar"];

        "/var/lib/jenkins/createjob.sh":
            require => Exec[restart];
    }
}

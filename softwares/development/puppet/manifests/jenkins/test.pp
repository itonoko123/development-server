class development::jenkins::test {
    file {
        "/var/lib/jenkins/test.sh":
            alias => "test.sh",
            content => template("development/test.sh.erb");

        "/var/lib/redmine-1.4.2/createdata":
            alias => "test",
            mode => 644,
            content => template("development/createdata.erb");
    }

    exec {
        "/var/lib/jenkins/test.sh 2>&1":
            require => File["test.sh", "test"];
    }
}

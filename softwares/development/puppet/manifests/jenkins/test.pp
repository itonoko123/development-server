class development::jenkins::test {
    file {
        "/var/lib/jenkins/test.sh":
            alias => "test.sh",
            content => template("development/test.sh.erb");

        "/var/lib/redminec.rb":
            alias => "redminec",
            content => template("development/redminec.rb.erb");
    }

    exec {
        "/var/lib/jenkins/test.sh 2>&1":
            require => File["test.sh", "redminec"];
    }
}

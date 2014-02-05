class alfresco::db {

 package { "mysql-server": ensure => installed }
 service { "mysqld":
       enable => true,
        ensure => running,
    }
 exec { "set-mysql-password":
     unless => "/usr/bin/mysqladmin -u root -p admin status",
       command => "/usr/bin/mysqladmin -u root password admin",
           }


       
       exec { "create-alfresco-db":
            command   => "/usr/bin/mysql -uroot -padmin -e \"CREATE USER 'alfresco'@'localhost' IDENTIFIED BY 'alfresco';GRANT ALL PRIVILEGES ON *.* TO 'alfresco'@'localhost' WITH GRANT OPTION;create database alfresco; grant all on *.* to alfresco@localhost identified by 'alfresco'; flush privileges;\"",
            logoutput => on_failure,
       }


}

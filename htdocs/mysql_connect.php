<?php
    $username="calenergy";
    $password="calenergy";
    $database="scoenergy";
    $table_names=array();

        mysql_connect('localhost',$username,$password);
        @mysql_select_db($database) or die( "Unable to connect.");
?>

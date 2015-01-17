<?php
    $username="calenergy";
    $password="calenergy";
    $database="scoenergy";
    $field1-name=$F1
  
        mysql_connect(localhost,$username,$password);
	@mysql_select_db($database) or die( "Unable to connect.");
	$query = "SELECT * FROM production_nuclear";
	$result=mysql_query($query);
?>

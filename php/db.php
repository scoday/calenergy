<?php
// Make a MySQL Connection
mysql_connect("192.168.1.2", "scoenergy", "powah") or die(mysql_error());
mysql_select_db("scoenergy") or die(mysql_error());

// Retrieve all the data from the "example" table
$result = mysql_query("SELECT * FROM production_nuclear")
or die(mysql_error());  

// store the record of the "example" table into $row
$row = mysql_fetch_array( $result );
// Print out the contents of the entry 

echo "Date: ".$row['prod_date'];
echo "Hour: ".$row['prod_hour'];
echo "Output: ".$row['prod_output'];

?>

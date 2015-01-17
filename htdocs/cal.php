<html>
<head>
<title>
	CalEnergy.us Select Generation
</title>
<body>
<?php
    $username="calenergy";
    $password="calenergy";
    $database="scoenergy";
    $table_names=array();

        mysql_connect(localhost,$username,$password);
        @mysql_select_db($database) or die( "Unable to connect.");
        $query = "SHOW TABLES FROM scoenergy;";
        $result=mysql_query($query);
	 while ($row = mysql_fetch_row($result)) {
  		$tableNames[] = $row[0];
 }


 echo '<select name="tables" id="tables">';     
 foreach ($tableNames as $name){
   echo '<option value="' . $name . '">' . $name . '</option>';
 }
 echo '</select>';
?>

    <form action="<?php echo $_SERVER['PHP_SELF']; ?>" method='post'>   
        <p>Choose Generation Type:</p>
        <select name='Generation' id="gen">    

<input type="submit" id="submit" value="Submit"/>
    <?php
//Message for what has been selected
    if (isset($_POST['generation'])) {
        echo 'You have selected  ' . $_POST['$row'];
    }
    ?>
<!--       <select name="dropDown">
         <option value="-1">Please select...</option>
-->

</body>
</head>
</html>

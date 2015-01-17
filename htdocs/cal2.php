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

<select name = '' id = ''>
<?php
    $DB_Rows = "SELECT * FROM scoenergy;";/* fetch data from database */;
    while($row = *_fetch_array($DB_Rows))
        echo("<option value = '" . $row['Value'] . "'>" . $row['DisplayValue'] . "</option>");
?>
</select>
<!--


        mysql_connect(localhost,$username,$password);
        @mysql_select_db($database) or die( "Unable to connect.");
        $query = "SHOW TABLES FROM scoenergy;";
        $result=mysql_query($query);

//         $sql = "SELECT id, description FROM dropDownTable";
//         $rs = mysql_query($sql);
	 while ($row = mysql_fetch_row($result)) {
  $tableNames[] = $row[0];
 }


 echo '<select name="tables" id="tables">';     
 foreach ($tableNames as $name){
   echo '<option value="' . $name . '">' . $name . '</option>';
 }
 echo '</select>';
?>
       <select name="dropDown">
         <option value="-1">Please select...</option>
       <? while ($obj = mysql_fetch_object($query)) { ?>
         <option value="<?= $obj->id; ?>" <? if ($data['downDown'] == $obj->id) echo "SELECTED"; ?>>
           <?= $obj->description; ?>
         </option>
       <? } ?>
       </select>
-->

</body>
</head>
</html>

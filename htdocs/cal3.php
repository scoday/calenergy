<?php

error_reporting(E_ALL);
if (!isset($_POST['Submit'])) {
// form not submitted
?>

<form action="<?=$_SERVER['PHP_SELF']?>" method="post">
<?php
require_once ('mysql_connect.php'); // Connect to the db.

$res=mysql_query("SELECT * FROM production_nuclear ORDER BY prod_hour") or die(mysql_error());
echo "<select name=dropdown>";
while($row=mysql_fetch_assoc($res)) {


echo "<option value=$row[prod_output]>$row[prod_date]</a></option>";
}
echo "</select>";
?>


<input type="Submit" value="Submit" name="Submit"> 
</form>

<?php
}

else {

// form submitted
// set server access variables
		require_once ('mysql_connect.php'); // Connect to the db.
$dropdown = empty($_POST['dropdown'])? die ("ERROR: Select from dropdown") : mysql_escape_string($_POST['dropdown']);

// Open Connection


//Create Query

$query = "SELECT * FROM production_nuclear WHERE $dropdown='$dropdown'" or die (mysql_error());

$result = mysql_query($query) or die (mysql_error());

$num=mysql_numrows($result);


echo "<b><center>Database Output</center></b><br><br>";

$i=0;
while ($i < $num) {

$prod_output=mysql_result($result,$i,"Output");
$prod_date=mysql_result($result,$i,"Date");
$prod_time=mysql_result($result,$i,"Time");


echo "$prod_output, $prod_date, $prod_time  ";

$i++;

}
}
?>

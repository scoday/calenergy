<?php

  $con = mysql_connect("192.168.1.2","scoenergy","powah");
    if (!$con)
      {
        die('No Connecty! ' . mysql_error());
      }

  $db_selected = mysql_select_db('scoenergy');
    if (!$db_selected) {
      die ('Can\'t use scoenergy : ' . mysql_error());
    }

// the rest
 echo '<form action="dbBrowse.php" method="post">';

    $gen = array (0 => 'Generation', 'Thermal', 'Nuclear', 'Renewable', 'Large-Hydro');
    $mon = array (0 => 'Month', '11', '12');
    $hrs = array (0 => 'Hour', '1','2','3','4','5','6','7','8','9','10','11','12','13','14','15','16','17','18','19','20','21','22','23','24');



    echo '<select name="drop1">';
    foreach ($mon as $key => $value) {
    echo "<option value=\"$key\">
    $value</option>\n";

    }

    echo '</select>';

    echo '<select name="drop2">';
    foreach ($gen as $key => $value) {
    echo "<option value=\"$key\">
    $value</option>\n";

    }

    echo '<select/>';

    echo '<select name="drop3">';
    foreach ($hrs as $key => $value)  {
    echo "<option value=\"$key\">
    $value</option>\n";

    }

    echo '<select/>';
    echo '</form>';

            //echo keys of selection
    echo $_POST['drop1'];
    echo "<br />";
    echo $_POST['drop2'];
    echo "<br />";
    echo $_POST['drop3'];


	$genTypeVar = mysql_real_escape_string($_POST['$drop1']);
	$monthTypeVar = mysql_real_escape_string($_POST['$drop2']);
	$hourTypeVar = mysql_real_escape_string($_POST['$drop3']);

	$dropSearch = mysql_query('SELECT * FROM production_nuclear');


	$query = "SELECT * FROM production_nuclear";
    $result = mysql_query($query) or die(mysql_error());

while($row = mysql_fetch_assoc($result))
{
    $dd .= "<option value='{$row['production_nuclear']}</option>";
} 
?>

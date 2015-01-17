<?php
$mysqli  = new mysqli("192.168.1.2", "scoenergy", "powah", "scoenergy");
$uresult = $mysqli->query("SELECT * FROM production_nuclear", MYSQLI_USE_RESULT);

if ($uresult) {
   while ($row = $uresult->fetch_assoc()) {
       echo $row['Name'] . PHP_EOL;
   }
}
$uresult->close();
?>

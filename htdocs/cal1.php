<?php
$con=mysqli_connect("localhost","calenergy","calenergy","scoenergy");
// Check connection
if (mysqli_connect_errno())
{
echo "Failed to connect to MySQL: " . mysqli_connect_error();
}


$result = mysqli_query($con,"SELECT * FROM production_nuclear");

echo "<table border='1'>
<tr>
<h1>Nuclear Power: </h1>
<th>id</th>
<th>prod_date</th>
<th>prod_hour</th>
<th>prod_output</th>
</tr>";

 while($row = mysqli_fetch_array($result))
 {
 echo "<tr>";
  echo "<td>" . $row['id'] . "</td>";
  echo "<td>" . $row['prod_date'] . "</td>";
  echo "<td>" . $row['prod_hour'] . "</td>";
  echo "<td>" . $row['prod_output'] . "</td>";
  echo "</tr>";
 }
echo "</table>";

mysqli_close($con);
?> 

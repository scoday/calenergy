<script type="text/javascript" src="https://www.google.com/jsapi"></script>
    <script type="text/javascript">

      // Load the Visualization API and the piechart package.
      google.load('visualization', '1.0', {'packages':['corechart']});

      // Set a callback to run when the Google Visualization API is loaded.
      google.setOnLoadCallback(drawChart);

      // Callback that creates and populates a data table,
      // instantiates the pie chart, passes in the data and
      // draws it.
      function drawChart() {

        // Create the data table.
        var data = new google.visualization.DataTable();
        data.addColumn('number', 'Hour');
        data.addColumn('number', 'Output MW');
        data.addRows([
//CHANGE FOR PHP TO PULL INFORMATION FRO MYSQL DBA

<?php
// Create connection
$con=mysqli_connect("localhost","calenergy","calenergy","scoenergy");

// Check connection
if (mysqli_connect_errno($con))
{
    echo "Failed to connect to MySQL: " . mysqli_connect_error();
}

$result = mysqli_query($con,"SELECT * FROM production_nuclear WHERE prod_date='2014-05-08'");
$start = 0;
$OutArray = array();
while($row = mysqli_fetch_array($result))
{
    //$OutArray[] = "['".$row["prod_date"]."', ".$row["prod_hour"]."', ".$row["prod_output"]."],";
    $OutArray[] = "['".$row['prod_hour']."', '".$row['prod_output']."'],";
}

#echo explode('2014','-','05', $OutArray);
foreach($OutArray as $key => $val)
    {
        echo $val;
    }

mysqli_close($con);
?>
        ]);

        // Set chart options
        var options = {'title':'CalISO Nuclear Output: ',
                       'width':1600  ,
                       'height':850};

        // Instantiate and draw our chart, passing in some options.
        var chart = new google.visualization.LineChart(document.getElementById('production_history'));
        chart.draw(data, options);
      }
    </script>


                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                <td width="50%">
                <div id="production_history"></div>
                </td>
                <td width="50%">

                </td>
                </tr>
                <tr>
                <td width="50%">

                </td>
                <td width="50%">

                </td>
                </tr>
                </table>

<?php
    $dbhost="localhost";
    $dblogin="root";
    $dbpwd="";
    $dbname="scoenergy";
       
    $db =  mysql_connect($dbhost,$dblogin,$dbpwd);
    mysql_select_db($dbname);    
	
//    $day = date('d');
//    $month = date('m');
//    $lastMonth = (string)($month-1);	
//    $lastMonth = strlen($month - 1) == 1? '0'.$lastMonth : $lastMonth;
    
//    $SQLString = "SELECT * FROM production_imports WHERE prod_date >= '2014-05-07' AND prod_date < '2014-05-14';";
//    $SQLString2 = "SELECT * FROM production_solarpv WHERE prod_date >= '2014-05-07' AND prod_date < '2014-05-14';";
//     $SQLString = "SELECT * FROM production_imports WHERE `prod_date` = '2014-05-12' UNION SELECT * FROM production_solarpv WHERE `prod_date` = '2014-05-12';";
		    		
										
//    $result = mysql_query($SQLString);    
//    $num = mysql_num_rows($result);   
#    $result = mysql_query($SQLString2);    
#    $num = mysql_num_rows($result);   

// set heading	
//    $data[0] = array('prod_hour', 'Production Output In MW');		
//    for ($i=1; $i<($num+1); $i++)
//    {
//        $data[$i] = array((mysql_result($result, $i-1, 'prod_hour')),
//			 (int) mysql_result($result, $i-1, 'prod_output'));
//    }	
//    $data[0] = array('prod_hour', 'Production Output In MW');
//    for ($i=1; $i<($num+1); $i++)
//   {
//        $data[$i] = array((mysql_result($result, $i-1, 'prod_hour')),
//                         (int) mysql_result($result, $i-1, 'prod_output'));
//    }
//    echo json_encode($data);
//    echo json_encode($data2);

               $prodone="production_imports";
               $prodtwo="production_solarpv";
	       $timeone="2014-05-14";
               //$qry1=mysql_query("SELECT * FROM $prodone WHERE prod_date = ".$timeone."';");
               $qry1=mysql_query("SELECT * FROM .$prodone. WHERE prod_date = '.$timeone.'");
               $row1=mysql_fetch_array($qry1);
               //$qry2=mysql_query("SELECT * FROM $prodtwo WHERE prod_date = '".$timeone."';");
               $qry2=mysql_query("SELECT * FROM .$prodtwo. WHERE prod_date = .$timeone.");
               $row2=mysql_fetch_array($qry2);

               $chart= array( 
                     array('Date', 'Total Calls' ),  
                     array("$prodone", intval($row1[0])),
                     array("$prodtwo", intval($row2[0])));
                $data=json_encode($chart);
    mysql_close($db);
?>

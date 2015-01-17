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
    
    $SQLString = "SELECT * FROM production_solarthermal WHERE prod_date='2015-01-16'	
		    ORDER BY prod_hour";		
										
    $result = mysql_query($SQLString);    
    $num = mysql_num_rows($result);   

// set heading	
    $data[0] = array('prod_hour', 'Production Output In MW');		
    for ($i=1; $i<($num+1); $i++)
    {
        $data[$i] = array((mysql_result($result, $i-1, 'prod_hour')),
			 (int) mysql_result($result, $i-1, 'prod_output'));
    }	
    echo json_encode($data);
    mysql_close($db);
?>

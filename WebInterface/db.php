<?php

function get_conn($user,$password)
{

/* Connect to a MySQL database using driver invocation */
$server = 'mysql:dbname=placement_cell;host=127.0.0.1';

try {
    $conn = new PDO($server, $user, $password);
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    echo 'Connection Established: ';
    return $conn;
} catch (PDOException $e) {
	session_start();
	$_SESSION['errorcode']=1;
	header("Location: index.php");
    die('Connection failed: ' . $e->getMessage());
    
}




}

function get_rconn()
{

/* Connect to a MySQL database using driver invocation */
$server = 'mysql:dbname=placement_cell;host=127.0.0.1';

try {
    $conn = new PDO($server, "root", "root");
    $conn->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION); 
    echo 'Connection Established: ';
} catch (PDOException $e) {
    echo 'Connection failed: ' . $e->getMessage();
}



return $conn;
}

?>



<?php

include "db.php";
session_start();
$conn = get_conn();

$sql ="select * from company where cid='".$_REQUEST['cid']."' ;" ;

$q = $conn->query($sql) or die('failed');

$r = $q->fetch(PDO::FETCH_ASSOC);

if ($r['password'] == $_REQUEST['password'])
 {
  
  #echo "correct password";
  session_unset();
  #session_destroy();

  $_SESSION['cid'] = $_REQUEST['cid'];
  header("Location: welcome_company.php");
 }
else
 {
  echo "incorrect password";
 }


?>

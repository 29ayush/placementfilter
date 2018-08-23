<?php

include "db.php";

session_start();
if(!isset($_REQUEST['username']) || !isset($_REQUEST['password']))
{
  $_SESSION['errorcode']=1;
	header("Location: index.php");
}
$username = $_REQUEST['username'];
$password = $_REQUEST['password'];

$conn = get_conn($username,$password);
$sql ="select current_role()" ;

try {
	$q = $conn->query($sql) ;
} catch (PDOException $e) {
    die('Connection failed: ' . $e->getMessage());
}

  if($r = $q->fetch(PDO::FETCH_ASSOC))
  	{
  		$Usertype = $r['current_role()'];	
      if($Usertype=="")	
      {
        $_SESSION['errorcode']=2;
      header("Location: index.php");
      }
      $_SESSION['usertype']=$Usertype;
      if($Usertype=='role_student')    header("Location: welcome_student.php");
      else if($Usertype=='role_cr')    header("Location: welcome_compnay.php");
      else if($Usertype=='role_professor')    header("Location: welcome_professor.php");
      else if($Usertype=='role_moderator')    header("Location: welcome_moderator.php");
      
  	}
  else
  	{
      $_SESSION['errorcode']=2;
  		header("Location: index.php");
		  
  	}

  
  $_SESSION['username'] = $username;
  $_SESSION['password'] = $password;
 
?>

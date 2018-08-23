<?
include "db_driver.php";
include "db.php";
session_start();



if(!isset($_SESSION['username']) || !isset($_SESSION['password']) || !isset($_SESSION['usertype']))
{
  $_SESSION['errorcode']=2;
  header("Location: index.php");
}

if($_SESSION['usertype']!='role_student') {
  $_SESSION['errorcode']=3;
  session_unset();
  header('Location: index.php');

}

?>
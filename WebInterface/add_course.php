<?php
include "db_driver.php";
include "db.php";
session_start();



if(!isset($_SESSION['username']) || !isset($_SESSION['password']) || !isset($_SESSION['usertype']))
{
  $_SESSION['errorcode']=2;
  header("Location: index.php");
}
$username = $_SESSION['username'];
$password = $_SESSION['password'];
$usertype = $_SESSION['usertype'];

if($usertype!='role_student') {
  $_SESSION['errorcode']=3;
  session_unset();
  header('Location: index.php');

}
$conn = get_conn($username,$password);



$sql = "insert into Taken Values({$_REQUEST['RollNo']},'{$_REQUEST['CourseCode']}',{$_REQUEST['Sem']},'{$_REQUEST['Grade']}',{$_REQUEST['Private']},0)" ;
echo $sql;
$q = $conn->exec($sql) or die('failed');

header('Location: student_courses.php');

?>

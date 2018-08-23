<?php

#apply_interview.php

include "db.php";
session_start();
$conn = get_conn();


$sql = "select * from interview where cid='".$_REQUEST['a']."' and date='".$_REQUEST['b']."' and time='".$_REQUEST['c']."' ;";

$q = $conn->query($sql) or die('failed');

$r = $q->fetch(PDO::FETCH_ASSOC);

$sql2 = "insert into interested values('".$r['cid']."','".$r['date']."','".$r['time']."','".$r['type']."','".$_SESSION['entryno']."','request') ;" ;

echo $sql2;

$q = $conn->exec($sql2) or die('failed');

$_SESSION['notify'] = "your interview has been scheduled with the company";

header("Location: welcome_student.php");


?>

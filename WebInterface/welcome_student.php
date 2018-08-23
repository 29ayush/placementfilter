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

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="iit Palakkad">
    <meta name="author" content="vishwash batra">
    <link rel="icon" href="../../favicon.ico">

    <title> Tnp-IIT Palakkad- Student Portal </title>

    <!-- Bootstrap core CSS -->
    <link href="static/css/bootstrap.min.css" rel="stylesheet">

   
  </head>

  <body>
    <nav class="navbar navbar-fixed-top navbar-inverse">
      <div class="container">
        <div class="navbar-header">
           <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>

            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          <a class="navbar-brand" href="index.php">TnP Cell - IIT Palakkad</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="index.php">Home</a></li>
            <li><a href="about.php">About</a></li>
            <li><a href="contact.php">Contact</a></li>
   <?php
      if (isset($_SESSION['entryno']))
           {
 ?>
         <li><a href="logout.php">Log Out</a></li>
 <?php
           }
    
 ?>

          </ul>
        </div><!-- /.nav-collapse -->
      </div><!-- /.container -->
    </nav><!-- /.navbar -->
<br>
<br>
<br>

    <div class="container">

      <div class="row row-offcanvas row-offcanvas-right">


        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">

          <div class="list-group">
            <a href="welcome_student.php" class="list-group-item active"> Profile </a>
            <a href="student_courses.php" class="list-group-item"> Courses Done </a>
            <a href="student_interview.php" class="list-group-item"> Interviews </a>
            <a href="student_apply.php" class="list-group-item"> Apply </a>
          
          </div>

        </div><!--/.sidebar-offcanvas-->

        <div class="col-xs-12 col-sm-9">
          <div class="jumbotron">
<?php


$student = get_student($username,$conn);


if (isset($_SESSION['username']))
{
?>


<?php
 if (isset($_SESSION['notify']))
 {
?>

 <div class="bs-example bs-example-standalone" data-example-id="dismissible-alert-js">
    <div class="alert alert-warning alert-dismissible fade in" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong> New Notification: </strong> <?php echo $_SESSION['notify']; ?>
    </div>


<?php
 unset($_SESSION['notify']);

 }
?>

<div class="bs-docs-section">
  <h2 id="breadcrumbs" class="page-header"> welcome <?php  echo $student['Name']; ?>   </h2>

  <p class="lead"> Your profile  <button class="btn-primary"> Edit </button> </p>
  <div class="bs-example" data-example-id="simple-breadcrumbs">
  <ol class="breadcrumb">
      <li><a href="#"> Full Name </a></li>
      <li class="active"> <?php echo $student['Name']; ?> </li>
    </ol>
  <ol class="breadcrumb">
      <li><a href="#"> Roll No </a></li>
      <li class="active"> <?php echo $student['RollNo'] ; ?> </li>
    </ol>
  <ol class="breadcrumb">
      <li><a href="#"> Email </a></li>
      <li class="active"> <?php echo $student['Email'] ; ?> </li>
    </ol> 
  <ol class="breadcrumb">
      <li><a href="#">PCVId </a></li>
      <li class="active"> <?php echo $student['PCVId'] ; ?> </li>
    </ol>  
  <ol class="breadcrumb">
      <li><a href="#"> PNo </a></li>
      <li class="active"> <?php echo $student['PNo'] ; ?> </li>
    </ol>    
  <ol class="breadcrumb">
      <li><a href="#"> Gender </a></li>
      <li class="active"> <?php echo $student['Gender'] ; ?> </li>
    </ol>    
  <ol class="breadcrumb">
      <li><a href="#">Department </a></li>
      <li class="active"> <?php echo $student['Dept'] ; ?> </li>
    </ol>    
  <ol class="breadcrumb">
      <li><a href="#"> Programme </a></li>
      <li class="active"> <?php echo $student['Programme'] ; ?> </li>
    </ol>
  <ol class="breadcrumb">
      <li><a href="#"> CGPA </a></li>
      <li class="active"> <?php echo $student['CGPA'] ; ?> </li>
    </ol>
  <ol class="breadcrumb">
      <li><a href="#"> Address </a></li>
      <li class="active"> <?php echo $student['address'] ; ?> </li>
    </ol>        
  <ol class="breadcrumb">
      <li><a href="#"> Private Bits </a></li>
      <li class="active"> <?php echo decbin(intval($student['Privpub'])) ; ?> </li>
    </ol>      
  </div>
<?php

   }

else {

echo "<p> Your session has expired. Please log in to continue </p> ";
   }

?>

          </div>

      </div><!--/row-->
     </div>
  </div> <!-- container -->

      <hr>

      <footer>
        <p>&copy; Developed as part of Database Project for CSL454-2015, IIT Palakkad </p>
      </footer>

    </div><!--/.container-->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="static/jquery/jquery.min.js"></script>
    <script src="static/js/bootstrap.min.js"></script>

  </body>
</html>



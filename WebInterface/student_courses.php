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
  #session_unset();
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
               <link href="static/css/bootstrap-select.css" rel="stylesheet"> 

   
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
      if (isset($_SESSION['username']))
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
            <a href="welcome_student.php" class="list-group-item"> Profile </a>
            <a href="student_courses.php" class="list-group-item active"> Courses Done </a>
            <a href="student_interview.php" class="list-group-item"> Interviews </a>
            <a href="student_apply.php" class="list-group-item"> Apply </a>
          
          </div>

        </div><!--/.sidebar-offcanvas-->

        <div class="col-xs-12 col-sm-9">
          <div class="jumbotron">
<?php


$student = get_student($username,$conn);


$courses = get_courses($username,$conn);

echo "Courses done: <br>";

if (isset($_SESSION['username']))
  {
?>


<div class="bs-example" data-example-id="hoverable-table">
    <table class="table table-hover">
      <thead>
        <tr>
          <th>#</th>
          <th>Course Code</th>
          <th>Course Sem</th>
          <th>Course Grade</th>
          <th>Private</th>
        </tr>
      </thead>

      <tbody>

<?php
$num= 1;
while ($course = $courses->fetch(PDO::FETCH_ASSOC))
{

echo "<tr> <td>".(string)$num."</td> <td> ".$course['CourseCode']."</td> <td>".$course['Sem']."</td> <td>".$course['Grade']."</td> <td>".$course['Privpub']." </td> </tr> ";
$num++;

}
     
?>

   

      </tbody>

    </table>
  </div><!-- /example -->


<form class="form-inline" action="add_course.php" method="POST">
  <div class="form-group">
    <input type="hidden"  class="form-control" name="RollNo" placeholder="CSL-xxx" value=<?php echo $student['RollNo'] ?> >
    <label for="exampleInputName2"> Course Code</label>
     <select id="selectpo" class="selectpicker" data-live-search="true" name="CourseCode" >

     <option value="default" selected disabled hidden></option>
    <?php
        include_once "db.php";
        $conn = get_rconn();
        $sql = "select Code,CONCAT(Code,' \:\: ',Name) as abc from Courses" ;
        try {
          $q = $conn->query($sql) ;
        } catch (PDOException $e) {
        die( 'Connection failed: ' . $e->getMessage());
        }
        
        $result = $q->fetchALL();
        foreach($result as $row)
        {   
            echo "<option value='{$row[0]}' >{$row[1]}</option>";
        }
        
     
    ?>
</select>
  </div>
  <div class="form-group">
    <label for="exampleInputEmail2"> Sem </label>
    <input type="text" class="form-control" name="Sem" placeholder="4">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail2"> Grade </label>
    <input type="text" class="form-control" name="Grade" placeholder="A">
  </div>
  <div class="form-group">
    <label for="exampleInputEmail2"> Private </label>
    <input type="text" class="form-control" name="Private" placeholder="1/0" maxlength="1">
  </div>
  <button type="submit" class="btn btn-default"> Add Course </button>
</form>


          </div>

      </div><!--/row-->
     </div>

<?php

}
else {
 echo "<p> Please log into continue </p>";
   }
?>

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
    <script src="static/js/bootstrap-select.js"></script>

  </body>
</html>



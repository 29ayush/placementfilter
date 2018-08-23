<?php

session_start();
$name="";
$address="";
$error="";  
if($_SERVER['REQUEST_METHOD'] == 'POST'){
  $name=$_POST['name'];
$address=$_POST['address'];
  if(empty($_POST['name']))
    $error = "Name can't be empty";
  elseif(empty($_POST['address']))
    $error = "Address can't be empty";
  else
  {
 include_once 'db.php';
  $conn = get_rconn();
  $sql  = "Insert into Company(Name,Address) Values ('{$name}','{$address}')";
  try {
      $q = $conn->query($sql) ;
    
      $_SESSION['notify'] = "Request for registration has been sent to the administrator";
      header("Location: index.php");
      
    } catch (PDOException $e) {
    $error =  'Connection failed: '.$e->getMessage();
    }
}
}
/*include 'dbroot.php';
$conn = get_conn();

$sql = "insert into company values('".$_REQUEST['cid']."','".$_REQUEST['name']."','".$_REQUEST['password']."','0','".$_REQUEST['contact_person']."','".$_REQUEST['contact_email']."','".$_REQUEST['contact_number']."') ;";

echo $sql;

$q = $conn->exec($sql) or die('failed');

$_SESSION['notify'] = "request for registration has been sent to the administrator";

header("Location: index.php");
*/

?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  
    <meta name="description" content="iit Palakkad">
    <meta name="author" content="ayush mittal">
    <link rel="icon" href="../../favicon.ico">

    <title> Training and Placement Cell- IIT Palakkad </title>

  
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
          <a class="navbar-brand" href="#">TnP Cell - IIT Palakkad</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active"><a href="index.php">Home</a></li>
            <li><a href="about.php">About</a></li>
            <li><a href="contact.php">Contact</a></li>
          </ul>
        </div><!-- /.nav-collapse -->
      </div><!-- /.container -->
    </nav><!-- /.navbar -->

<br>
<br>
<br>
<br>

    <div class="container">

      <div class="row row-offcanvas row-offcanvas-right">

        <div class="col-xs-12 col-sm-9">
          <p class="pull-right visible-xs">
            <button type="button" class="btn btn-primary btn-xs" data-toggle="offcanvas">Toggle nav</button>
          </p>
          <div class="jumbotron">
            <h1> TnP Cell- IIT Palakkad</h1>
            <p> welcome to online portal for all information related to training and placement of students of Indian Institute of Technology Palakkad</p>
          
          <div class="row">
            <div class="col-xs-6 col-lg-6">

<?php
 
  if (isset($_SESSION['entryno']) or isset($_SESSION['cid']))
 {
echo "welcome ".$_SESSION['entryno'].$_SESSION['cid']." <br> ";
 }

 else {

?>
 <p> Please enter information below to send a request for registration to the TnP Officer of IIT Palakkad </p>
<?php 
  if($error)
  {
    echo "<div class=\"alert alert-danger\">
          {$error}
</div>";
  }
?>
<form action="#" id="signform" method="POST">

  <div class="form-group"> 
    <label for="Company Name">Company Name</label>
    <input type="text" class="form-control" name="name" value="<?php echo $name; ?>" placeholder="Company Name">
  </div>
 <div class="form-group"> 
    <label for="exampleInputPassword1">Address:</label>
    <input type="text" class="form-control" name="address" 
    value="<?php echo $address ?>" placeholder="Address:  ">
  </div>
   
 
  <button type="submit" class="btn btn-default">Submit</button>
  <input type="button" class="btn btn-default" name="reset_form" value="Reset" onclick="clearForm(this.form); ">
</form>




<?php
     }

?>
            </div><!--/.col-xs-6.col-lg-4-->

  
</div>
<br>
<br>

       
        <div class="col-xs-6 col-sm-3 sidebar-offcanvas" id="sidebar">
      
           

        </div><!--/.sidebar-offcanvas-->
    
  </div><!--/row-->

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
    <script type="text/javascript">
      function clearForm(oForm) {
   
  var elements = oForm.elements;
   
  oForm.reset();

  for(i=0; i<elements.length; i++) {
     
  field_type = elements[i].type.toLowerCase();
 
  switch(field_type) {
 
    case "text":
    case "password":
    case "textarea":
          case "hidden":  
     
      elements[i].value = "";
      break;
       
    case "radio":
    case "checkbox":
        if (elements[i].checked) {
          elements[i].checked = false;
      }
      break;

    case "select-one":
    case "select-multi":
                elements[i].selectedIndex = -1;
      break;

    default:
      break;
  }
    }
}
    </script>
  </body>
</html>


<?php
  echo "<script> 
  $(document).ready(function() {
    $(\"body\").click(function(){
    $(\".alert\").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
});
});

window.setTimeout(function() {
    $(\".alert\").fadeTo(500, 0).slideUp(500, function(){
        $(this).remove(); 
    });
}, 3000);</script>";
?>
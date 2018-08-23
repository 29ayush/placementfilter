<?php

session_start();
$name="";
$username="";
$email="";
$pno="";
$error="";  
$cmpny="";
$Password="";
if($_SERVER['REQUEST_METHOD'] == 'POST'){
  $name=$_POST['name'];
  $username=$_POST['username'];
  $email=$_POST['email'];
  $pno=$_POST['pno'];
  $cmpny=$_POST['cmpny'];
  $Password=$_POST['Password'];
  if(!$name)
    $error = "Name can't be empty";
  if(!$Password)
    $error = "Name can't be empty";
  elseif(!$username)
    $error = "Username can't be empty";
  elseif(!$email)
    $error = "Email can't be empty";
  elseif(!$pno)
    $error = "Phone No can't be empty";
  elseif(!$cmpny)
    $error = "Company can't be empty";
  else
  {
 include_once 'db.php';
  $conn = get_rconn();
  $sql  = "call createusercr('{$Password}','{$username}','{$name}','{$email}',{$pno},{$cmpny})";
  
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
    <label for="User Name">User Name</label>
    <input type="text" class="form-control" name="username" value="<?php echo $username; ?>" placeholder="User Name">
  </div>
      <div class="form-group"> 
    <label for="Password">Password</label>
    <input type="password" class="form-control" name="Password" value="<?php echo $Password; ?>" placeholder="*ADSYHHSAD(*B">
  </div>
 <div class="form-group"> 
    <label for="exampleInputPassword1">Name:</label>
    <input type="text" class="form-control" name="name" 
    value="<?php echo $name ?>" placeholder="Julius Caesar  ">
  </div>
   <div class="form-group"> 
    <label for="Company Name">Email:</label>
    <input type="email" class="form-control" name="email" value="<?php echo $email; ?>" placeholder="zyz@gmail.com">
  </div>
  <div class="form-group"> 
    <label for="Company Name">Phone No.</label>
    <input type="text" class="form-control" name="pno" value="<?php echo $pno; ?>" placeholder="99999999" maxlength="10">
  </div>
  <div class="form-group"> 
    <label for="Company Name">Company Name</label>
        </br>
    <select id="selectpo" class="selectpicker" data-live-search="true" name="cmpny" >

     <option value="default" selected disabled hidden></option>
    <?php
        include_once "db.php";
        $conn = get_rconn();
        $sql = "select Id,concat(Name,'  ',Address) Cname from Company;" ;
        try {
        	$q = $conn->query($sql) ;
        } catch (PDOException $e) {
        die( 'Connection failed: ' . $e->getMessage());
        }
        
        $result = $q->fetchALL();
        foreach($result as $row)
        {   
            echo "<option value='{$row['Id']}' >{$row['Cname']}</option>";
        }
        

    ?>
</select>



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
    <script src="static/js/bootstrap-select.js"></script>
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
                $(elements[i]).selectpicker('refresh');
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

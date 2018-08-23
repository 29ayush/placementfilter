<?php

session_start();
$Username    = "";
$Name        = "";
$RollNo      = "";
$Email       = "";
$PCVId       = "";
$PNo         = "";
$Gender      = "";
$Dept        = "";
$Programme   = "";
$CGPA        = "";
$address     = "";
$error       = "";
$Password    = "";
$trail       = " Can't be empty";
$privpub     = "";

if($_SERVER['REQUEST_METHOD'] == 'POST'){
  $Username    = $_POST['Username'];
  $Name        = $_POST['Name'];
  $RollNo      = $_POST['RollNo'];
  $Email       = $_POST['Email'];
  $PCVId       = $_POST['PCVId'];
  $PNo         = $_POST['PNo'];
  $Gender      = $_POST['Gender'];
  $Dept        = $_POST['Dept'];
  $Programme   = $_POST['Programme'];
  $CGPA        = $_POST['CGPA'];
  $address     = $_POST['address'];
  $Password    = $_POST['Password'];
  $privpub    = $_POST['Private'];

  if(!$Username)  $error = "Username".$trail;
  elseif(!$Name)  $error = "Name".$trail;
  elseif(!$RollNo)  $error = "RollNo".$trail;
  elseif(!$Email)  $error = "Email".$trail;
  elseif(!$PNo)  $error = "PNo".$trail;
  elseif(!$Gender)  $error = "Gender".$trail;
  elseif(!$Dept)  $error = "Department".$trail;
  elseif(!$Programme)  $error = "Programme".$trail;
  elseif(!$CGPA)  $error = "CGPA".$trail;
  elseif(!$Password)  $error = "Password".$trail;
  elseif(!$privpub)  $error = "Private Bits".$trail;
  else
  {
  include_once 'db.php';
  $conn = get_rconn();
  $sql  = "call createuserstudent('{$Password}','{$Username}','{$Name}',".$RollNo.",'{$Email}',".($PCVId==""?"NULL" : "'".$PCVId."'").",{$PNo},'{$Gender}','{$Dept}','{$Programme}',{$CGPA},".($address==""?"NULL" : "'".$address."'").",b'{$privpub}');";
  
  try {
      $q = $conn->query($sql) ;
    
      $_SESSION['notify'] = "Request for registration has been sent to the administrator";
      header("Location: index.php");
      
    } catch (PDOException $e) {
    $error =  'Connection failed: '.$e->getMessage();
    }
    
}
}
/*';
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
    <input type="text" class="form-control" name="Username" value="<?php echo $Username; ?>" placeholder="User Name">
  </div>
    <div class="form-group"> 
    <label for="Password">Password</label>
    <input type="password" class="form-control" name="Password" value="<?php echo $Password; ?>" placeholder="*ADSYHHSAD(*B">
  </div>
 <div class="form-group"> 
    <label for="exampleInputPassword1">Name:</label>
    <input type="text" class="form-control" name="Name" 
    value="<?php echo $Name ?>" placeholder="Julius Caesar  ">
  </div>
   <div class="form-group"> 
    <label for="Company Name">Email:</label>
    <input type="email" class="form-control" name="Email" value="<?php echo $Email; ?>" placeholder="zyz@gmail.com">
  </div>
  <div class="form-group"> 
    <label for="Company Name">Phone No.</label>
    <input type="number" class="form-control" name="PNo" value="<?php echo $PNo; ?>" placeholder="99999999" maxlength="10">
  </div>
  <div class="form-group"> 
    <label for="Staffid">Roll No.</label>
    <input type="text" class="form-control" name="RollNo" value="<?php echo $RollNo; ?>" placeholder="XY090XSU" maxlength="10">
  </div>
  <div class="form-group"> 
    <label for="Department">Department.</label>
        </br>
    <select id="selectpo" class="selectpicker" data-live-search="true" name="Dept" >

     <option value="default" selected disabled hidden></option>
    <?php
    
        include_once "db.php";
        $conn = get_rconn();
        $sql = "select Name from Departments;" ;
        try {
        	$q = $conn->query($sql) ;
        } catch (PDOException $e) {
        die( 'Connection failed: ' . $e->getMessage());
        }
        
        $result = $q->fetchALL();
        foreach($result as $row)
        {   
            echo "<option value='{$row[0]}' >{$row[0]}</option>";
        }
        
     
    ?>
</select>

  </div>
  <div class="form-group"> 
    <label for="Department">CV URL</label>
    <input type="text" class="form-control" name="PCVId" value="<?php echo $PCVId; ?>" placeholder="https://google.com/cv1.pdf">
  </div>
  <div class="form-group"> 
    <label for="Department">Gender.</label>
     <select id="gendersel" class="selectpicker" data-live-search="true" name="Gender" >
         <option value="M" >Male</option>
         <option value="F" >Female</option>
</select>
  </div>
  <div class="form-group"> 
    <label for="Department">Programme.</label>
     <select id="deptsel" class="selectpicker" data-live-search="true" name="Programme" >
         <option value="BTECH" >B.Tech</option>
         <option value="MTECH" >M.Tech</option>
         <option value="PhD" >PhD</option>
         <option value="MSc" >MSc</option>
         <option value="BSc" >BSc</option>
         <option value="BA" >BA</option>
         <option value="MA" >MA</option>
         </select>
  </div>
  <div class="form-group"> 
    <label for="Department">CGPA.</label>
    <input type="text" class="form-control" name="CGPA" value="<?php echo $CGPA; ?>" placeholder="9.9" >
  </div>
  <div class="form-group"> 
    <label for="Department">address.</label>
    <input type="text" class="form-control" name="address" value="<?php echo $address; ?>" placeholder="Ghaziabad India" >
  </div>
  <div class="form-group"> 
    <label for="Department">Private.</label>
    <input type="text" class="form-control" name="Private" value="<?php echo $privpub; ?>" placeholder="0000" maxlength="5" minlength="5">
  </div>
<!--  <div class="form-group"> 
    <label for="Company Name">Company Name</label>
    <input type="text" class="form-control" name="name" value="<?php echo $cname; ?>" placeholder="Company Name">
  </div> -->

 
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

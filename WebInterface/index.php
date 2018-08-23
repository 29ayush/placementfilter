<?php

session_start();
include 'db.php';
#$conn = get_conn();
?>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
  
    <meta name="description" content="iit palakkad">
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
            <p> welcome to online portal for all information related to training and placement of students of Indian Institute of Technology Palakkad </p>


<?php
 if (isset($_SESSION['notify']))
 {
?>

 <div class="bs-example bs-example-standalone" data-example-id="dismissible-alert-js">
    <div class="alert alert-success" role="alert">
      <button type="button" class="close" data-dismiss="alert" aria-label="Close"><span aria-hidden="true">&times;</span></button>
      <strong> New Notification: </strong> <?php echo $_SESSION['notify']; ?>
    </div>
  </div>


<?php
 unset($_SESSION['notify']);

 }
?>
          
          <div class="row">
            <div class="col-xs-6 col-lg-6">
              <h2 class="form-signup-heading">Sign up</h2>  
              <a href="register_company.php"> <button type="button" class="btn btn-link"> Company? </button> </a></br>
              <a href="register_student.php"> <button type="button" class="btn btn-link"> Student? </button> </a></br>
              <a href="register_cr.php"> <button type="button" class="btn btn-link"> Company Representative? </button> </a></br>
              <a href="register_professor.php"> <button type="button" class="btn btn-link"> Professor? </button> </a>
            </div>
		
            <div class="col-xs-6 col-lg-6">

<?php

  if (isset($_SESSION['entryno']) or isset($_SESSION['cid']))
 {
echo "welcome ".$_SESSION['username'].$_SESSION['cid']." <br> ";
 }

 else {

?>
  <script src="static/jquery/jquery.min.js"></script>
    <form class="form-signin" action="user_verification.php" method="POST">
        <h2 class="form-signin-heading">Sign in</h2>	
	<?php 
		if(isset($_SESSION['errorcode'])){
		        if($_SESSION['errorcode']==1)
              { $message= "<strong>Invalid Login.</strong> Please try again."; }
            elseif ($_SESSION['errorcode']==2) {
              $message= "<strong>Unknown Error.</strong> Please try again."; }
            
     			echo "<div class=\"alert alert-danger\">
          {$message}
</div>";

  session_unset();
     			}
		?>
        <label for="inputEntryNumber" class="sr-only">Username</label>
        <input type="text" name="username" class="form-control" placeholder="Username" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-primary btn-block" type="submit">Log In</button>
      </form>

   <!--         </div><!--/.col-xs-6.col-lg-4

          <div class="col-xs-6 col-lg-6">

    <form class="form-signin" action="company_verification.php" method="POST">
        <h2 class="form-signin-heading">Company sign in</h2>
        <label for="inputCompanyUsername" class="sr-only">Username</label>
        <input type="text" name="cid" class="form-control" placeholder="Username" required autofocus>
        <label for="inputPassword" class="sr-only">Password</label>
        <input type="password" name="password" class="form-control" placeholder="Password" required>
        <div class="checkbox">
          <label>
            <input type="checkbox" value="remember-me"> Remember me
          </label>
        </div>
        <button class="btn btn-primary btn-block" type="submit">I'm a Company</button>
      </form>-->
     
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
        <p>&copy; Developed as part of Database Project for CS3710 :- IIT Palakkad </p>
      </footer>

    </div><!--/.container-->


    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    
    <script src="static/js/bootstrap.min.js"></script>

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

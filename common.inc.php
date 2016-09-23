<?php
require_once( "config.php" );
require_once( "user.class.php");
require_once( "profile.class.php");
require_once( "pbkdf2.php" );

function displayNavBar()  {
    ?>
      <div class="n">
      <div class="sitemap">
        <h2>Site Map</h2>
        <div class="site-menu">
          <ul class="site-menu-1 site-menu">
          <li><a href="profile.php">Profile</a></li>
          <li><a href="makeBooking.php">Make a booking</a></li>
          <li><a href="confirm.php">Confirm a booking</a></li>
          <li><a href="bookingList.php">View bookings</a></li>
          <li><a href="logout.php">Log out</a></li>
          <li class="menu open">
            <a class="sitemap-toggle sitemap-toggle-reset sitemap-toggle-toggled" tabindex="0" style="height: 16px;"><span class="sitemap-toggle-char">−</span></a>
            <a href="AdminAccounts.php">Admin</a>
            <ul>
              <li><a href="AdminAccounts.php">View Accounts</a></li>
              <li><a href="login.php">View Bookings</a></li>
              <li><a href="login.php">View Rooms??</a></li>
            </ul>
          </li>
        </ul>
        </div>
      </div>
    </div>
    <?php
}

function insertDoctypeDeclaration($title)
{
?>
  <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
      "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
  <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
              <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
              <title><?php echo $title ?></title>
<?php
}

function insertStandardScripts()
{
}

function insertCalendarScripts()
{
  ?>
  <script type="text/javascript" src="scripts/jsDatePick.min.1.3.js"></script>

  <script type="text/javascript">
  window.onload = function(){
    
    
    g_globalObject = new JsDatePick({
      useMode:1,
      isStripped:true,
      target:"div3_example"
    });   
    
    g_globalObject.setOnSelectedDelegate(function(){
      var obj = g_globalObject.getSelectedDay();
      document.forms["test"].year.value = obj.year
      document.forms["test"].month.value = obj.month
      document.forms["test"].day.value = obj.day
      /*alert (document.forms["test"].year.value + "-" + document.forms["test"].month.value + "-" + document.forms["test"].day.value);*/
      /*document.getElementById("div3_example_result").innerHTML = obj.day + "/" + obj.month + "/" + obj.year;*/
    });
    
    
    
  /*  
    g_globalObject2 = new JsDatePick({
      useMode:1,
      isStripped:false,
      target:"div4_example",
      cellColorScheme:"beige"
    });
    
    g_globalObject2.setOnSelectedDelegate(function(){
      var obj = g_globalObject2.getSelectedDay();
      alert("a date was just selected and the date is : " + obj.day + "/" + obj.month + "/" + obj.year);
      document.getElementById("div3_example_result").innerHTML = obj.day + "/" + obj.month + "/" + obj.year;
    });   
    */
  };
</script>
  <?php
}

function insertStandardStyleSheets()
{
  ?>
  <link rel="Stylesheet" type="text/css" href="//www.scss.tcd.ie/tms/m/styles/master.css" media="screen">
  <link rel="Stylesheet" type="text/css" href="//www.scss.tcd.ie/tms/m/styles/print.css" media="print">
  <link rel="Stylesheet" type="text/css" href="//www.scss.tcd.ie/tms/t/scss/styles-scss.css?v=4" media="screen">
  <link rel="stylesheet" type="text/css" href="//www.scss.tcd.ie/tms/m/scripts/jquery/shadowbox/3.0.3/shadowbox.css">
  <link rel="stylesheet" href="videos/me.js/mediaelementplayer.css">
<?php
}

function insertCalendarStyleSheets()
{
  ?>
  <link rel="stylesheet" type="text/css" media="all" href="cal/jsDatePick_ltr.min.css" />
  <?php
}

function insertStandardBody($title)
{
  ?>
  </head>
        <body>
          <div class="wrap">

    <div class="core-header">
      <h1>
      <a href="//www.tcd.ie">
        Trinity College Dublin
        <span></span>
      </a>
    </h1> 
    <form class="core-search" method="get" action="http://search.tcd.ie/search">
                <fieldset>
                        <legend><span class="accelerator-key">S</span>earch TCD</legend>
                        <label for="search" class="cloak">Your query: </label>
                        <input accesskey="s" type="text" name="q" id="search" value="Search TCD" onfocus="if(this.value=='Search TCD'){this.value='';this.style.color='#54575e';this.style.background='#ffffff';}else{this.select();}" onblur="if(this.value==''){this.value='Search TCD';this.style.color='#54575e';this.style.background='#EDF1F8';}">
                        <input type="image" src="//www.scss.tcd.ie/tms/m/styles/img/go.gif" class="submit" alt="Go" value="go">
                        <input type="hidden" name="entqr" value="0">
                        <input type="hidden" name="ud" value="1">
                        <input type="hidden" name="sort" value="date:D:L:d1">
                        <input type="hidden" name="output" value="xml_no_dtd">
                        <input type="hidden" name="oe" value="UTF-8">
                        <input type="hidden" name="ie" value="ISO-8859-1">
                        <input type="hidden" name="client" value="default_frontend">
                        <input type="hidden" name="proxystylesheet" value="default_frontend">
                        <input type="hidden" name="site" value="default_collection">
                </fieldset>
    </form>
    <h2 class="cloak">Top Level TCD Links</h2>
    <div class="core-tabs">
        <ul>                        
          <li><a href="//www.tcd.ie/" class="core-tab" title="TCD Home"><span>TCD Home</span></a></li>
          <li id="selected" title="Visit Faculties &amp; Schools"><a href="//www.tcd.ie/structure/" title="Visit Faculties &amp; Schools"><span>Faculties &amp; Schools</span></a></li>
          <li><a href="//www.tcd.ie/courses/" title="Browse TCD Courses"><span>Courses</span></a></li>
          <li><a href="//www.tcd.ie/research/" title="Find out more about our Research"><span>Research</span></a></li>
          <li><a href="//www.tcd.ie/services/" title="TCD Services"><span>Services</span></a></li>
          <li><a href="//www.tcd.ie/contacts/" title="Contact Details"><span>Contact</span></a></li>
          <li><a href="//www.tcd.ie/az/" title="TCD A-Z Listings"><span>A – Z</span></a></li>
          </ul>       
     </div>

   </div> <!-- End of core-header-->


      <div class="cc">
      <div class="cc-inner">
      <div class="h">
      <div class="h-inner">
        <h1><a href="/"><?php echo $title ?><span></span></a></h1>
        <p class="structure"><a href="//ems.tcd.ie">Faculty of Engineering, Mathematics and Science</a></p>
      </div>
      </div>


      <div class="m">
      <div class="m-inner">
      <div class="m-inner-2">


      <?php
      displayNavBar()
      ?>

      <div class="c ie-lte-6-force-word-wrap">
      <div class="c-inner">
      <div class="c-inner-2" id="main content">
<?php
}

function insertStandardHTML($title)
{
  insertDoctypeDeclaration($title);
  insertStandardStyleSheets();
  insertStandardScripts();
  insertStandardBody($title);
}

function insertCalendarHTML($title)
{
  insertDoctypeDeclaration($title);
  insertStandardStyleSheets();
  insertCalendarStyleSheets();
  insertStandardScripts();
  insertCalendarScripts();
  insertStandardBody($title);
}

//Displays the standard footer
function displayFooter() {
	?>
      </div>
      </div>
      </div>
      </div>
      </div><!-- These are the ends of the class="m-inner"-->
      </div>
      </div>
      </div> <!-- End of the class="cc" -->
      
      

      <div class="core-footer">
      <address>Trinity College Dublin, College Green, Dublin 2.<br>Central Switchboard: +353 1 896 1000.</address>
      <ul>
      <li><a href="http://www.tcd.ie/accessibility/">Accessibility</a></li>
      <li><a href="http://www.tcd.ie/privacy/">Privacy</a></li>
      <li><a href="http://www.tcd.ie/disclaim/">Disclaimer</a></li>
      <li><a href="http://www.tcd.ie/contacts/">Contact</a></li>
      </ul>
      </div>

      </div> <!-- End of the class="wrap" -->
		</body>
		<!-- <div id="footer"></div> -->
	</html>
	<?php
}

// Function that generates the HTML for date selection
function displayDateOptions($action)  {
    ?>
    <div id="div3_example" style="margin:10px 0 30px 0; border:dashed 1px red; width:205px; height:230px;"> </div>
    <form action=<?php echo $action ?> method="post" name="test">
      <div> 
        <input type="hidden" name="year" id="year" value=<?php echo date("Y") ?> />        <!--  Y gets the current Year -->
        <input type="hidden" name="month" id="month" value=<?php echo date("n") ?> />      <!--  n gets the current month -->
        <input type="hidden" name="day" id="day" value=<?php echo date("j") ?> />          <!--  j gets the date in the month -->
        <?php 
        displayHours();
}

function displayHours()  {
  ?>
  <label for="hour">Hour *</label>
        <select name="hour" id="hour" size="1">
          <?php 
          $htmlString = "";
          for($i = 0; $i < 24; $i++)
          {
            
            if($i < 10)
            {?>
              <option value= <?php echo $i ?> > <?php echo ('0' . $i . ":00"); ?></option>
            <?php }else{ ?>
              <option value= <?php echo $i ?> > <?php echo ($i . ":00"); ?></option>
            <?php
            }
            
          }
          ?>
        </select>
        <?php
}

function isDateValid()
{
  return is_numeric($_POST["month"]) && is_numeric($_POST["day"]) && is_numeric($_POST["year"]) && checkdate($_POST["month"], $_POST["day"], $_POST["year"]);
}

function displayDebugMessage() {
    echo "This page is intended for debug purposes only.";
}

function getDatabaseConnection()
{
  try 
  {
    $databaseConnection = new PDO( DB_NAME, DB_USERNAME, DB_PASSWORD );
    $databaseConnection->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
  } 
  catch ( PDOException $e ) 
  {
    echo "Connection failed: " . $e->getMessage();
  }
  return $databaseConnection;
}

function getFutureBookings()  {
  $databaseConnection = getDatabaseConnection();
  $time = time() - (time() % 3600);         //Rounds down to the start of the hour
  $time = gmdate("Y-m-d H:i:s", $time);
  $sql = "SELECT * FROM `bookings` WHERE `time` >= :time AND `user` = :user";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> bindValue( ":time", $time, PDO::PARAM_STR );
        $connection-> bindValue( ":user", $_SESSION["user"]->getValue("username"), PDO::PARAM_STR );
        $connection-> execute();
        $queryResult = $connection->fetchAll();
        $databaseConnection = "";                       //closes connection
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
  return $queryResult;
}

function getTodaysBookings()  {
  $databaseConnection = getDatabaseConnection();
  $time = time() - (time() % 86400);         //Rounds down to the start of the day
  $time = gmdate("Y-m-d H:i:s", $time);
  $Maxtime = time() - (time() % 86400) + 86400;         //Rounds down to the start of the day
  $Maxtime = gmdate("Y-m-d H:i:s", $Maxtime);
  $sql = "SELECT * FROM `bookings` WHERE `time` >= :time AND `time` < :maxTime";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> bindValue( ":time", $time, PDO::PARAM_STR );
        $connection-> bindValue( ":maxTime", $Maxtime, PDO::PARAM_STR );
        $connection-> execute();
        $queryResult = $connection->fetchAll();
        $databaseConnection = "";                       //closes connection
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
  return $queryResult;
}

//Checks to see if the user is logged in. If not redirected to the login page
function checkedLoggedIn() {
	session_start();
	if ( !isset($_SESSION["user"]) || !$_SESSION["user"] || !$_SESSION["user"] = User::getUser( $_SESSION["user"]->getValue( "username" ) ) ) {
    	$_SESSION["user"] = "";
    	header( "Location: login.php" );
    exit;
  }	
}

function getListOfProfiles()
{
  $databaseConnection = getDatabaseConnection();
  $sql = "SELECT * FROM `profile`";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> execute();
        $queryResult = $connection->fetchAll();
        $databaseConnection = "";                       //closes connection
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
  return $queryResult;
}

function getListOfCourseCodes()
{
  $databaseConnection = getDatabaseConnection();
  $sql = "SELECT DISTINCT `courseCode` FROM `users`";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> execute();
        $queryResult = $connection->fetchAll();
        $databaseConnection = "";                       //closes connection
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
  return $queryResult;
}

function createNewGroup($groupName)
{
  $databaseConnection = getDatabaseConnection();
  $sql = "INSERT INTO `bookingdata`.`groups` (`name`) VALUES (:name)";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> bindValue( ":name", $groupName, PDO::PARAM_STR );
        $connection-> execute();
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
  $databaseConnection = "";                       //closes connection
  $groupNumber = getGroupNumber($groupName);
  addUserToGroup($groupNumber, $_SESSION["user"]->getValue("username"), True);
}

function getGroupNumber($groupName)
{
  $databaseConnection = getDatabaseConnection();
  $time = time() - (time() % 3600);         //Rounds down to the start of the hour
  $time = gmdate("Y-m-d H:i:s", $time);
  $sql = "SELECT * FROM `bookingdata`.`groups` WHERE `name` >= :name";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> bindValue( ":name", $groupName, PDO::PARAM_STR );
        $connection-> execute();
        $queryResult = $connection->fetch();
        $databaseConnection = "";                       //closes connection
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
  return $queryResult["id"];
}

function addUserToGroup($groupNumber, $user, $owner)
{
  $databaseConnection = getDatabaseConnection();
  $sql = "INSERT INTO `bookingdata`.`user_groups` (`user_id`, `group_id`, `owner`) VALUES (:username, :groupNumber, :owner)";
  try {
        $connection = $databaseConnection->prepare( $sql );
        $connection-> bindValue( ":username", $user, PDO::PARAM_STR );
        $connection-> bindValue( ":groupNumber", $groupNumber, PDO::PARAM_INT );
        $connection-> bindValue( ":owner", ($owner ? 1:0), PDO::PARAM_INT );
        $connection-> execute();
  }
  catch (PDOException $e) {
    $databaseConnection = "";            //closes connection
    echo "Error occured: " . $e->getMessage();        
    die ();
  }
}

?>

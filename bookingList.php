<?php 
require_once( "common.inc.php" );
checkedLoggedIn();
insertCalendarHTML( "Check Booking" );

if ( isset( $_POST["submitButton"] ) ) {
  processForm();
} 
else {
  displayForm();
}

/*
* Checks if the date entered by the user is valid. If it is valid, the view bookings page is displayed
* If the date is invalid the form is redisplayed to the user.
*/
function processForm() {
  if(isDateValid()) {
    viewBookings();
  }
  else {
    echo "<p>The date entered was not valid! Please try again.</p>";
    displayForm();
  }
}

/*
* Function that displays the bookings for the date specified by the user.
*/
function viewBookings() {
  try {
    $databaseConnection = new PDO( DB_NAME, DB_USERNAME, DB_PASSWORD );                               //Creates database connection
    $databaseConnection->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
  } 
  catch ( PDOException $e ) {
    echo "Connection failed: " . $e->getMessage();
  }

  $date = $_POST["year"] . "-" . $_POST["month"] . "-" . $_POST["day"] . " " . "0" . ":0:0";   //Converts the date to a mySQL friendly format  
  $date = strtotime($date);
  $maxDate = $date + DAY;
  $date = gmdate("Y-m-d H:i:s", $date);
  $maxDate = gmdate("Y-m-d H:i:s", $maxDate);
  $sql = "SELECT * FROM `bookings` WHERE `time` >= :date AND `time` < :maxDate ORDER BY `time` AND `room`";                                 //Selects all bookings for the inputed time
  try {
    $connection = $databaseConnection->prepare( $sql );
    $connection-> bindValue( ":date", $date, PDO::PARAM_STR );
    $connection-> bindValue( ":maxDate", $maxDate, PDO::PARAM_STR );
    $connection-> execute();
    $queryResult = $connection->fetchAll();
    $databaseConnection = "";                                                                         //closes connection
  }
  catch (PDOException $e) {
    $databaseConnection = "";                                                                        //closes connection
    die ( "Invalid query: " . $e->getMessage() );
  }
  
  echo "<h1>Bookings for " . $_POST["day"] . "/" . $_POST["month"] . "/" . $_POST["year"] . "</h1>";
  if($queryResult) {                                                                                //Checks that the query returned data
    echo "<table><tr><th>Time</th><th>Room Number</th><th>Name</th><th>purpose</th></tr>";                   //table header
    foreach ( $queryResult as $row ) {
      echo "<tr><td>" . $row["time"] . "</td><td>" . $row["room"] . "</td><td>" . User::getUsersName($row["user"]) . "</td><td>" . $row["purpose"] . "</td></tr>";
    } 
   echo  "</table>";
  }
  else {
    echo "There are no bookings for that time.";
  }
}

/*
* Function that displays the date options to the user
*/
function displayForm() {
?>
    <h1>Check Bookings</h1>
    <?php displayDateOptions("bookingList.php") ?>
        <div style="clear: both;">
          <input type="submit" name="submitButton" id="submitButton" value="Send Details" />
          <input type="reset" name="resetButton" id="resetButton" value="Reset Form" style="margin-right: 20px;" />
        </div>
      </div>
    </form>
<?php
}

displayFooter();
?>
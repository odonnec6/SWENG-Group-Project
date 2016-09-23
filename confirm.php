<?php 
require_once( "common.inc.php" );
checkedLoggedIn();
insertStandardHTML( "Confirm Booking" );

if ( isset( $_POST["submitButton"] ) ) {
  processForm();
  displayForm();
} 
else {
  displayForm();
}

/*
* Checks if the date entered by the user is valid. If it is valid, the view bookings page is displayed
* If the date is invalid the form is redisplayed to the user.
*/
function processForm() {
  if(isset($_POST['confirm']) && isset($_POST['time']) &&  $_POST['confirm'] == 'Yes')  { 
    try {
      $databaseConnection = new PDO( DB_NAME, DB_USERNAME, DB_PASSWORD );
      $databaseConnection->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
    }  
    catch ( PDOException $e ) {
      echo "Connection failed: " . $e->getMessage();
    }
    $time = $_POST['time'];
    $sql = "UPDATE `bookings` SET `confirmed` = '1' where `user` = :username AND :time = `time`"; 
    try {
      $connection = $databaseConnection->prepare( $sql );
      $connection-> bindValue( ":username", $_SESSION["user"]->getValue("username"), PDO::PARAM_STR );
      $connection-> bindValue( ":time", $time, PDO::PARAM_STR );
      $connection-> execute();
      $databaseConnection = "";                       //closes connection
    }
    catch (PDOException $e) {
      $databaseConnection = "";            //closes connection  
      echo "Error: " . $e->getMessage();                 
      die ();
    } 
  }
  else
  {
      displayform();
  }    
  
}

/*
* Function that displays the date options to the user
*/
function displayForm() {

  $future_bookings = getFutureBookings();
  if( count($future_bookings) > 0 )
  {
    echo "<table>";
    echo "<tr>";
    echo "<td>Time</td><td>Username</td><td>Room Number</td><td>Purpose</td><td>Confirmation</td>";
    echo "</tr>";
    foreach ($future_bookings as $booking)
      {
        echo "<tr>";
        echo "<td>" . $booking["time"] . "</td>" . "<td>" . $booking["user"] . "</td>" . "<td>" . $booking["room"] . "</td>" . "<td>" . $booking["purpose"] . "</td>";
        if(isCurrentHour($booking["time"]) && $booking["confirmed"] != 1)  {
          ?>
          <td>
            <form action="confirm.php" method="post">
              <input type="hidden" name="time" id="time" value= "<?php echo $booking["time"] ?>" />
              <label><input type="checkbox" name="confirm" value="Yes">Confirm booking?</label>
              <div style="clear: both;">
              <input type="submit" name="submitButton" id="submitButton" value="Send Details" />
        </div>
            </form>

          </td>
           <?php
        }
        else
        {
          if($booking["confirmed"] == 1)  {
            echo "<td>Confirmed</td>";
          }
          else  {
            echo "<td>Unconfirmed</td>";
          } 
        }
        echo "</tr>";
      } 
    echo "</table>";
  }
  else
  {
    echo "<h1>You currently have no bookings</h1>";
  }
}

function isCurrentHour($timeStamp)
{
  $timestamp_unix = strtotime($timeStamp);
  $timestamp_limit = $timestamp_unix + 3600;
  $currentHour = time();
  return (($currentHour >= $timestamp_unix) && ($currentHour < $timestamp_limit) )  ;
}

displayFooter();
?>
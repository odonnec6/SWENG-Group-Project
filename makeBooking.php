<?php
/* To do:
*   Clean the purpose field before it is entered into the database(Prevent mySQL injection attacks)
*   When the user selects a room, check that the date is still valid and that the room is free at that time
*/ 
require_once( "common.inc.php" );
checkedLoggedIn();
insertCalendarHTML( "Make Booking" );

if ( isset( $_POST["submitButton"] ) ) {
  if( isset($_POST["room"]) &&  isset($_POST["date"]) )
  {
    makeBooking($_POST["date"], $_POST["room"], $_POST["duration"]);
  }
  else
  {
    processForm();
  }
} else {
  displayForm();
}


function processForm() 
{
  $userProfile = Profile::getProfile($_SESSION["user"]->getValue("profile"));
  if(isDateValid()) {
    if(count(getFutureBookings()) < Profile::maxFutureBookings($_SESSION["user"]->getValue("profile"))) {
      $date = $_POST["year"] . "-" . $_POST["month"] . "-" . $_POST["day"] . " " . $_POST["hour"] . ":0:0";
      $date = strtotime($date);
      $max_date = strtotime("+" . $userProfile->getValue("Booking_limit") . " day" , time());
      if($date > time() && $date < $max_date) {
        displayFreeBookings($date, $_POST["duration"]);
      }
      else {
        echo "You cannot make a booking in the past or you cannot make a booking more than " . $userProfile->getValue("Booking_limit") . " days into the future." ;
        displayForm();
      }
    }
    else {
      echo "You have made the maximum number of future bookings.";
      displayForm();
    }
  }
  else {
    echo "<p>The date entered was not valid! Please try again.</p>";
    echo $_POST["year"] . "-" . $_POST["month"] . "-" . $_POST["day"];
    displayForm();
  }
}

function displayFreeBookings($date, $duration)
{
  $databaseConnection = getDatabaseConnection();
  $sql = getFreeRoomQuery($date, $duration);
  $rows = $databaseConnection->query( $sql );
  $purpose = $_POST["purpose"];
  //If there is a free room make a booking
  $date = gmdate("Y-m-d H:i:s", $date);
  if($rows -> rowCount() > 0)
    {
      ?>
     <form action="makeBooking.php" method="post">
      <div style="width: 30em; padding-left: 10px;">
        <h1>Which room?</h1>
        <input type="hidden" name="purpose" id="purpose" value= "<?php echo $purpose ?>" />
        <input type="hidden" name="date" id="date" value="<?php echo $date ?>" />
        <input type="hidden" name="duration" id="duration" value="<?php echo $duration ?>" />
        <table>
          <tr>
            <td>Room Number</td><td>Capacity</td><td>Monitor</td><td>Select</td>
          </tr>
          <?php
      foreach ($rows as $row)
      {
        ?>
        <tr>
          <?php
            echo "<td>" . $row["number"] . "</td>" . "<td>" . $row["capacity"] . "</td>" . "<td>" . (($row["monitor"] == 0) ? "No" : "Yes") . "</td>" . "<td>";
          ?>
        <input type = "radio" name = "room" id = "room" value = <?php echo $row["number"]?> checked = "checked" />
          </td>
        </tr>
        <?php
      } 
      ?>
    </table>
        <div style="clear: both;">
            <input type="submit" name="submitButton" id="submitButton" value="Send Details" />
            <input type="reset" name="resetButton" id="resetButton" value="Reset Form" style="margin-right: 20px;" />
        </div>
      </div>
    </form>
    <?php
    }
    else 
    {
      echo "<h1>Booking failed:</h1><p>All Rooms are occupied at that time.</p>";
      displayForm();
    } 

}

function getFreeRoomQuery($date, $duration)
{
  $tempDate = gmdate("Y-m-d H:i:s", $date);
  $sql = "SELECT * FROM rooms WHERE rooms.number NOT IN (SELECT bookings.room FROM bookings WHERE bookings.time = '" . $tempDate . "')" ;
  for( $i = 1; $i < $duration; $i++)
  {
    //Converts the date into a format that MySQL will accept
    $tempDate = gmdate("Y-m-d H:i:s", $date + ($i * HOUR));
    $sql = $sql . " AND rooms.number NOT IN (SELECT bookings.room FROM bookings WHERE bookings.time = '" . $tempDate . "')" ;
    //Retreives the list of rooms that are free at the specified time
    //The user should be presented with the list of rooms and be allowed to choose
    //The below picks the first availble room
    
  }
  echo $sql;
  return $sql;
}

function makeBooking($date, $roomNumber, $duration) 
{
  // Add code to check selected room is free
  $purpose = $_POST["purpose"];
  $sql = "INSERT INTO bookings (`time`, `user`, `area`, `room`, `group`, `purpose`) VALUES (:date, :username, 0, :freeRoom , 0, :purpose)" ; //Clears table
  for($i = 0; $i < $duration; $i++)
  {
    $databaseConnection = getDatabaseConnection();
    try {
      $unix_time = strtotime($date) + ($i * HOUR);
      $connection = $databaseConnection->prepare( $sql );
      $connection-> bindValue( ":date", gmdate("Y-m-d H:i:s", $unix_time), PDO::PARAM_STR );
      $connection-> bindValue( ":username", $_SESSION["user"]->getValue("username"), PDO::PARAM_STR );
      $connection-> bindValue( ":purpose", $purpose, PDO::PARAM_STR );
      $connection-> bindValue( ":freeRoom", $roomNumber, PDO::PARAM_INT );
      $connection-> execute();
      echo "<h1>Booking Successful</h1><p>You booked room " . $roomNumber . " for " . gmdate("Y-m-d H:i:s", $unix_time) . "</p>";
    }
    catch (PDOException $e) {
      $databaseConnection = "";            //closes connection
      if ($e->errorInfo[1] == 1062) {
        //echo $e->getMessage();
        echo "<h1>Booking failed:</h1><p>You already have a booking for that time or the room is unavailble at that time</p>";
        displayForm();
      }
      else {
          echo "<h1>Booking failed:</h1><p>" . $e->getMessage() . "</p>";
      }                    
    }
    $databaseConnection = "";                       //closes connection 
  }
}



function displayForm() 
{
  $currentBookings = getFutureBookings();
  if(count($currentBookings) > 0)  {
    ?>
      <h1>Current Bookings:</h1>
      <?php
        echo "<table>"; 
        echo "<td>Time</td><td>Username</td><td>Room Number</td><td>Purpose</td>";
        foreach ($currentBookings as $booking)  {
          echo "<tr>";
          echo "<td>" . $booking["time"] . "</td>" . "<td>" . $booking["user"] . "</td>" . "<td>" . $booking["room"] . "</td>" . "<td>" . $booking["purpose"] . "</td>";
          echo "</tr>";
        }
        echo "</table>"; 
  }
  else  {
    echo "<h1>Currently no bookings:</h1>";
  }
  ?>
    <h1>Make a Booking:</h1>
        <?php displayDateOptions("makeBooking.php") ?>
        <p>
          <label for="purpose">Purpose</label>
          <input type="text" name="purpose" id="purpose" maxlength="129"/></td>           <!-- max length should probalby be defined as a constant in php -->
        </p>
        <label for="duration">Duration</label>
        <select name="duration" size="1">
        <?php

        for($i = 1; $i <= (Profile::maxFutureBookings($_SESSION["user"]->getValue("profile"))); $i++)
        {
          echo '<option value="' . $i . '">' . $i .'</option>';
        }
        ?>
         </select>
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
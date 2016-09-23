<?php
require_once( "common.inc.php" );
checkedLoggedIn();
insertStandardHTML( "Admin Account" );
?>

	<body>
		<div>

			<?php 
			DisplayEveryBooking();
			?>

		</div>

	</body>

<?

function DisplayEveryBooking(){//Print out the table that displays all bookings.

	try
  	{
    	$databaseConnection = getDatabaseConnection();

      $SecondConnection = getDatabaseConnection();
  	}catch ( PDOException $e ) 
  	{
  	  echo "Connection failed: " . $e->getMessage();
  	}

  	try //Print out the information.
  	{
      //Get the bookings from the database.
  		$result = mysqli_query($con,"SELECT * FROM bookings");

      echo "<table>
      <tr>
      <th>time</th>
      <th>user</th>
      <th>area</th>
      <th>room</th>
      </tr>";

      while($row = mysqli_fetch_array($result))
      {
      echo "<tr>";
      echo "<td>" . $row['time'] . "</td>";
      echo "<td>" . $row['user'] . "</td>";
      echo "<td>" . $row['area'] . "</td>";
      echo "<td>" . $row['room'] . "</td>";
      echo "</tr>";
      echo "<br />";
      }
      echo "</table>";
  		$databaseConnection = "";//Close connection.

  	}catch ( PDOException $e ) 
  	{
  		$databaseConnection = "";
  		echo "Error Occured: " . $e->getMessage();
  		die();//Close the connection.
  	}


}

displayFooter();
?>
<?php
require_once( "common.inc.php" );
checkedLoggedIn();
insertStandardHTML( "Admin Account" );
?>

	<body>
		<div>
		<form>
			<fieldset>
				<label for="search" class="cloak"></label>
				<input accesskey="s" type="text" name="q" id="search" value="Search Accounts" onfocus="if(this.value=='Search Accounts'){this.value='';this.style.color='#54575e';this.style.background='#ffffff';}else{this.select();}" onblur="if(this.value==''){this.value='Search Accounts';this.style.color='#54575e';this.style.background='#EDF1F8';}">
				<input type="image" src="//www.scss.tcd.ie/tms/m/styles/img/go.gif" class="submit" alt="Go" value="go">
			</fieldset>
		</form>

			<?php 
			SearchAccounts();
			?>

		</div>

	</body>

<?

function SearchAccounts(){//Print out the table that displays all users, and current booings.

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
      //Get the username and name from the database.
  		$userquery = "SELECT * FROM `users`"; 
  		$result = $databaseConnection -> query($userquery);

      //Generate time
      $time = time() - (time() % 3600);         //Rounds down to the start of the hour
      $time = gmdate("Y-m-d H:i:s", $time);

  		echo "<table>";
  		foreach($result as $row)
  		{
  			echo "<tr><td>" . $row['username'] . "</br>" . $row['name'] . "</td><td>";

        //Get the times that the user has booked.
        //The times shown are just for the bookings, that the user is waiting on.
        $timequery = "SELECT * FROM `bookings` WHERE `time` >= :time AND `user` = :user";
        //$timeresult = $SecondConnection -> query($timequery);
        $connection = $SecondConnection -> prepare($timequery);
        $connection -> bindValue( ":time", $time, PDO::PARAM_STR );
        $connection -> bindValue( ":user", $row['username'], PDO::PARAM_STR );
        $connection -> execute();
        $timeresult = $connection -> fetchall();

        foreach($timeresult as $timerow)//Print out the times.
        {
          echo $timerow['time'] . "   " . " in room: " . $timerow['room'] . "  for: " . $timerow['purpose'] . "</br>";
        }

        echo "</td></tr>";
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
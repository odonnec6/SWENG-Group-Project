<?php 
require_once( "common.inc.php" );
displayHeader( "Room Generator" );
displayDebugMessage();
?>
    <h1>Room Generator</h1>

      <?php
      echo "Only run if rooms have not been already generated, will raise exception otherwise.";
      $dsn = "mysql:dbname=bookingdata";
      $username = "root";               //Change to your username       
      $password = "root";               //Change to your password

      try 
      {
        $conn = new PDO( $dsn, $username, $password );
        $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
      } 
      catch ( PDOException $e ) 
      {
        echo "Connection failed: " . $e->getMessage();
      }

      $sql = "INSERT IGNORE INTO areas (ID, no_rooms, details) VALUES (0, 9, 'Test Area');";
      $conn->query( $sql );
      $sql = "DELETE FROM rooms WHERE number != -1";            //Can't alter raises exception
      $conn->query( $sql );
      for($i = 0; $i < 9; $i++)
      {
      if($i == 3)
      {
        $sql = "INSERT INTO rooms (number, area_number, capacity, monitor, other) VALUES ( " . ($i +1) . ", " . 0 . "," .  3 . ", " . 0 . ", 'test');";
      }
      else
      {
        $sql = "INSERT INTO rooms (number, area_number, capacity, monitor, other) VALUES ( " . ($i +1) . ", " . 0 . "," .  6 . ", " . 1 . ", 'test');";
      }
      $conn->query( $sql );
      }
      echo "<ul>";

      try 
      {
        $sql = "SELECT * FROM rooms";
        $rows = $conn->query( $sql );
        foreach ( $rows as $row ) 
        {
          echo "<li><b>Number:</b> " . $row["number"] . " <b>Area Number:</b> " . $row["area_number"] . " <b>Capacity:</b>" . $row["capacity"] . " <b>Monitor</b> " . $row["monitor"] . " <b>Other:</b> " . $row["other"] . "</li>";
        }
      } 
      catch ( PDOException $e ) 
      {
        echo "Query failed: " . $e->getMessage();
      }

      echo "</ul>";
      $conn = null;
        
      displayFooter();  
      ?>
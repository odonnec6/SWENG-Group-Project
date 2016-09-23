<?php 
require_once( "common.inc.php" );
displayHeader( "User Generator" );
displayDebugMessage();
?>

    <h1>User Generator</h1>

      <?php
      echo "Only run if rooms have not been already generated, will raise exception otherwise.";
      $dsn = "mysql:dbname=bookingdata";
      $username = "root";               //Change to your username       
      $password = "root";               //Change to your password
      $firstnames = array("Tom", "Bob", "Paul", "Cormac", "Glenn", "Sam", "Emma", "Amy", "Sandra", "Miranda", "Tim", "Jack", "Fiona", "Kate", "Mary", "Richard", "Zeus", "Judas");
      $sizeFirstnames = count($firstnames);
      $surnames = array("French", "Green", "Sharp", "Murphy", "Gleeson", "Stallman", "Cosgrave", "Monk", "Jones", "Black", "Trotsy", "Stalin", "Lenin", "Churchill", "Hughes", "Banner");
      $sizeSurnames = count($surnames);
      $firstname = "";
      $surname = "";

      try 
      {
        $conn = new PDO( $dsn, $username, $password );
        $conn->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
      } 
      catch ( PDOException $e ) 
      {
        echo "Connection failed: " . $e->getMessage();
      }
      for($i = 0; $i <= 200; $i++)
      {

        $firstname = $firstnames[rand(0, $sizeFirstnames-1)];
        $surname = $surnames[rand(0, $sizeSurnames-1)];
        $name = $firstname . " " . $surname;
        $level = rand(0, 10);
        $Username = $surname . $firstname . $i;
        $password = $Username;
        $salt = mcrypt_create_iv(32, MCRYPT_DEV_URANDOM);
        $hashedPassword = pbkdf2("SHA256", $password, $salt, COUNT,  KEY_LENGTH, RAW_OUTPUT);
        try {
          $sql = "INSERT INTO `users` (`username`, `name`, `profile`, `password`, `salt`, `courseCode`) VALUES ( :username, :name, 1, :password, :salt, 'BA.Test')";
          $testCon = $conn->prepare( $sql );
          $testCon-> bindValue( ":username", $Username, PDO::PARAM_STR );
          $testCon-> bindValue( ":name", $name , PDO::PARAM_STR );
          $testCon-> bindValue( ":password", $hashedPassword, PDO::PARAM_STR );
          $testCon-> bindValue( ":salt", $salt, PDO::PARAM_INT );
          $testCon-> execute();
        }
        catch ( PDOException $e ) 
        {
          echo "Query failed: " . $e->getMessage();
          die();
        }
      }
      echo "<ul>";

      try 
      {
        $sql = "SELECT * FROM users";
        $rows = $conn->query( $sql );
        foreach ( $rows as $row ) 
        {
          echo "<li><b>Username:</b> " . $row["username"] . " <b>Name:</b> " . $row["name"] . " <b>Profile:</b>" . $row["profile"] . " <b>Password</b> " . $row["password"] . " <b>CourseCode:</b> " . $row["courseCode"] . "</li>";
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
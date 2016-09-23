<?php

require_once "DataObject.class.php";

//Class to hold the currently logged in users data
//Basic outline/idea from PHP 5.3 by Matt Doyle
class User extends DataObject {
	protected $data = array(
		"username" => "",
		"name" => "",
		"profile" => "",
		"courseCode" => "",
		"password" => ""
		);

	public static function getUser( $username ) {
		$databaseConnection = parent::connect();
		$sql = "SELECT * FROM `users` WHERE username = :username";

		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection->bindValue( ":username", $username, PDO::PARAM_STR);
			$connection->execute();
			$queryResult = $connection->fetch();
			parent::disconnect( $databaseConnection );
			if($queryResult) {
				return new User( $queryResult );
			}
		}
		catch (PDOException $e){
			parent::disconnect( $databaseConnection );
			die ( "Invalid query: " . $e->getMessage() );
		}
	}

	public function loginUser() {
		$databaseConnection = parent::connect();
		$password;
		$salt;
		$sql = "SELECT `salt` FROM `users` WHERE `username` = :username";
		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection-> bindValue( ":username", $this->data["username"], PDO::PARAM_STR );
			$connection-> execute();
			$salt = $connection->fetchColumn(0);
			parent::disconnect( $databaseConnection );
			if( !$salt ) {
				echo "No salt or no user";
				return false;
			}
		}
		catch (PDOException $e) {
			parent::disconnect( $databaseConnection );
			die ( "Invalid query: " . $e->getMessage() );
		}
		$password = $this->data["password"];
		$password = pbkdf2("SHA256", $password, $salt, COUNT,  KEY_LENGTH, RAW_OUTPUT);					//Need to define these as constants
		$sql = "SELECT * FROM `users` WHERE username = :username AND password = :password";
		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection-> bindValue( ":username", $this->data["username"], PDO::PARAM_STR );
			$connection-> bindValue( ":password", $password , PDO::PARAM_STR );
			$connection-> execute();
			$queryResult = $connection->fetch();
			parent::disconnect( $databaseConnection );
			if( $queryResult ) {
				return new User( $queryResult );
			}
		}
		catch (PDOException $e) {
			parent::disconnect( $databaseConnection );
			die ( "Invalid query: " . $e->getMessage() );
		}
	}

	public static function getUsersByName( $name ) {
		//Retrives list of all users with a particular name	
	}

	public static function getUsersByProfile( $profile ) {
		//Retrives list of all users with a particular profile	
	}

	public static function getUsersByCourseCode( $courseCode ) {
		//Retrives list of all users with a particular course code	
	} 

	public function addNewUser() {
		//adds the current user to the table. Might be used to automate the process of adding users
		$databaseConnection = parent::connect();
        $salt = mcrypt_create_iv(32, MCRYPT_DEV_URANDOM);
        $hashedPassword = pbkdf2("SHA256", $this->data["password"], $salt, COUNT,  KEY_LENGTH, RAW_OUTPUT);
		$sql = "INSERT INTO `bookingdata`.`users` (`username`, `name`, `profile`, `password`, `courseCode`, `salt`) VALUES (:username, :name, :profile, :password, :courseCode, :salt)";
		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection-> bindValue( ":username", $this->data["username"], PDO::PARAM_STR );
			$connection-> bindValue( ":name", $this->data["name"], PDO::PARAM_STR );
			$connection-> bindValue( ":profile", $this->data["profile"], PDO::PARAM_INT );
			$connection-> bindValue( ":password", $hashedPassword, PDO::PARAM_STR );
			$connection-> bindValue( ":courseCode", $this->data["courseCode"], PDO::PARAM_STR );
			$connection-> bindValue( ":salt", $salt, PDO::PARAM_INT );
			$connection-> execute();
			parent::disconnect( $databaseConnection );
			if( $connection ) {
				return true;
			}
			else {
				echo "Execution failed";
			}
		}
		catch (PDOException $e) {
			parent::disconnect( $databaseConnection );
			echo $e->getMessage();
			die ( "Invalid query: " . $e->getMessage() );
			return false;
		}
	}

	public function updateProfile( $username, $newProfile) {
		//Updates the current profile of a user
	}

	public function updateCourseCode( $username, $newCourseCode) {
		//Updates the current course code of a user
	}

	public function debugResetPassword()
	{
		$databaseConnection = parent::connect();
        $salt = mcrypt_create_iv(32, MCRYPT_DEV_URANDOM);
        $hashedPassword = pbkdf2("SHA256", $this->data["username"], $salt, COUNT,  KEY_LENGTH, RAW_OUTPUT);

		$sql = "UPDATE `bookingdata`.`users` SET `password` = :newPassword WHERE `username` = :username";
		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection-> bindValue( ":username", $this->data["username"], PDO::PARAM_STR );
			$connection-> bindValue( ":newPassword", $hashedPassword, PDO::PARAM_STR );
			$connection-> execute();
			parent::disconnect( $databaseConnection );
		}
		catch (PDOException $e) {
			parent::disconnect( $databaseConnection );
			echo $e->getMessage();
			die ( "Invalid query: " . $e->getMessage() );
			return false;
		}

		$sql = "UPDATE `bookingdata`.`users` SET `salt` = :newSalt WHERE `username` = :username";
		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection-> bindValue( ":username", $this->data["username"], PDO::PARAM_STR );
			$connection-> bindValue( ":newSalt", $salt, PDO::PARAM_INT );
			$connection-> execute();
			parent::disconnect( $databaseConnection );
		}
		catch (PDOException $e) {
			parent::disconnect( $databaseConnection );
			echo $e->getMessage();
			die ( "Invalid query: " . $e->getMessage() );
			return false;
		}
	}

	public static function getUsersName( $username ) {
		$databaseConnection = parent::connect();
		$sql = "SELECT `name` FROM `users` WHERE username = :username";

		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection->bindValue( ":username", $username, PDO::PARAM_STR);
			$connection->execute();
			$queryResult = $connection->fetch();
			parent::disconnect( $databaseConnection );
			if($queryResult) {
				return $queryResult["name"];
			}
		}
		catch (PDOException $e){
			parent::disconnect( $databaseConnection );
			die ( "Invalid query: " . $e->getMessage() );
		}
	}
}
?>
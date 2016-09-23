<?php

require_once "DataObject.class.php";

//Class to hold the profile of a user
//Basic outline/idea from PHP 5.3 by Matt Doyle
class Profile extends DataObject {
	protected $data = array(
		"id" => "",
		"Name" => "",
		"Description" => "",
		"Booking_limit" => "",
		"Max_number_bookings" => ""
		);

	public static function getProfile( $profile_number ) {
		$databaseConnection = parent::connect();
		$sql = "SELECT * FROM `profile` WHERE `id` = :id";

		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection->bindValue( ":id", $profile_number, PDO::PARAM_STR);
			$connection->execute();
			$queryResult = $connection->fetch();
			parent::disconnect( $databaseConnection );
			if($queryResult) {
				return new Profile( $queryResult );
			}
		}
		catch (PDOException $e){
			parent::disconnect( $databaseConnection );
			die ( "Invalid query: " . $e->getMessage() );
		}
	}

	public function addNewProfile() {
		//adds the current profile to the table. Might be used to automate the process of adding profile
		$sql = "INSERT INTO `bookingdata`.`profile` (`Name`, `Description`, `Booking_limit`, `Max_number_bookings`) VALUES (:Name, :Des, :lim, :maxBook);";
		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection-> bindValue( ":Name", $this->data["Name"], PDO::PARAM_STR );
			$connection-> bindValue( ":Des", $this->data["Description"], PDO::PARAM_STR );
			$connection-> bindValue( ":lim", $this->data["Booking_limit"], PDO::PARAM_INT );
			$connection-> bindValue( ":maxBook", $this->data["Max_number_bookings"], PDO::PARAM_INT );
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

	public static function maxFutureBookings($idNumber) {
		$databaseConnection = parent::connect();
		$sql = "SELECT * FROM `profile` WHERE `id` = :id";

		try {
			$connection = $databaseConnection->prepare( $sql );
			$connection->bindValue( ":id", $idNumber, PDO::PARAM_STR);
			$connection->execute();
			$queryResult = $connection->fetch();
			parent::disconnect( $databaseConnection );
			if($queryResult) {
				$profile = new Profile( $queryResult );
			}
		}
		catch (PDOException $e){
			parent::disconnect( $databaseConnection );
			die ( "Invalid query: " . $e->getMessage() );
		}
		return $profile->getValue("Max_number_bookings");
	}
}
?>
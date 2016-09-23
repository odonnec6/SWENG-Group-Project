<?php
require_once "config.php";

//Abstract class that is inherited by classes that access the database. 
//Outline/idea from PHP 5.3 by Matt Doyle
abstract class DataObject {
	protected $data = array(); 	


	public function __construct( $data ) {
		foreach ( $data as $key => $value) {
			if( array_key_exists( $key, $this->data)) {
				$this->data[$key] = $value;
			}
		}
	}

	public function getValue( $field ) {
		if( array_key_exists( $field, $this->data ) ) {
			return $this->data[$field];
		}
		else {
			die("Field does not exists");
		}
	}

	public function getValueEncoded( $field ) {
		return htmlspecialchars( $this->getValue( $field ) );
	}

	protected static function connect() {
		try {
			$databaseConnection = new PDO( DB_NAME, DB_USERNAME, DB_PASSWORD );
			$databaseConnection->setAttribute( PDO::ATTR_PERSISTENT, true);
			$databaseConnection->setAttribute( PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION );
		}
		catch (PDOException $e ){
			die( "Could not start connection: " . $e->getMessage() );
		}
		return $databaseConnection;
	}

	protected static function disconnect( $databaseConnection ) {
		$databaseConnection = ""; 			//Removes pointer, garbage collector frees memory
	}

}

?>
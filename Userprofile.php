<?php 
require_once( "common.inc.php" );
session_start();

if ( isset( $_POST["submitButton"] ) ) {
  processForm();
} else {
	insertStandardHTML( "User Profile" );
	displayuserinfo();
}

function displayuserinfo(){
?>
	<body>
		<div>
			<h1>User info:</h1>
			<h2>General information:</h2>
			<h2>Profile:</h2>
				<p>Name:	<?php echo $_SESSION["user"]->getValue("name") ?></p>
				<p>UserName:	<?php echo $_SESSION["user"]->getValue("username") ?></p>
				<p>Status:	(Student/Teacher/Admin/(Blacklist?))</p>
				<p>Member of groups:	</p>
				</br>
		</div>

		<div>
			<h2>Booking information</h2>
			<p>Current bookings:</p>

		</div>
	</body>
<?php
}

displayFooter();
?>
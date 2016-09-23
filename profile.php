<?php
require_once( "common.inc.php" );
checkedLoggedIn();
insertStandardHTML( "Profile" );
if ( isset( $_POST["submitButton"] ) ) {
  createNewGroup($_POST["groupName"]);
} 

$userProfile = Profile::getProfile($_SESSION["user"]->getValue("profile"));
?>
	<body>

			<div>
				<h2>Profile:</h2>
				<p>Name:	<?php echo $_SESSION["user"]->getValue("name") ?></p>
				<p>UserName:	<?php echo $_SESSION["user"]->getValue("username") ?></p>
				<p>Status:	(Student/Teacher/Admin/(Blacklist?))</p>
				<p>Profile ID:	<?php echo $userProfile->getValue("id")?></p>
				<p>Profile Name:	<?php echo $userProfile->getValue("Name")?></p>
				<p>Profile Description:	<?php echo $userProfile->getValue("Description")?></p> 
				<p>Bookings can be made (days in advance):	<?php echo $userProfile->getValue("Booking_limit")?></p>
				<p>Max bookings at a time:	<?php echo $userProfile->getValue("Max_number_bookings")?></p>
				</br>
			</div>	

			<form action="profile.php" method="post">
      		<div style="width: 30em; padding-left: 10px;">
				<h2>Group Creation:</h2>
				<p>Group Name	<input type="text" name="groupName"></p>
				<div style="clear: both;">
            <input type="submit" name="submitButton" id="submitButton" value="Send Details" />
            <input type="reset" name="resetButton" id="resetButton" value="Reset Form" style="margin-right: 20px;" />
        </div>
			</div>
			</form>

	</body>
<?php
displayFooter()
?>

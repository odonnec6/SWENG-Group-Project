<?php 
require_once( "common.inc.php" );
checkedLoggedIn();
insertStandardHTML( "Logout" );

if ( isset( $_POST["submitButton"] ) ) {
  processForm();
} else {
  displayForm();
}


function displayForm() {
?>
	<div></div>
	<div id="loginarea">
		<table id="logintable" cellspacing="0"/>
			<tbody>
				<form action="logout.php" method="post">
					<label for="logout">Logout?</label>	
					<input type="submit" name="submitButton" id="submitButton" value="Submit" />
				</form>
			</tbody>
		</table>
		<div id="details">
			Placholder: Details
		</div>
	</div>
	<div id="footer"></div>	
<?php
}

function processForm() {
	$_SESSION["user"] = "";
	echo "You have now logged out";
}
displayFooter();
?>
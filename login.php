<?php 
require_once( "common.inc.php" );
session_start();
if(!alreadyLoggedIn())  {
	if ( isset( $_POST["submitButton"] ) ) {
	  processForm();
	} else {
		insertStandardHTML( "Login" );
	  	displayForm();
	}
}
else {
	header( "Location: makeBooking.php" );
    exit;
}


function displayForm() {
?>
	<div></div>
	<div id="loginarea">
		<table id="logintable" cellspacing="0"/>
			<tbody>
				<form action="login.php" method="post">	
					<tr>
						<td title = "College Username"><font color = "black">Username</font></td>
						<td><input type="text" name="username" id="username"/></td>
					</tr>
					<tr>
						<td><font color = "Black">Password</font></td>
						<td><input type="password" name="password" id="password"/></td>
					</tr>
					<tr>
						<td ="black"/>
						<td><input type="submit" name="submitButton" id="submitButton" value="Submit" /></td>
					</tr>	
				</form>
			</tbody>
		</table>

	</div>

	<div style = "bottom: 0;">
		<h1><b>Rules:</b></h1>
		<p>
		<ul>
		<li>Bookings can only be made 1 week in advance.</br>
		<li>Bookings can be made for at most two hours.</br>
		<li>You can make up to two bookings at one time.</br>
		<li>Please confirm if you have used your booking.</br>
		<li>Bookings become void if room has not been occupied by the relevant party after 10 minutes.</br>
		</ul></p>	
	</div>

<?php
}

function processForm() {
	$user = new User(array("username" => $_POST['username'],
							"password" => $_POST['password']));
	if($loggedUser = $user->loginUser()) {
		$_SESSION["user"] = $loggedUser;
		header( "Location: makeBooking.php" );
		exit;
	}
	else {
		insertStandardHTML( "Login" );
		echo "Username or password is invalid";
		displayForm();
	}
}

//Checks to see if the user is already logged in. If not redirected to the login page
function alreadyLoggedIn() {
	return ( isset($_SESSION["user"]) && $_SESSION["user"] && $_SESSION["user"] = User::getUser( $_SESSION["user"]->getValue( "username" ) ) ) ;
}

displayFooter();
?>

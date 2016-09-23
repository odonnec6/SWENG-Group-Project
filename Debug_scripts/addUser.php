<?php 
require_once( "../common.inc.php" );
session_start();
insertStandardHTML( "Add User" );
displayDebugMessage();

if ( isset( $_POST["submitButton"] ) ) {
	if( allFieldsValid() ) {
		  processForm();
	}
	else {
		echo "There was an error";
		displayForm();
	}
} else {
  displayForm();
}

function allFieldsValid() {
	if( ($_POST["username"] != "") && ($_POST["name"] != "") && ($_POST["profile"] != "") &&  ($_POST["courseCode"] != "") && ($_POST["password1"] != "") ) {
		  if(!is_numeric($_POST["profile"]) ) {								//Just checks Numeric, could accept float in error
		  	echo "Profile is not an integer";
		  }
		  if($_POST["password1"] != $_POST["password2"]) {
		  	echo " Passwords not equal";
		  }
	}
	else {
		echo "A field is empty";
		return false;
	}
	return true;
}

function displayForm() {
?>
	<div></div>
	<div id="loginarea">
		<table id="logintable" cellspacing="0"/>
			<tbody>
				<form action="addUser.php" method="post">	
					<tr>
						<td title = "College Username"><font color = "black">Username</font></td>
						<td><input type="text" name="username" id="username"/></td>
					</tr>
					<tr>
						<td title = "Name"><font color = "black">Name</font></td>
						<td><input type="text" name="name" id="name"/></td>
					</tr>
					<tr>
						<td title = "Profile"><font color = "black">Profile</font></td>
						<td>
	        				<select name="profile" size="1">
								<?php
								$profiles = getListOfProfiles();
								foreach($profiles as $profile)
								{
									echo '<option value="' . $profile["id"] . '">' . $profile["Description"] .'</option>';
								}
								?>
							</select>
						</td>
						
					</tr>
					<tr>
						<td title = "Course Code"><font color = "black">Course Code</font></td>
						<td>
	        				<select name="courseCode" size="1">
								<?php
								$courseCodes = getListOfCourseCodes();
								foreach($courseCodes as $course)
								{
									echo '<option value="' . $course["courseCode"] . '">' . $course["courseCode"] .'</option>';
								}
								?>
							</select>
						</td>
					</tr>
					<tr>
						<td><font color = "Black">Password</font></td>
						<td><input type="text" name="password1" id="password1"/></td>
					</tr>
					<tr>
						<td><font color = "Black">Confirm Password</font></td>
						<td><input type="text" name="password2" id="password2"/></td>
					</tr>
					<tr>
						<td ="black"/>
						<td><input type="submit" name="submitButton" id="submitButton" value="Submit" /></td>
					</tr>	
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
	$user = new User(array("username" => $_POST['username'],
							"name" => $_POST['name'],
							"profile" => intval($_POST['profile']),
							"courseCode" => $_POST['courseCode'],
							"password" => $_POST['password1']));
	$user = $user -> addNewUser();
	if($user) {
		echo "Added new user";
	}
	else {
		echo "Could not add new user";
	}
}
displayFooter();
?>

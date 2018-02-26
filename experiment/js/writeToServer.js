function writeUserData (subjInfo, DB) {
		var userID = 0;
		// Make first POST synchronous so that the second
		// POST will have access to the updated userID variable
		$.ajax({
			type:"POST",
			url: "database/writeSubj.php",
			data:{'subjInfo': subjInfo, 'DB':DB},
			success: function(data) {
				userID = data;
			},
			async:false			
		});
		$.ajax({
			type:"POST",
			url: "database/getComputerData.php",
			data:{'userID': userID, 'DB':DB}
		});	
		return userID;
}

function writeTrialData (expData, trial, dbTableName, DB) {

		$.ajax({
			type: "POST",
			url: "database/writeData.php",
			data: {'expData': expData, 'userID': userID, 'dbTableName': dbTableName, 'DB':DB},
			success: function(response) {
				console.log(response);
			}
							
		});	
		
}

function updateStringField (ID, table, field, value, DB) {

		$.ajax({
			type: "POST",
			url: "database/updateStringField.php",
			data: {'ID': ID, 'table': table, 'field': field, 'value': value, 'DB':DB},
			success: function(response) {
				console.log(response);
			}
							
		});	
		
}



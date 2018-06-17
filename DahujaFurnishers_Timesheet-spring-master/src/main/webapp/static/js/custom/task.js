function edit_row(no) {
	document.getElementById("edit_button" + no).style.display = "none";
	document.getElementById("save_button" + no).style.display = 'inline-block';
	document.getElementById("date_text" + no).style.display = "block";
	document.getElementById("date_row" + no).style.display = "none";

	var name = document.getElementById("name_row" + no);
	var description = document.getElementById("desc_row" + no);
	var comment = document.getElementById("comment_row" + no);
	var status = document.getElementById("status_row" + no);
	var date = document.getElementById("date_row" + no);
	


	var name_data = name.innerHTML;
	var description_data = description.innerHTML;
	var comment_data = comment.innerHTML;
	var status_data = status.innerHTML;
	var date_data = date.innerHTML;
	
	var d = new Date(date_data),
    month = '' + (d.getMonth() + 1),
    day = '' + d.getDate(),
    year = d.getFullYear();

	name.innerHTML = "<input type='text' id='name_text" + no + "' value='"
			+ name_data + "'>";
	description.innerHTML = "<input type='text' size=35 id='desc_text" + no
			+ "' value='" + description_data + "'>";
	comment.innerHTML = "<input type='text' id='comment_text" + no
			+ "' value='" + comment_data + "'>";

	status.innerHTML = "<select class='selectpicker form-control' name='status' id='status_text"+ no
			+ "'><option value='Not Started '  id=option0"+no+">Not Started</option><option id=option1"+no+" value='In Progress'>In Progress</option><option id=option2"+no+" value='Done'>Done</option></select>";

	if(status_data==="In Progress")
	{
		
		$("select option[id=option1"+no+"]").attr("selected","selected");
	}
	else if(status_data==="Done")
		{
		$("select option[id=option2"+no+"]").attr("selected","selected");
		}
}

function save_row(no, userid) {

	var name_val = document.getElementById("name_text" + no).value;
	var description_val = document.getElementById("desc_text" + no).value;
	var comment_val = document.getElementById("comment_text" + no).value;
	var status_val = document.getElementById("status_text" + no).value;
	var date_val = document.getElementById("date_text" + no).value;
	
	var d = new Date(date_val),
    month = '' + (d.getMonth() + 1),
    day = '' + d.getDate(),
    year = d.getFullYear();

	document.getElementById("name_row" + no).innerHTML = name_val;
	document.getElementById("desc_row" + no).innerHTML = description_val;
	document.getElementById("comment_row" + no).innerHTML = comment_val;
	document.getElementById("status_row" + no).innerHTML = status_val;
	document.getElementById("date_row" + no).innerHTML = year+"-"+month+"-"+day;	

	document.getElementById("edit_button" + no).style.display = "block";
	document.getElementById("save_button" + no).style.display = "none";
	document.getElementById("date_row" + no).style.display = "block";
	document.getElementById("date_text" + no).style.display = "none";

	var data = {
		"id" : no,
		"name" : name_val,
		"description" : description_val,
		"taskDate" : date_val,
		"comments" : comment_val,
		"status" : status_val,
		"userId" : userid
	};

	$.ajax({
		type : "POST",
		url : "save-task",
		data : data,
		success : function(data) {

		},
		dataType : "html",
		beforeSend : function(xhr) {
			xhr.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
		},
	});

}

function delete_row(no, userid) {
	
	document.getElementById("row" + no).style.display = "none";

	$.ajax({
		type : "GET",
		url : "delete-task",
		data : "userid="+userid+"&id="+no,
		success : function(data) {

		},
		dataType : "html",
		beforeSend : function(xhr) {
			xhr.setRequestHeader('Content-Type',
					'application/x-www-form-urlencoded');
		},
	});

}

function validateForm() {

	var date = document.forms["taskForm"]["taskDate"].value;
	var taskname = document.forms["taskForm"]["name"].value;
	if (date.trim() == "" || taskname.trim() == "") {
		document.getElementById("error").innerHTML = "Please fill all mandatory fields!";
		return false;
	}
}


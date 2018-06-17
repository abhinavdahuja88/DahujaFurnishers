
function viewCalendar(employeeId)
{	
		
	calObject.fullCalendar('removeEvents');

	
	calObject.fullCalendar({
		height : 500,	
		editable : false,
		eventLimit : false, // allow "more" link when too many events
		events : null,
		displayEventTime: false,
		
		eventRender : function(event, element) {
			if (event.title == "Leave") {
				element.css('background-color', '#ff0000');
			}
			
			if (event.type == "task") {
				element.css('background-color', '#c2acac');
			}
		},
		
		eventClick : function(calEvent, jsEvent, view) {
			removingeventid = calEvent.id;
		}
		

	});	
	
		$.ajax({
			type : "GET",
			url : "get-attendance-data",
			data : "employeeId="+employeeId,
			success : function(data) {					
				calObject.fullCalendar('renderEvents', JSON.parse(data), true);
			
				},
			dataType : "html"
		
		});
		
		

		$.ajax({
			type : "GET",
			url : "get-profile",
			data : "employeeId="+employeeId,
			success : function(data) {	
				var profile=JSON.parse(data);		
				document.getElementById('user-profile').style.display = "block";
				
				$('#employee-name').text(profile["employeeName"]);
				$('#employee-phone').text(profile["employeePhone"]);
				$('#employee-address').text(profile["currentAddress"]);
				
				},
			dataType : "html"
		
		});
}




<!DOCTYPE HTML>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ include file="header.jsp"%>

<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">

<title>My Calendar</title>



<script type="text/javascript"
	src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>
	<script src='static/js/bootstrap-timepicker.js'></script>
<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />
<link href='static/css/fullcalendar.min.css' rel='stylesheet' />

<link href='static/css/bootstrap-timepicker.css' rel='stylesheet' />
<link href='static/css/fullcalendar.print.min.css' rel='stylesheet'
	media='print' />
<script src='static/js/lib/moment.min.js'></script>
<script src='static/js/fullcalendar.min.js'></script>
<script src='static/js/custom/calendar.js'></script>

<script>
     sessionStorage.setItem("calenderPageVisited", "True");
</script>


<script type="text/javascript">
	$(function() {
		$('#timepicker1').timepicker();
	});
</script>



<style>
body {
	padding: 0;
	font-family: "Lucida Grande", Helvetica, Arial, Verdana, sans-serif;
	font-size: 14px;
}

#calendar {
	max-width: 900px;
	margin: 0 auto;
}
</style>
</head>

<body onload="myTasks(<%=userId%>)">

	<%
		String d1 = (String) request.getAttribute("caldata");
	%>

	<!-- begin #sidebar -->
	<div id="sidebar" class="sidebar">
		<!-- begin sidebar nav -->
		<ul class="nav" id="leftNavList">

			<li class="has-sub"><a href="javascript:;" onclick="openCalendar()"> <span> Calendar </span></a></li>
			
			<li class="has-sub"><a href="javascript:;" onclick="openLeaveDetails()"> <span> Leave Details</span> </a></li>
			
						<li class="has-sub"><a href="javascript:;" onclick="openLeaveDetails()"> <span> test Details</span> </a></li>
			
			
			<c:forEach var="member" items="${teamlist}" varStatus="myIndex">
				<li class="has-sub">
					<button type="button" id="btn-employee-${myIndex.index}"
						onclick='viewCalendar(${member.employeeId})'
						class='list-group-item list-group-item-action'>${member.employeeName}-(${member.employeeId})</button>

				</li>
			</c:forEach>
		</ul>

	</div>
	<!-- end #sidebar -->



	<div id="content" class="content">
		<!-- begin panel -->
		<div class="panel panel-inverse collapse" id="leavePanel">
			<div class="panel-heading">
				<h4 class="panel-title">Leave Details</h4>

			</div>
			<div class="panel-body">
				<div class="table-responsive" id="user-leave-status">
					<table class="table table-stripped table-bordered text-left">
						<col width="60">
						<col width="120">
						<thead>
							<tr>
								<th>Year</th>
								<th>Total Leaves</th>
								<th>Availed</th>
								<th>Balance</th>
							</tr>
						</thead>
						<tr>
							<td id="leave-year">2017</td>
							<td id="leave-total">24</td>
							<td id="leave-availed">${leaveAvailed}</td>
							<td id="leave-balance"></td>
						</tr>
					</table>
				</div>

			</div>
		</div>
		<!-- end panel -->
		<!-- begin panel -->
		<div class="panel panel-inverse" id="calendarPanel">
			<div class="panel-heading">
				<h4 class="panel-title">Calendar</h4>
			</div>
			<div class="panel-body">
				<div class="container-fluid" id="tasksDiv">

					<div>
						<div id='calendar'></div>
					</div>
				</div>

			</div>
		</div>
		<!-- end panel -->
	</div>

	<!--Primary Modal -->
	<div class="modal fade myddmodel" id="primaryModal" role="dialog">
		<div class="modal-dialog modal-sm-4">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<!-- <button type="button" class="close" data-dismiss="modal">&times;</button> -->

					<p id="errMsg" style="display: none; color: red;">Error message	goes here</p>
					<!-- 	<h4 class="modal-title">In Time</h4> -->


				</div>
				<div class="modal-body">

					<div class="input-group bootstrap-timepicker timepicker">
						<input id="timepicker1" value="10:00 AM" type="text" name="inTime"
							class="form-control input-small"> <span
							class="input-group-addon"><i
							class="glyphicon glyphicon-time"></i></span>
					</div>
			                    
              
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-default" data-dismiss="modal"
						onclick="addTask()">Add Task</button>
					<button type="button" class="btn btn-default"
						onclick="putCalData('Leave','<%=userId%>')">Leave</button>
					<button type="button" class="btn btn-default"
						onclick="putCalData('present','<%=userId%>')">Present</button>
					<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
				</div>

			</div>

		</div>
	</div>

	<!-- Add Task Modal -->
	<div class="modal fade" id="taskModal" role="dialog">
		<div class="modal-dialog modal-sm-6">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<p id="error" style="display: none; color: red;"></p>
					<h4 class="modal-title">New Task</h4>

				</div>
				<div class="modal-body">
					<form class="form-horizontal" name="taskForm" id="taskForm"
						action="save-task" onsubmit="return validateForm()" method="post">
						<input type="hidden" name="id" value="${task.id}" /> <input
							type="hidden" name="userId" value="<%=userId%>" />
						<div class="form-group">
							<label class="control-label col-md-3">Task Name*</label>
							<div class="col-md-5">

								<input type="text" name="name" class="form-control"
									placeholder="Task Name*" value="${task.name}" />
							</div>
						</div>
						<div class="form-group">
							<label class="control-label col-md-3">Description</label>
							<div class="col-md-5">
								<input type="text" name="description"
									placeholder="Task Description" class="form-control"
									value="${task.description}" />
							</div>
						</div>

						<div class="form-group">

							<label class="control-label col-md-3">Date</label>
							<div class="col-md-5">
								<!-- <p id="task_date" name="taskDate"></p> -->

								<input name="taskDate" id="task_date" class="form-control"
									readonly />
							</div>


						</div>

						<div class="form-group">
							<label class="control-label col-md-3">Comments</label>
							<div class="col-md-5">
								<input type="text" name="comments"
									placeholder="Comments if any!" class="form-control"
									value="${task.comments}" />
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-md-3">Status</label>
							<div class="col-md-5">
								<select class="selectpicker form-control" name="status">
									<option value="Not Started">Not Started</option>
									<option value="In Progress">In Progress</option>
									<option value="Done">Done</option>
								</select>

							</div>
						</div>

						<div class="form-group">
							<input type="button" onclick="submitTask()"
								class="btn btn-primary" value="Save" />

						</div>
					</form>

				</div>

			</div>

		</div>
	</div>



	<!--  Task Details Modal -->
	<div class="modal fade" id="taskDetailsModal" role="dialog">
		<div class="modal-dialog ">

			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title" id="task_title"></h4>

				</div>
				<div class="modal-body">
					<table
						class="table table-stripped table-bordered text-left  table2excel"
						id="task-history">

						<col width="300">
						<col width="100">
						<col width="200">

						<thead>
							<tr>
								<th>Description</th>
								<th>Status</th>
								<th>Comments</th>

							</tr>
						</thead>
						<tbody>

							<tr id="${task.id}">
								<td id="task_desc"></td>
								<td id="task_status"></td>
								<td id="task_comment"></td>
							</tr>
						</tbody>

					</table>

				</div>

			</div>

		</div>
	</div>
</body>

<script>
var availleave=${leaveAvailed};
var leave_balance=24-${leaveAvailed};
$('#leave-balance').text(leave_balance);

	var inDate;
	var oldevent;
	var initialEvents =<%=d1%>;
	var calObject = $('#calendar');

	calObject.fullCalendar({
		height : 550,
		
		editable : true,
		eventLimit : false, // allow "more" link when too many events
		events : initialEvents,
		displayEventTime: false,
		ignoreTimezone :false,
		
		dayClick : function(date, jsEvent, view) {
			document.getElementById("errMsg").style.display = 'none';
			
			inDate = new Date(date.format());
            // change the day's background color just for fun
			//$(this).css('background-color', 'gray');
			jQuery.noConflict();
			$('#primaryModal').modal();
			document.getElementById("errMsg").style.display = 'none';		

		},

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
			jQuery.noConflict();
			
			if(calEvent.type=="task")
				{
				$('#taskDetailsModal').modal();
				document.getElementById("task_title").innerHTML = calEvent.title;
				document.getElementById("task_desc").innerHTML = calEvent.description;
				document.getElementById("task_status").innerHTML = calEvent.status;
				document.getElementById("task_comment").innerHTML = calEvent.comments;
					
				}
			else
				{
			//$('#removeModal').modal();
				}

		}
	});
	

	function openCalendar()
	{
		document.getElementById("calendarPanel").style.display="block";
		document.getElementById("leavePanel").style.display="none";
	}

	function openLeaveDetails()
	{
		document.getElementById("calendarPanel").style.display="none";
		document.getElementById("leavePanel").style.display="block";
	}


</script>
<script src="static/js/jquery.min.js"></script>
<script src='static/js/bootstrap-timepicker.js'></script>
</html>

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

<title>Task Manager | Home</title>

<!-- Include Date Range Picker -->
<script type="text/javascript"
	src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>
<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />
<link href="static/css/jquery.dataTables.min.css" rel="stylesheet">


<script type="text/javascript" src="static/js/tableExport.js"></script>
<script type="text/javascript" src="static/js/jquery.base64.js"></script>
<script src='static/js/html2canvas.js'></script>
<script type="text/javascript" src='static/js/sprintf.js'></script>
<script type="text/javascript" src='static/js/jspdf.js'></script>
<script type="text/javascript" src='static/js/base64.js'></script>
<script type="text/javascript" src="static/js/jquery.dataTables.min.js"></script>
<script src='static/js/custom/task.js'></script>

</head>
<body>

	<div id="content" class="content">
		<h1 class="page-header1">My Tasks</h1>
		<!-- begin panel -->
		<div class="panel panel-inverse">
			<div class="panel-heading">
				<h4 class="panel-title">Task List</h4>
			</div>
			<div class="panel-body">
				<c:choose>
					<c:when test="${mode == 'MODE_TASKS'}">
						<div id="tasksDiv">

							<div id="errorDiv">
								<p id="error" style="color: red; font-size: 20px;"></p>
							</div>


							<form class="form-inline" id="new-task-from" method="POST"
								action="save-task" name="taskForm"
								onsubmit="return validateForm()">
								<input type="hidden" name="userId" value="<%=userId%>" />
								<div class="form-group">
									<input type="text" class="form-control" id="task-name"
										name="name" placeholder="Task Name">
								</div>
								<div class="form-group">
									<input type="text" class="form-control" id="task-desc"
										name="description" placeholder="Description">
								</div>

								<div class="form-group">
									<input class="form-control" name="taskDate" id="task-date"
										placeholder="YYYY/MM/DD*" type="text">
								</div>

								<div class="form-group">
									<select class="selectpicker form-control" name="status"
										id="task-status">
										<option value="Not Started">Not Started</option>
										<option value="In Progress">In Progress</option>
										<option value="Done">Done</option>
									</select>
								</div>

								<div class="form-group">
									<input type="text" class="form-control" id="task-comment"
										name="comments" placeholder="Comments">
								</div>
								<button type="submit" class="btn btn-primary">Add New</button>


								<ul class="nav navbar-nav pull-right">
									<li class="dropdown"><a class="dropdown-toggle"
										data-toggle="dropdown" href="#">Export<span class="caret"></span></a>
										<ul class="dropdown-menu">

											<li><a class="export-excel">Excel</a></li>

											<li><a class="export-csv">CSV</a></li>
										</ul></li>
								</ul>

							</form>

							<br> <br>
							<div class="table-responsive">
								<table
									class="table table-stripped table-bordered text-left  table2excel"
									id="task-history">

									<col width="60">
									<col width="150">
									<col width="300">
									<col width="160">
									<col width="100">
									<col width="200">
									<col width="60">
									<col width="60">
									<thead>
										<tr>
											<th>Id</th>
											<th>Task Name</th>
											<th>Description</th>
											<th>Task Date</th>
											<th>Status</th>
											<th>Comments</th>
											<th></th>
											<th></th>
										</tr>
									</thead>
									<tbody>


										<c:forEach var="task" items="${tasks}">
											<tr id="row${task.id}">
												<td>${task.id}</td>
												<td id="name_row${task.id}">${task.name}</td>
												<td id="desc_row${task.id}">${task.description}</td>
												<td><p id="date_row${task.id}">
														<fmt:formatDate pattern="yyyy-MM-dd"
															value="${task.taskDate}" />
													</p> <input style="display: none;" size=30
													class='form-control new-date' id="date_text${task.id}"
													name='taskDate' placeholder='YYYY/MM/DD*' type='text'
													value=<fmt:formatDate pattern="yyyy-MM-dd" value="${task.taskDate}" /> /></td>


												<td id="status_row${task.id}">${task.status}</td>

												<td id="comment_row${task.id}">${task.comments}</td>

												<td>
													<button type="button" id="delete_button${task.id}"
														onclick="delete_row('${task.id}',<%=userId%>)"
														class="btn btn-danger">
														<span class="glyphicon  glyphicon-trash"></span>
													</button>
												</td>

												<td>

													<button type="button" id="save_button${task.id}"
														onclick="save_row('${task.id}',<%=userId%>)"
														class="btn btn-success" style="display: none;">
														<span class="glyphicon  glyphicon-floppy-disk"></span>
													</button>

													<button type="button" id="edit_button${task.id}"
														onclick="edit_row('${task.id}')" class="btn btn-info">
														<span class="glyphicon glyphicon-pencil"> </span>
													</button>

												</td>

											</tr>

										</c:forEach>

									</tbody>

								</table>
							</div>


						</div>
					</c:when>

				</c:choose>
			</div>
			<!-- begin end -->
		</div>
	</div>
	<script>
		$(document).ready(
				function() {

					var date_input = $('input[name="taskDate"]'); //our date input has the name "date"
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
							
					date_input.datepicker({
						format : 'yyyy/MM/dd',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})

		$(document).ready(function() {
			// DataTable
			var table = $('#task-history').DataTable();

		});

	$(".export-excel").click(function(){
		 $('.table2excel').tableExport({type:'excel',escape:'false'});
		 
	});

	$(".export-pdf").click(function(){
		 $('.table2excel').tableExport({type:'pdf', pdfFontSize:'8',escape:'false'});
		 
	});
	
	$(".export-csv").click(function(){
		 $('.table2excel').tableExport({type:'csv',escape:'false'});
		 
	});
	
	</script>



	<script>
	
	$(function() {
		  $("#new-task-from").on("submit",function (e) {
		    e.preventDefault(); // stop the normal submission
		    var name_val       = $("#task-name").val(); 
		    var description_val  = $("#task-desc").val();		    
		    var date_val       = $("#task-date").val(); 
		    var comment_val  = $("#task-comment").val();		    
		    var status_val  = $("#task-status").val(); 
		    
			var data = {
					"name" : name_val,
					"description" : description_val,
					"taskDate" : date_val,
					"comments" : comment_val,
					"status" : status_val,
					"userId" : '<%=userId%>'
				};
		    
		    $.post("save-task", data,
		     function(res){ 
		    	   var id=res.id;
		    	   
		    	   var dateVal ="/Date("+res.taskDate+")/";
		    	   var date = new Date(parseFloat(dateVal.substr(6)));
		    	   var task_date= date.getFullYear()+'-'+(date.getMonth() + 1)+'-'+date.getDate();  	   
		    	   
		   $('#task-history tr:first').after(
				  "<tr id=row"+id+"><td > "+id+"</td><td id=name_row"+id+">"+res.name+"</td><td id=desc_row"+id+">"+res.description+"</td><td><p id=date_row"+id+">"+task_date+"</p><input style='display: none;' size=30	class='form-control new-date' id=date_text" + id +"	name='taskDate' placeholder='YYYY/MM/DD*' type='text'	value="+ task_date+" /></td><td id=status_row"+id+">"+res.status+"</td><td id=comment_row"+id+">"+res.comments+"</td><td><button  type='button'	id='delete_button" + id + "'	onclick='delete_row(" + id +","+res.userId+")'   class='btn btn-danger' ><span class='glyphicon  glyphicon-trash'></span></button> </td><td><button  type='button'	id='save_button" + id + "'	onclick='save_row(" + id +","+res.userId+")'   class='btn btn-success'   style='display: none;' >	<span class='glyphicon  glyphicon-floppy-disk'></span></button> <button  type='button'	id='edit_button" + id + "'	onclick='edit_row(" + id +","+res.userId+")'   class='btn btn-info'  >	<span class='glyphicon  glyphicon-pencil'></span></button></td></tr>"
                     )
		    			    
		    });
		    
			document.taskForm.reset();
		       
		   });
		  
		 });
	
	
	</script>
</body>
</html>
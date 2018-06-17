
<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>
<%@ include file="header.jsp"%>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">


<title>My Profile</title>

<!-- Include Date Range Picker -->
<script type="text/javascript"
	src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>
<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />



</head>
</head>
<body>
	<div id="content" class="content">
		<c:set var="bg" value="${userProfile.bloodGroup}" />
		<%
			String blood = (String) pageContext.getAttribute("bg");
		%>

		<c:choose>
			<c:when test="${mode == 'MODE_PROFILE'}">
				<div>

					<!-- begin panel -->
					<div class="panel panel-inverse" id="profilePanel">
						<div class="panel-heading">
							<h4 class="panel-title">Profile</h4>
						</div>
						<div class="panel-body">

							<div style="color: green;" id="update-success"></div>
							<form class="form-horizontal" id="profileForm" method="POST">
								<input type="hidden" id="u_id" name="userId" value="<%=userId%>" />

								<input type="hidden" id="supervisor_id" name="supervisorId"
									value="${userProfile.supervisorId}" /> <input type="hidden"
									name="userProfileId" value="${userProfile.userProfileId}" />

								<div class="form-group">
									<div class="col-sm-6">
										<label>Name</label> <input type="text" id="emp_name"
											name="employeeName" class="form-control"
											value="${userProfile.employeeName}" />
									</div>
									<div class="col-sm-6">
										<label>Phone</label><input type="text" id="emp_phone" name="employeePhone"
											class="form-control" value="${userProfile.employeePhone}" />
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6">
										<label>Age</label> <input class="form-control"
											id="emp_age" name="employeeAge" 
											type="text" value="${userProfile.employeeAge}" />
									</div>
									<div class="col-sm-6">
										<label>Salary</label><input type="text"
											class="form-control" id="emp_salary" name="employeeSalary"
											value="${userProfile.employeeSalary}">
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6">
										<label>Current Address</label> <input type="text" id="emp_add" name="currentAddress"
											class="form-control" value="${userProfile.currentAddress}" />
									</div>
									
								</div>
								

								<div class="panel-footer text-right">
									<button type="button" class="btn btn-primary btn-sm m-l-5"
										onclick="updateUser()">Save</button>
								</div>
							</form>


						</div>
					</div>
					<!-- end panel -->

				</div>
			</c:when>
			<c:when test="${mode == 'MODE_PASSWORD_CHANGE'}">


				<!-- begin panel -->
				<div class="panel panel-inverse" id="profilePanel">
					<div class="panel-heading">
						<h4 class="panel-title">Password</h4>
					</div>
					<div class="tasksDiv">

						<div id="errorDiv">
							<p id="error" style="color: red; font-size: 20px;"></p>
						</div>
						<form class="form-horizontal" method="POST"
							action="update-password" name="userCredentials"
							onsubmit="return validateForm()">

							<input type="hidden" name="userName" value="<%=userName%>" /> <input
								type="hidden" name="userId" value="<%=userId%>" />
							<div class="form-group">
								<label class="control-label col-md-3">New Password</label>
								<div class="col-md-5">

									<input type="text" id="new-password" name="password"
										class="form-control" placeholder="New Password"
										value="${userCredentials.password}" />
								</div>
							</div>
							<div class="form-group">
								<label class="control-label col-md-3">Confirm password</label>
								<div class="col-md-5">
									<input type="password" name="confirm" id="confirm-password"
										placeholder="Confirm Password" class="form-control" />
								</div>
							</div>
							<div class="panel-footer text-right">
								<input type="submit" class="btn btn-primary btn-sm m-l-5"
									value="Update" />
							</div>

						</form>
					</div>
				</div>
				<!-- end panel -->
			</c:when>



		</c:choose>

	</div>
	

	<script>
		function validateForm() {

			var newpassword = document.forms["userCredentials"]["new-password"].value;
			var cnfpassword = document.forms["userCredentials"]["confirm-password"].value;
			
			if (newpassword.trim() == "" || cnfpassword.trim() == "") {
			     document.getElementById("error").innerHTML ="Password field can't be empty!";
				return false;
			}
			else if(newpassword.trim() != cnfpassword.trim())
				{
				 document.getElementById("error").innerHTML ="Password did not match!";
					return false;
				}
				
		}
		
		function updateUser(){
			var val=$('#profileForm').serialize();
			//alert(val);
			$.ajax({
				type :"POST",
				url :"saveProfile",
				data : val,
				success : function(data) {
					if(data){
						 document.getElementById("update-success").innerHTML ="Profile Updated Successfully!";
						 document.getElementById("update-success").style.color = "green";
											}
					else{
						document.getElementById("update-success").innerHTML ="Kindly try again!";	
						document.getElementById("update-success").style.color = "red";
					}
					
				},
				dataType : "html",
				
				beforeSend : function(xhr) {
					xhr.setRequestHeader('Content-Type',
							'application/x-www-form-urlencoded');
				},
			});
			
		}
	</script>


	<script>
	
	$('select[name="bloodGroup"]').val('<%=blood%>
		');
	</script>



</body>
</html>
<!DOCTYPE HTML>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
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

<title>Claim</title>

<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />

<link rel="stylesheet"
	href='static/bootstrap/css/bootstrap-datepicker3.css' />
<script src='static/bootstrap/js/bootstrap-datepicker.min.js'></script>

</head>
<body>
	<div id="content" class="content">
		<c:choose>
			<c:when test="${mode == 'MODE_NEW' || mode == 'MODE_UPDATE'}">

				<h1 class="page-header1">Expense Reimbursement</h1>

				<!-- begin panel -->
				<div class="panel panel-inverse">
					<div class="panel-heading">
						<h4 class="panel-title">Claim</h4>
					</div>
					<div class="panel-body">
						<form class="form-horizontal" method="POST" action="create-claim"
							id="claim-form" onsubmit="return validateForm()">

							<div class="formStart">
								<input type="hidden" name="id" value="${claim.claimId}" /> <input
									type="hidden" name="userId" value="<%=userId%>" />

								<div class="form-group">
									<div class="col-sm-6">
										<label>From Date</label> <input class="form-control"
											id="start-date" name="start" placeholder="MM/DD/YYY"
											type="text"
											value="<fmt:formatDate pattern="yyyy-MM-dd"
																						value="${claim.start}" />" />
									</div>
									<div class="col-sm-6">
										<label>End Date</label><input class="form-control"
											id="end-date" name="end" placeholder="MM/DD/YYY" type="text"
											value="<fmt:formatDate pattern="yyyy-MM-dd"
																						value="${claim.end}" />" />
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6">
										<label>Manager</label> <input type="text" name="manager"
											id="manager" class="form-control" value="${claim.manager}" />
									</div>
									<div class="col-sm-6">
										<label>Business Purpose</label><input type="text"
											name="purpose" id="purpose" class="form-control"
											value="${claim.purpose}" />
									</div>
								</div>

								<div class="form-group">
									<div class="col-sm-6">
										<label>Advance</label><input type="number" name="advance"
											id="advance" class="form-control" value="${claim.advance}" />
									</div>
									<div class="col-sm-6">
										<label>Department</label><select
											class="selectpicker form-control" name="department">
											<option value="Engineering">Engineering</option>
											<option value="HR">HR</option>
											<option value="Finance">Finance</option>
											<option value="Admin">Admin</option>
										</select>
									</div>
								</div>

							</div>

							<div class="panel panel-inverse innerPanel" id="innerPanel">
								<div class="panel-heading">
									<div class="panel-heading-btn">
										<a href="javascript:;" id="add_row"
											class="btn btn-white btn-sm panelButton">Add Row</a> <a
											href="javascript:;" id='delete_row'
											class="btn btn-danger btn-sm m-l-5 panelButton">Delete
											Row</a>
									</div>
									<h4 class="panel-title">Attachment</h4>
								</div>

								<div class="panel-body">
									<table class="table table-bordered" id="item_table">

										<col width="80">
										<col width="120">
										<col width="200">
										<col width="150">
										<col width="150">
										<col width="100">
										<thead>
											<tr>
												<th class="text-center">#</th>
												<th class="text-center">Date</th>
												<th class="text-center">Description</th>
												<th class="text-center">Category</th>
												<th class="text-center">Cost</th>
												<th class="text-center">attachment</th>
											</tr>
										</thead>
										<tbody>
											<tr id='addr0'>
												<td>1</td>
												<td><input type="text" name='claimItems[0].expenseDate'
													id='expenseDate' placeholder='Date'
													class="form-control picker" /></td>
												<td><input type="text" name='claimItems[0].description'
													placeholder='Description' class="form-control" /></td>
												<td><select class="selectpicker form-control"
													name='claimItems[0].category'>
														<option value="travel">Travel</option>
														<option value="food">Food</option>
														<option value="admin">Admin</option>
														<option value="product">Product</option>
														<option value="other">Other</option>
												</select></td>
												<td><input type="number" name='claimItems[0].cost'
													placeholder='Cost' class="form-control" /></td>
												<td><input type='file' name='files[]'
													id='js-upload-files' multiple></td>
											</tr>
											<tr id='addr1'></tr>
										</tbody>
									</table>
								</div>
							</div>

							<div class="panel-footer text-right">
								<div id="errorDiv" align="left">
									<p id="error" style="color: red; font-size: 20px;"></p>
								</div>
								<a href="javascript:;" class="btn btn-white btn-sm">Cancel</a> <input
									type="submit" class="btn btn-primary btn-sm m-l-5"
									value="Submit" />
							</div>
						</form>
					</div>
				</div>
				<!-- end panel -->
			</c:when>


			<c:when test="${mode == 'MODE_HISTORY'}">
				<div class="" id="tasksDiv">

					<h1 class="page-header1">Claim History</h1>

					<!-- begin panel -->
					<div class="panel panel-inverse claimPanel ">
						<div class="panel-heading">
							<h4 class="panel-title">History</h4>
						</div>
						<div class="panel-body">
							<table class="table table-bordered">
								<thead>
									<tr>
										<th class="text-center">Claim Id</th>
										<th class="text-center">Period</th>
										<th class="text-center">Download</th>

									</tr>
								</thead>
								<tbody>
									<c:forEach var="claim" items="${claimList}">
										<tr>
											<td class="text-center">${claim.claimId}</td>
											<td class="text-center"><fmt:formatDate
													pattern="yyyy-MM-dd" value="${claim.start}" /> to <fmt:formatDate
													pattern="yyyy-MM-dd" value="${claim.end}" /></td>
											<td class="text-center"><a
												href="/claim-download?claimid=${claim.claimId}"><span
													class="glyphicon glyphicon-download"></span></a></td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>
					<!-- end panel -->
				</div>
			</c:when>
		</c:choose>
	</div>





	<script>
		$(document).ready(
				function() {
					var date_input = $('input[name="start"]');
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'mm/dd/yyyy',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>

	<script>
		$(document).ready(
				function() {
					var date_input = $('input[name="end"]'); //our date input has the name "date"
					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'yyyy-MM-dd',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>


	<script>
		$(document)
				.ready(
						function() {
							var i = 1;
							$("#add_row")
									.click(
											function() {
												$('#addr' + i)
														.html(
																"<td>"
																		+ (i + 1)
																		+ "</td><td><input name='claimItems["
																		+ i
																		+ "].expenseDate' type='text' placeholder='Date' class='form-control input-md picker' onblur='showDatePicker(this)'  /> </td><td><input  name='claimItems["+i+"].description' type='text' placeholder='Description'  class='form-control input-md'></td><td><select class='selectpicker form-control' name='claimItems["+i+"].category'><option value='travel'>Travel</option><option value='food'>Food</option><option value='admin'>Admin</option><option value='product'>Product</option><option value='other'>Other</option></select></td><td><input  name='claimItems["+i+"].cost' type='number' placeholder='Cost'  class='form-control input-md'></td><td><input type='file' name='files[]' id='js-upload-files' multiple></td>");

												$('#item_table').append(
														'<tr id="addr'
																+ (i + 1)
																+ '"></tr>');
												i++;
											});
							$("#delete_row").click(function() {
								if (i > 1) {
									$("#addr" + (i - 1)).html('');
									i--;
								}
							});

						});
	</script>
	<script>
		$(document).ready(
				function() {
					var date_input = $('.picker');

					var container = $('.bootstrap-iso form').length > 0 ? $(
							'.bootstrap-iso form').parent() : "body";
					date_input.datepicker({
						format : 'mm/dd/yyyy',
						container : container,
						todayHighlight : true,
						autoclose : true,
					})
				})
	</script>


	<script>
		function showDatePicker() {
			var date_input = $('.picker');

			var container = $('.bootstrap-iso form').length > 0 ? $(
					'.bootstrap-iso form').parent() : "body";
			date_input.datepicker({
				format : 'mm/dd/yyyy',
				container : container,
				todayHighlight : true,
				autoclose : true,
			})
		}
	</script>


	<script>
		function validateForm() {

			var startdate = document.forms["claim-form"]["start-date"].value;
			var enddate = document.forms["claim-form"]["end-date"].value;
			var manager = document.forms["claim-form"]["manager"].value;
			var advance = document.forms["claim-form"]["advance"].value;
			var purpose = document.forms["claim-form"]["purpose"].value;

			if (startdate.trim() == "" || enddate.trim() == ""
					|| manager.trim() == "" || advance.trim() == ""
					|| purpose.trim() == "") {
				document.getElementById("error").innerHTML = "All fields are mandatory! Kindly fill.";
				return false;
			}
		}
	</script>
</body>
</html>
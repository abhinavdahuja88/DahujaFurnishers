<!DOCTYPE HTML>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page isELIgnored="false"%>

<html>

<head profile="http://www.w3.org/2005/10/profile">
<link rel="icon" type="image/png" href="/static/image/favicon.png" />
<%@ page session="false" %>

<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="Sat, 01 Dec 2001 00:00:00 GMT">


    <script src="static/js/jquery.min.js"></script>
	<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
	<script src="static/js/bootstrap.min.js"></script>

	<link rel="stylesheet" href="static/css/bootstrap.min.css">
	<link href="static/css/style.css" rel="stylesheet">
	<link rel="stylesheet" href='static/bootstrap/css/bootstrap-iso.css' />
<!-- ================== BEGIN BASE CSS STYLE ================== -->
<link
	href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700"
	rel="stylesheet">
<link
	href="static/color_theme/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css"
	rel="stylesheet" />
<link
	href="static/color_theme/assets/plugins/bootstrap/css/bootstrap.min.css"
	rel="stylesheet" />
<link
	href="static/color_theme/assets/plugins/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" />
<link href="static/color_theme/assets/css/animate.min.css"
	rel="stylesheet" />
<link href="static/color_theme/assets/css/style.min.css"
	rel="stylesheet" />
<link href="static/color_theme/assets/css/style-responsive.min.css"
	rel="stylesheet" />
<link href="static/color_theme/assets/css/theme/default.css"
	rel="stylesheet" id="theme" />
<link href="static/css/modified.css" rel="stylesheet" id="theme" />

<!-- ================== END BASE CSS STYLE ================== -->


</head>
<body>

<% HttpSession session = request.getSession();
	String userName=(String)session.getAttribute("SessionUsername");
	String userId=(String)session.getAttribute("SessionUserid");
	/* if (userName == null)
	response.sendRedirect("/"); */
	
%>


	<!-- begin #header -->
	<div id="header" class="header navbar navbar-default navbar-fixed-top">
		<!-- begin container-fluid -->
		<div class="container-fluid">
			<!-- begin mobile sidebar expand / collapse button -->
			<div class="navbar-header">
				<a href="/home?userid=<%=userId%>" class="navbar-brand"><img
					src="static/image/bb-logo.png"></img></a> <a
					href="all-tasks?userid=<%=userId%>" class="navbar-brand1">Work
					Log</a>
				<ul class="nav navbar-nav">
					<li class="dropdown navbar-user"><a href="javascript:;"
						class="navbar-brand1 dropdown-toggle" data-toggle="dropdown">
							<span class="hidden-xs">Claim</span> <b class="caret"></b>
					</a>
						<ul class="dropdown-menu animated fadeInLeft">
							<li><a href="/claim-form">New Claim</a></li>
							<li class="divider"></li>
							<li><a href="/claim-list?userid=<%=userId%>">Claim
									History</a></li>
						</ul></li>
				</ul>
				<a href="/direct-report?userid=<%=userId%>" class="navbar-brand1">My
					Team</a>

			</div>
			<!-- end mobile sidebar expand / collapse button -->

			<!-- begin header navigation right -->
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown navbar-user"><a href="javascript:;"
					class="dropdown-toggle" data-toggle="dropdown"> <img
						src="static/color_theme/assets/img/user-13.jpg" alt="" /> <span
						class="hidden-xs"><%=userName%></span> <b class="caret"></b>
				</a>
					<ul class="dropdown-menu animated fadeInLeft">
						<li><a href="/myProfile?userid=<%=userId%>">My Profile</a></li>
						<li class="divider"></li>
						<li><a href="/change-password">Change Password</a></li>
						<li class="divider"></li>
						<li><a href="/logout">Logout</a></li>
					</ul></li>
			</ul>
			<!-- end header navigation right -->
		</div>
		<!-- end container-fluid -->
	</div>
	<!-- end #header -->


	<script>
		$(function() {
			$(".dropdown").hover(function() {
				$('.dropdown-menu', this).stop(true, true).fadeIn("fast");
				$(this).toggleClass('open');
				$('b', this).toggleClass("caret caret-up");
			}, function() {
				$('.dropdown-menu', this).stop(true, true).fadeOut("fast");
				$(this).toggleClass('open');
				$('b', this).toggleClass("caret caret-up");
			});
		});
	</script>
</body>
</html>
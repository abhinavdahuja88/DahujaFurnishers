<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE HTML>
   <%@ page isELIgnored="false"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>


<%-- <c:set var="contextPath" value="${pageContext.request.contextPath}" /> --%>

<html>
<head profile="http://www.w3.org/2005/10/profile">
<link rel="icon" type="image/png" href="/static/image/favicon.png" />
	<meta charset="utf-8" />
	<title>Task Manager | Home</title>
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />
	<meta content="" name="description" />
	<meta content="" name="author" />

	<!-- ================== BEGIN BASE CSS STYLE ================== -->
	<link href="http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700" rel="stylesheet">
	<link href="static/color_theme/assets/plugins/jquery-ui/themes/base/minified/jquery-ui.min.css" rel="stylesheet" />
	<link href="static/color_theme/assets/plugins/bootstrap/css/bootstrap.min.css" rel="stylesheet" />
	<link href="static/color_theme/assets/plugins/font-awesome/css/font-awesome.min.css" rel="stylesheet" />
	<link href="static/color_theme/assets/css/animate.min.css" rel="stylesheet" />
	<link href="static/color_theme/assets/css/style.min.css" rel="stylesheet" />
	<link href="static/color_theme/assets/css/style-responsive.min.css" rel="stylesheet" />
	<link href="static/color_theme/assets/css/theme/default.css" rel="stylesheet" id="theme" />
	<link href="static/css/modified.css" rel="stylesheet" id="theme" />
	<!-- ================== END BASE CSS STYLE ================== -->



<script>
     if (sessionStorage.getItem("calenderPageVisited")) {
          sessionStorage.removeItem("calenderPageVisited");
          window.location.reload(true); // force refresh page1
     }
</script>



</head>
<body class="pace-top">
	<!-- begin #page-loader -->
	<div id="page-loader" class="fade in"><span class="spinner"></span></div>
	<!-- end #page-loader -->

	<!-- begin #page-container -->
	<div id="page-container" class="fade">
	    <!-- begin login -->
	    <img src="static/image/bb-logo.png"></img>
        <div class="login bg-black animated fadeInDown">
            <!-- begin brand -->
            <div class="login-header">
                <div class="brand">
                    <span class="logo"></span> BuzzyBrains Software
                    <small>Experience the Excellence !</small>
                </div>
                <div class="icon">
                    <i class="fa fa-sign-in"></i>
                </div>
            </div>
            <!-- end brand -->
            <div class="login-content">
                <form method="POST" action="validate" class="margin-bottom-0">
                    <div class="form-group m-b-20">
                        <input id="txtUsername" type="text" class="form-control input-lg"
                         name="userName" placeholder="Username" required />
                    </div>
                    <div class="form-group m-b-20">
                        <input id="txtpasswd" type="password" class="form-control input-lg"
                        name="password" placeholder="Password" required />
                    </div>
                    <div class="checkbox m-b-20">
                        <label>
                            <input type="checkbox" /> Remember Me
                        </label>
                    </div>
                    <div class="login-buttons">
                        <button type="submit" class="btn btn-success btn-block btn-lg">Sign me in</button>
                    </div>
                </form>
            </div>
        </div>
        <!-- end login -->


	</div>
	<!-- end page container -->

	<!-- ================== BEGIN BASE JS ================== -->
	<script src="static/color_theme/assets/plugins/jquery/jquery-1.9.1.min.js"></script>
	<script src="static/color_theme/assets/plugins/jquery/jquery-migrate-1.1.0.min.js"></script>
	<script src="static/color_theme/assets/plugins/jquery-ui/ui/minified/jquery-ui.min.js"></script>
	<script src="static/color_theme/assets/plugins/bootstrap/js/bootstrap.min.js"></script>
	<!--[if lt IE 9]>
		<script src="static/color_theme/assets/crossbrowserjs/html5shiv.js"></script>
		<script src="static/color_theme/assets/crossbrowserjs/respond.min.js"></script>
		<script src="static/color_theme/assets/crossbrowserjs/excanvas.min.js"></script>
	<![endif]-->

	<!-- ================== END BASE JS ================== -->

	<!-- ================== BEGIN PAGE LEVEL JS ================== -->
	<script src="static/color_theme/assets/js/apps.min.js"></script>
	<!-- ================== END PAGE LEVEL JS ================== -->

	<script>
		$(document).ready(function() {
			App.init();
		});
	</script>
</body>
</html>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>

<html>
<head>
	<link rel="stylesheet" href="<spring:url value='/static/css/bootstrap.min.css' />"/>
	<link rel="stylesheet" href="<spring:url value='/static/css/style.css' />"/>
</head>
<body>
<div id="homeCenterContent">
	<div class="row">
		<div class="col-3">
			<img id="underConstructionIMG" src="<spring:url value='/static/img/under-construction.jpg' />"
				 alt="Under-Construction">
		</div>
	</div>
</div>
<script src="<spring:url value='/static/script/js/bootstrap.min.js' />"></script>
</body>
</html>

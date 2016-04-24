<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>

<link type="text/css" href="/essai/jsFramework/jquery/css/smoothness/jquery-ui-1.8.custom.css" rel="stylesheet" />
<!--
<script type="text/javascript" src="/jquery/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/jquery/js/jquery-ui-1.8.custom.min.js"></script>
-->
<!-- http://code.google.com/intl/fr-FR/apis/ajaxlibs/ -->
<script type="text/javascript" src="http://www.google.com/jsapi?key=INSERT-YOUR-KEY"></script>
<script type="text/javascript">
  google.load("jquery", "1.4.2");
  google.load("jqueryui", "1.8.0");
  google.load("chrome-frame", "1.0.2");
</script>
<!--
<script type="text/javascript">
  google.load("prototype", "1.6.1.0");
  google.load("scriptaculous", "1.8.3");
  google.load("mootools", "1.2.4");
  google.load("dojo", "1.4.1");
  google.load("swfobject", "2.2");
  google.load("yui", "2.8.0r4");
  google.load("ext-core", "3.1.0");
</script>
-->

</head>
<body>
	<!-- http://jqueryui.com/demos/resizable/#textarea
	<style type="text/css">
		.ui-resizable-se {
			bottom: 17px;
		}
	</style>
	<script type="text/javascript">
	$(function() {
		$("#resizable").resizable({
			handles: "se"
		});
	});
	</script>
	<div class="demo">
		<textarea id="resizable" rows="5" cols="20"></textarea>
	</div>

<br/>
	<!-- End demo -->

	<!-- http://jqueryui.com/demos/resizable/#constrain-area -->

	<style type="text/css">
	#container-1 { width: 300px; height: 300px; }
	#container-1 h3 { text-align: center; margin: 0;}
	#container-1 { padding: 0.5em; margin: 0px; padding: 0px;}
	.ui-container-1-s { bottom: 17px; }

	#container-1-1 { width: 29%; height: 300px; }
	#container-1-1 { background-position: left; }
	#container-1-1 { padding: 0.5em; margin: 0px; padding: 0px; /*border: none*/}
	#container-1-1 { float:left;}
	.ui-container-1-1-se { bottom: 17px; }

	#container-1-2 { width: 69%; height: 300px; }
	#container-1-2 { background-position: right; }
	#container-1-2 { padding: 0.5em; margin: 0px; padding: 0px; /*border: none*/}
	#container-1-2 { float:right;}
	.ui-container-1-2-se { bottom: 17px; }
	</style>
	<script type="text/javascript">
		$(function() {
			$("#container-1").resizable({
				handles: "s",
				alsoResize: '#container--11,#container-1-2'
	 		});
		});
		$(function() {
			$("#container-1-1").resizable({
				handles: "se",
				containment: '#container-1',
				alsoResize: '#container-1,#container-1-2',
				aspectRatio: .29
			});
		});
		$(function() {
			$("#container-1-2").resizable({
				handles: "se",
				containment: '#container-1',
				alsoResize: '#container-1,#container-1-1',
				aspectRatio: .69
			});
		});
	</script>

	<div id="container-1" class="ui-widget-content">
		<!--h3 class="ui-widget-header">container-1</h3-->
		<div id="container-1-1" class="ui-state-active">
			<!--h3 class="ui-widget-header">container-1-1</h3-->
		</div>
		<div id="container-1-2" class="ui-state-active">
			<!--h3 class="ui-widget-header">container-0-21</h3-->
		</div>
	</div>

	<!-- End demo -->
</body>
</html>
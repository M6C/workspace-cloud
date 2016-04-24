<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Language" content="en" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>3-pane splitter</title> 
<!-- script type="text/javascript" src="/jquery/dist/jquery.js"></script --> 
<script type="text/javascript" src="/essai/jsFramework/jquery/js/jquery-1.4.2.min.js"></script>
<script type="text/javascript" src="/essai/jsFramework/jquery/js/jquery-ui-1.8.custom.min.js"></script>
<script type="text/javascript" src="/essai/jsFramework/jquery/splitter/splitter.js"></script> 
 
<!-- General page styles (not critical to the demos) --> 
<link rel="stylesheet" type="text/css" href="/essai/jsFramework/jquery/splitter/main.css" /> 
 
<style type="text/css" media="all"> 
html, body
{
	margin: 0;			/* Remove body margin/padding */
	padding: 0;
	overflow: hidden;	/* Remove scroll bars on browser window */
}

#MySplitter1 {
	border: 3px solid #669;
	min-width: 400px;	/* Splitter can't be too thin ... */
	min-height: 200px;	/* ... or too flat */
	height: 100%;
}
#MySplitter2 {
	border: 3px solid #669;
	min-width: 400px;	/* Splitter can't be too thin ... */
	min-height: 200px;	/* ... or too flat */
	height: 100%;
}
#LeftPane {
	background: #ddf;
	width: 150px;
	min-width: 100px;
	max-width: 300px;
	overflow: auto;		/* Scroll bars appear as needed */
}
#LeftTopPane {				/* Top nested in right pane */
	background: #ccf;
	height: 150px;		/* Initial height */
	min-height: 75px;	/* Minimum height */
	overflow: auto;	
}
#LeftBottomPane {			/* Bottom nested in right pane */
	background: #eef;
	min-height: 50px;
	overflow: auto;
}
#RightPane {
	background: #ddf;
	width: 150px;
	min-width: 100px;
	max-width: 300px;
	overflow: auto;		/* Scroll bars appear as needed */
}
#RightTopPane {				/* Top nested in right pane */
	background: #ccf;
	height: 150px;		/* Initial height */
	min-height: 75px;	/* Minimum height */
	overflow: auto;	
}
#RightBottomPane {			/* Bottom nested in right pane */
	background: #eef;
	min-height: 50px;
	overflow: auto;
}

	
/* Splitbar styles; these are the default class names */
 
.vsplitbar {
	width: 2px;
	background: #669 url(/jquery/splitter/img/vgrabber.gif) no-repeat center;
}
.vsplitbar:hover, .vsplitbar.active {
	background: #c66 url(/jquery/splitter/img/vgrabber.gif) no-repeat center;
	opacity: 0.7;
	filter: alpha(opacity=70); /* IE */
	background: #c99;
}
.hsplitbar {
	height: 2px;
	background: #669 url(/jquery/splitter/img/hgrabber.gif) no-repeat center;
}
.hsplitbar.active, .hsplitbar:hover {
	background: #c66 url(/jquery/splitter/img/hgrabber.gif) no-repeat center;
}
</style> 
<script type="text/javascript"> 
$().ready(function() {
	// Vertical splitter. Set min/max/starting sizes for the left pane.
	$("#MySplitter1").splitter({
		splitHorizontal: false,
		splitVertical: true,
		outline: true,
		sizeTop: true,
		//anchorToWindow: true,
		accessKey: "I"
	});
	// Horizontal splitter, nested in the left pane of the vertical splitter.
	$("#LeftPane").splitter({
		splitVertical: false,
		splitHorizontal: true,
		sizeTop: true,
		accessKey: "L"
	});
	//$("#LeftPane").splitter({type: 'h'});
	// Vertical splitter. Set min/max/starting sizes for the left pane.
	$("#MySplitter2").splitter({
		splitHorizontal: false,
		splitVertical: true,
		outline: true,
		sizeTop: true,
		//anchorToWindow: true,
		accessKey: "I"
	});
	// Horizontal splitter, nested in the right pane of the vertical splitter.
	$("#RightPane").splitter({
		splitVertical: false,
		splitHorizontal: true,
		sizeTop: true,
		accessKey: "R"
	});
	//$("#RightPane").splitter({type: 'h'});
});
</script> 
</head> 
<body> 

<div id="MySplitter2"> 

  <div id="RightPane"> 

	<div id="RightTopPane"> 
		RightTopPane
	</div> 
	
	<div id="RightBottomPane"> 
		RightBottomPane
	</div> <!-- #BottomPane --> 
	
  </div> <!-- #RightPane --> 
  
</div> <!-- #MySplitter --> 
 
<div id="MySplitter1"> 
 
  <div id="LeftPane">

	<div id="LeftTopPane"> 
		LeftTopPane
	</div> <!-- #LeftTopPane --> 
	
	<div id="LeftBottomPane"> 
		LeftBottomPane
	</div> <!-- #LeftBottomPane -->

  </div> <!-- #LeftPane --> 

</div>
 
</body> 
</html>
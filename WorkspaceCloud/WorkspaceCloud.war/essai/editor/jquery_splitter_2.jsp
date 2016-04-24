<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd"> 
<html> 
<head> 
<meta http-equiv="Content-Language" content="en" /> 
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" /> 
<title>4-pane splitter</title> 
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
#header { padding: 1em; }
 
#MySplitter {
	border: 3px solid #669;
	min-width: 500px;	/* Splitter can't be too thin ... */
	min-height: 300px;	/* ... or too flat */
	height: 100%;
}
#MySplitter .Pane {
	overflow: auto;
	background: #def;
}
 
/* Splitbar styles; these are the default class names */
 
.vsplitbar {
	width: 6px;
	background: #669 url(img/vgrabber.gif) no-repeat center;
}
.vsplitbar:hover, .vsplitbar.active {
	background: #c66 url(img/vgrabber.gif) no-repeat center;
	opacity: 0.7;
	filter: alpha(opacity=70); /* IE */
}
.hsplitbar {
	height: 6px;
	background: #669 url(img/hgrabber.gif) no-repeat center;
}
.hsplitbar.active, .hsplitbar:hover {
	background: #c66 url(img/hgrabber.gif) no-repeat center;
	opacity: 0.7;
	filter: alpha(opacity=70); /* IE */
}
</style> 
<script type="text/javascript"> 
$().ready(function() {
	// Vertical splitter. Set min/max/starting sizes for the left pane.
	$("#MySplitter").splitter({
		splitVertical: true,
		outline: true,
		sizeLeft: 150, minLeft: 100, maxLeft: 200,
		//anchorToWindow: true,
		accessKey: "L"
	});
	// First horizontal splitters, nested in the right pane of the vertical splitter.
	$("#LeftSplitter").splitter({
		splitHorizontal: true,
		outline: true,
		sizeBottom: 20, minTop: 10, sizeTop: 10, minTop: 5,
		accessKey: "L"
	});
	// First horizontal splitters, nested in the right pane of the vertical splitter.
	$("#Left2Splitter").splitter({
		splitHorizontal: true
	});
	// First horizontal splitters, nested in the right pane of the vertical splitter.
	$("#TopSplitter").splitter({
		splitHorizontal: true,
		outline: true,
		sizeTop: 100, minTop: 50, maxTop: 200,
		accessKey: "V"
	});
	// Second horizontal splitter, nested in bottom pane of first horizontal splitter
	$("#BottomSplitter").splitter({
		splitHorizontal: true,
		outline: true,
		sizeBottom: 120, minTop: 50,
		accessKey: "J"
	});});
</script> 
</head> 
<body> 
 
<div id="header"> 
<h1>4-Pane Splitter Layout</h1> 
<p>Here is a 4-pane layout with the splitter occupying all the area below this header.
  The page scroll bars have been removed since all the content is inside the splitter, and the
  splitter is anchored to the bottom of the window using the .</p> 
<p> 
<a href="default.html">See the splitter documentation</a> 
</p> 
</div> 
 
<div id="MySplitter"> 

  <div id="LeftSplitter"> 
	
	<div class="Middle Pane">
		LeftSplitter Top Pane
	</div> 

	<div class="Bottom Pane"> 
		LeftSplitter Pane
	</div> 
  </div> 

  <div id="TopSplitter"> 
 
	<div class="Top Pane"> 
		TopSplitter Top Pane
	</div> 
	
	<div id="BottomSplitter"> 
		<div class="Middle Pane"> 
			BottomSplitter Middle Pane
		</div> 
		<div class="Bottom Pane"> 
			BottomSplitter Bottom Pane
		</div> 
	</div> 
	
  </div> 
  
</div> <!-- #MySplitter --> 
 
</body> 
</html>
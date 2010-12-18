<SCRIPT>
<!--
var JDWMinNS4   = (navigator.appName.indexOf("Netscape") >= 0 && parseFloat(navigator.appVersion) >= 4) ? 1 : 0;
var JDWMinNS6   = (navigator.appName.indexOf("Netscape") >= 0 && parseFloat(navigator.appVersion) == 6) ? 1 : 0;
var JDWMinIE4   = (document.all) ? 1 : 0;
var JDWMinIE5   = (JDWMinIE4 && navigator.appVersion.indexOf("5.")  >= 0) ? 1 : 0;
var JDWMinIE55  = (JDWMinIE5 && navigator.appVersion.indexOf("5.5") >= 0) ? 1 : 0;

function findPosX(obj)
{
	var curleft = 0;
        //If the browser supports offsetParent
	if (obj.offsetParent)
	{
                //go into a loop that continues as long as the object has an offsetParent
		while (obj.offsetParent)
		{
                        //Add the offsetLeft of the element relative to the offsetParent
                        //to curleft and set the object to this offsetParent
			curleft += obj.offsetLeft
			obj = obj.offsetParent;
			//The while loop repeats this process as long as the element has an offsetParent.
			//When it has no more offsetParent, the HTML element is reached and we have the
			//position relative to it (in other words: relative to the entire document)
		}
	}
        //As to browser supporting x (Netscape 4):
	else if (obj.x)
                //take the x property of the link (it doesn't work on any other element).
		curleft += obj.x;
        //Finally return the calculated coordinate to whichever script asked for it.
	return curleft;
}

function findPosY(obj)
{
	var curtop = 0;
        //If the browser supports offsetParent
	if (obj.offsetParent)
	{
                //go into a loop that continues as long as the object has an offsetParent
		while (obj.offsetParent)
		{
                        //Add the offsetTop of the element relative to the offsetParent
                        //to curtop and set the object to this offsetParent
			curtop += obj.offsetTop
			obj = obj.offsetParent;
			//The while loop repeats this process as long as the element has an offsetParent.
			//When it has no more offsetParent, the HTML element is reached and we have the
			//position relative to it (in other words: relative to the entire document)
		}
	}
        //As to browser supporting x (Netscape 4):
	else if (obj.y)
                //take the x property of the link (it doesn't work on any other element).
		curtop += obj.y;
        //Finally return the calculated coordinate to whichever script asked for it.
	return curtop;
}

function getLeft(layer) {
	if (JDWMinNS4)
		return layer.left;
	if (JDWMinIE4)
		return layer.style.pixelLeft;
	return -1;
}
function getTop(layer) {
	if (JDWMinNS4)
		return layer.top;
        if (JDWMinIE4)
		return layer.style.pixelTop;
	return -1;
}
function getRight(layer) {
	if (JDWMinNS4)
		return layer.left + getWidth(layer);
	if (JDWMinIE4)
		return layer.style.pixelLeft + getWidth(layer);
	return -1;
}
function getBottom(layer) {
	if (JDWMinNS4)
		return layer.top + getHeight(layer);
	if (JDWMinIE4)
		return layer.style.pixelTop + getHeight(layer);
	return -1;
}
function getPageLeft(layer) {
	var x;
	if (JDWMinNS4)
		return layer.pageX;
	if (JDWMinIE4) {
		x = 0;
		while (layer.offsetParent != null) {
			x += layer.offsetLeft;
			layer = layer.offsetParent;
		}
		x += layer.offsetLeft;
		return x;
	}
	return -1;
}
function getPageTop(layer) {
	var y;
	if (JDWMinNS4)
		return layer.pageY;
        if (JDWMinIE4) {
		y = 0;
		while (layer.offsetParent != null) {
			y += layer.offsetTop;
			layer = layer.offsetParent;
		}
		y += layer.offsetTop;
		return y;
	}
	return -1;
}
function getWidth(layer) {
	if (JDWMinNS4) {
		if (layer.document.width)
			return layer.document.width;
		else
			return layer.clip.right - layer.clip.left;
	}
	if (JDWMinIE4) {
		if (layer.style.pixelWidth)
			return layer.style.pixelWidth;
		else
			return layer.clientWidth;
	}
	return -1;
}
function getHeight(layer) {
	if (JDWMinNS4) {
		if (layer.document.height)
			return layer.document.height;
		else
			return layer.clip.bottom - layer.clip.top;
	}
	if (JDWMinIE4) {
		if (layer.style.pixelHeight)
			return layer.style.pixelHeight;
                else
			return layer.clientHeight;
	}
	return -1;
}
function getzIndex(layer) {
	if (JDWMinNS4)
		return layer.zIndex;
	if (JDWMinIE4)
		return layer.style.zIndex;
	return -1;
}
function setzIndex(layer, z) {
	if (JDWMinNS4)
		layer.zIndex = z;
	if (JDWMinIE4)
		layer.style.zIndex = z;
}

//Fonction permettant de connaître la position d'un objet
//par rapport au bord gauche de la page.
//Cet objet peut être à l'intérieur d'un autre objet.
function getLeft(MyObject)
{
  if (MyObject.offsetParent)
    return (MyObject.offsetLeft + getLeft(MyObject.offsetParent));
  else
    return (MyObject.offsetLeft);
}

//Fonction permettant de connaître la position d'un objet
//par rapport au bord haut de la page.
//Cet objet peut être à l'intérieur d'un autre objet.
function getTop(MyObject)
{
  if (MyObject.offsetParent)
    return (MyObject.offsetTop + getTop(MyObject.offsetParent));
  else
    return (MyObject.offsetTop);
}

//-->
</SCRIPT>
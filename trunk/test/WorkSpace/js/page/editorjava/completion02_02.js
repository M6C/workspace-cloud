var url = "/WorkSpace/action.servlet?event=EditorJavaCompletion&"; // The server-side script
/*
function SymError() {
  return true;
}

window.onerror = SymError;
*/
var ac;

function getHTTPObject() {
//alert("getHTTPObject");
  var xhr_object = null;
  if(window.XMLHttpRequest) // Firefox
    xhr_object = new XMLHttpRequest();
  else if(window.ActiveXObject) { // Internet Explorer
      try {
        xhr_object = new ActiveXObject("Msxml2.XMLHTTP");
      } catch (E) {
    	xhr_object = new ActiveXObject("Microsoft.XMLHTTP");
      }
  } else { // XMLHttpRequest non supporté par le navigateur
    //alert("You do not support XMLHTTPRequest objet");
    return;
  }
  return xhr_object;
}

function createAutoComplete(inputName, divName, anchorName, anchorId, maxSize) {
//alert("createAutoComplete");
	ac = new AutoComplete(
        	getHTTPObject(),
		inputName,
		divName,
		anchorName,
                anchorId,
		maxSize
	);
}

function AutoComplete(oHttp, inputName, divName, anchorName, anchorId, nMaxSize) {
//alert("AutoComplete");
	// initialize member variables
	this.oHttp = oHttp;
	this.oTextName = inputName;
	this.oDivName = divName;
	this.oAnchorName = anchorName;
	this.oAnchorId = anchorId;
	this.oText = document.getElementById(inputName);
	this.oDiv = document.getElementById(divName);
	this.oAnchor = document.getElementById(anchorName);
	this.nMaxSize = nMaxSize;

	// preprocess the texts for fast access
	this.db = new Array();

	// attach handlers to the text-box
	this.oText.AutoComplete = this;
	this.oText.onkeyup = AutoComplete.prototype.onTextChange;
	this.oText.onblur = AutoComplete.prototype.onTextBlur;
}

AutoComplete.prototype.onTextBlur = function() {
//alert("AutoCompleteDB.prototype.onTextBlur");
	this.AutoComplete.onblur();
}

AutoComplete.prototype.onblur = function() {
//alert("AutoCompleteDB.prototype.onblur");
	this.oDiv.style.visibility = "hidden";
}

AutoComplete.prototype.onTextChange = function() {
//alert("AutoCompleteDB.prototype.onTextChange");
	this.AutoComplete.onchange();
}

AutoComplete.prototype.onDivMouseDown = function() {
//alert("AutoCompleteDB.prototype.onDivMouseDown");
	this.AutoComplete.oText.value = this.innerHTML;
}

AutoComplete.prototype.onDivMouseOver = function() {
//alert("AutoCompleteDB.prototype.onDivMouseOver");
	this.className = "AutoCompleteHighlight";
}

AutoComplete.prototype.onDivMouseOut = function() {
//alert("AutoCompleteDB.prototype.onDivMouseOut");
	this.className = "AutoCompleteBackground";
}

AutoComplete.prototype.handleHttpResponse = function() {
//alert("handleHttpResponse");
  if (ac.oHttp.readyState == 4) {
    var tmp = ac.oHttp.responseText.split(":");
    if(typeof(tmp[1]) != "undefined") {
      var size = tmp.length;
      for(var i=0 ; i<size ; i++) {
	ac.db.push(tmp[i]);
      }
    }
  }
}

AutoComplete.prototype.onchange = function() {
//alert("AutoCompleteDB.prototype.onchange");
	var txt = this.oText.value;
	var method   = "GET";//"POST";

        this.db = new Array();

  	this.oHttp.open(method, url + "className=" + escape(txt), true);
	this.oHttp.onreadystatechange = AutoComplete.prototype.handleHttpResponse;
	this.oHttp.send(null);
	if(method == "POST")
	  this.oHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

        // clear the popup-div.
        while ( this.oDiv.hasChildNodes() )
                this.oDiv.removeChild(this.oDiv.firstChild);

        // add each string to the popup-div
        var n = this.db.length;
        if (n>0) {
            for ( var i = 0; (i < n) && (i<this.nMaxSize); i++ ) {
                var lDiv = document.createElement("div");
                this.oDiv.appendChild(lDiv);
                lDiv.Id = "aDiv";
                lDiv.innerHTML = this.db[i];
                lDiv.onmousedown = AutoComplete.prototype.onDivMouseDown;
                lDiv.onmouseover = AutoComplete.prototype.onDivMouseOver;
                lDiv.onmouseout = AutoComplete.prototype.onDivMouseOut;
                lDiv.AutoComplete = this;
//                alert("this.oDiv.Id:"+this.oAnchor+" this.oDiv.Name:"+this.oAnchor+" lDiv.Id:"+lDiv.Id);
                setToAnchor(this.oAnchorId, this.oAnchorName, lDiv.Id);
            }
            this.oDiv.style.visibility = "visible";
	}
	else { // hide the popup-div
		this.oDiv.innerHTML = "";
		this.oDiv.style.visibility = "hidden";
	}

/*********
 * Positionnement d'un Div par Rapport à un Anchor
 */


var ns4 = (document.layers)? true:false;   //NS 4
var ie4 = (document.all)? true:false;   //IE 4
var dom = (document.getElementById)? true:false;   //DOM


function setToAnchor(aAnchorId, aAnchorName, aDiv)
//Fonction permettant de positionner un DIV à une position occupée par une ancre
    {
var DivLeft = 0;   //Position du Div par rapport au côté gauche de la page
var DivTop = 0;   //Position du Div par rapport au haut de la page

    if (dom) {
        DivLeft = getLeft(document.getElementById(aAnchorId));
        DivTop = getTop(document.getElementById(aAnchorId));
        document.getElementById(aDiv).style.left = DivLeft;
        document.getElementById(aDiv).style.top = DivTop;
    }
    else if (ie4) {
        DivLeft = getLeft(document.all(aAnchorId));
        DivTop = getTop(document.all(aAnchorId));
        document.all(aDiv).style.posLeft = DivLeft;
        document.all(aDiv).style.posTop = DivTop;
    }
    else if (ns4) {
        DivLeft = aAnchorName.x;
        DivTop = aAnchorName.y;
        aDiv.pageX = DivLeft;
        aDiv.pageY = DivTop;
    }
    alert("DivLeft:"+DivLeft+" DivTop:"+DivTop);
}

function getLeft(obj)
//Fonction permettant de connaître la position d'un objet
//par rapport au bord gauche de la page.
//Cet objet peut être à l'intérieur d'un autre objet.
    {
	var curleft = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curleft += obj.offsetLeft
			obj = obj.offsetParent;
		}
	}
	else if (obj.x)
		curleft += obj.x;
	return curleft;
    }
function getTop(obj)
//Fonction permettant de connaître la position d'un objet
//par rapport au bord haut de la page.
//Cet objet peut être à l'intérieur d'un autre objet.
    {
	var curtop = 0;
	if (obj.offsetParent)
	{
		while (obj.offsetParent)
		{
			curtop += obj.offsetTop
			obj = obj.offsetParent;
		}
	}
	else if (obj.y)
		curtop += obj.y;
	return curtop;
    }

}

var url = "/action.servlet";//"/action.servlet?event=EditorJavaCompletion&"; // The server-side script
/*
function SymError() {
  return true;
}

window.onerror = SymError;
*/
var ac;

var source = [
"switch",
"function",
"if",
"else"];


var remplacant = [
"<b><font color=blue>switch</font></b>",
"<b><i><font color=green>function</font></i></b>",
"<b><font color=red>if</font></b>",
"<b><font color=red>else</font></b>"]

var color = [
"blue",
"green",
"red",
"red"]

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
  } else { // XMLHttpRequest non supportamp;eacute; par le navigateur
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

function AutoComplete(oHttp, inputName, divName, anchorName, anchorId) {
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

	this.oReady = true;
	this.oDivFocus = null;
        this.oThreadClean = null;

	// preprocess the texts for fast access
	this.db = new Array();
/*
        if (this.oText.tagName == 'IFRAME') {
	  this.oText = this.oText.document.body
        }
*/
        // attach handlers to the text-box
        this.oText.AutoComplete = this;
        this.oText.onkeyup = AutoComplete.prototype.onTextChange;
        this.oText.onclick = AutoComplete.prototype.onClick;
        this.oText.onselect = AutoComplete.prototype.onSelect;
}

AutoComplete.prototype.onClick = function() {
//alert("AutoCompleteDB.prototype.onClick");
  this.AutoComplete.storeCaret();
}

AutoComplete.prototype.onSelect = function() {
//alert("AutoCompleteDB.prototype.onSelect");
  this.AutoComplete.storeCaret();
}

AutoComplete.prototype.onTextChange = function() {
//alert("AutoCompleteDB.prototype.onTextChange");
  this.AutoComplete.storeCaret();

  var oEvent = window.event;
  var iKeyCode = oEvent.keyCode;
  if ((iKeyCode == 110) || (iKeyCode == 190)) { // Caractere : '.'
    if (this.AutoComplete.oReady == true) {
      this.AutoComplete.oReady = false;
      this.AutoComplete.onchange();
      this.AutoComplete.oReady = true;
    }
  }
  else if (iKeyCode!=32) {  // 32 = espace
	var textab = this.innerText.split(/ /);
        var pos = 0;
        var len = 0;
	//textab[2] = 3eme mot dans le textarea
	//document.getElementById('test').value =
	//source.length = nombre d'elements dans le tableau source
	//document.getElementById('oDiv').value = document.getElementById('oDiv').selectionStart
	for (i=0; i<textab.length; i++) {   // parcours du textarea
//          alert('textab[i]:'+textab[i]);
          len = textab[i].length;
          pos += len + 1;
	  for (j=0; j<source.length; j++) {   // parcours des tableaux de mots a corriger
//            alert('source[j]:'+source[j]);
	    if (textab[i]==source[j]) {
	      this.select(pos-len, pos);
	      this.contentWindow.document.execCommand("ForeColor","true","#FF0033");
//	      this.setSelectionRange(pos-len, pos);
//	      this.setSelectionColor(color[j]); // change background of selected text
//	      this.setSelectedTextColor(color[j]); // change foreground of selected text
//	      textab[i] = remplacant[j];
//	      this.innerText="";
//              alert(textab.join(' '));
//	       this.innerHTML=textab.join(' ');
	   }
         }
       }
  }
}

AutoComplete.prototype.onDivMouseDown = function() {
//alert("AutoCompleteDB.prototype.onDivMouseDown");
    // Insertion du text à la postion actuelle
    insertAtCaret(this.AutoComplete.oText, this.innerHTML);

    // clear the popup-div.
    while ( this.AutoComplete.oDiv.hasChildNodes() )
            this.AutoComplete.oDiv.removeChild(this.AutoComplete.oDiv.firstChild);

    this.AutoComplete.oDiv.style.visibility = "hidden";
}

AutoComplete.prototype.onDivMouseOver = function() {
//alert("AutoCompleteDB.prototype.onDivMouseOver");
  if (ac.oDivFocus!=null)
    ac.oDivFocus.className = "AutoCompleteBackground";
  ac.oDivFocus = this;
  this.className = "AutoCompleteHighlight";
  this.focus();
  if (ac.oThreadClean!=null)
    clearTimeout(ac.oThreadClean);
}

AutoComplete.prototype.onDivMouseOut = function() {
//alert("AutoCompleteDB.prototype.onDivMouseOut");
  this.className = "AutoCompleteBackground";
  ac.oThreadClean = setTimeout("cleanDiv()", 1000);
}

AutoComplete.prototype.onDivKeyUp = function() {
//alert("AutoCompleteDB.prototype.onDivKeyUp");
  var oEvent = window.event;
  var iKeyCode = oEvent.keyCode;

  if (iKeyCode == 38) { // Fleche Haut
    var myId = "aDiv" + (Number(this.id.substring(4)) - 1);
    var myDiv = document.getElementById(myId);
    if (myDiv != null) {
      this.className = "AutoCompleteBackground";
      myDiv.focus();
      ac.oDivFocus = myDiv;
    }
  }
  else if (iKeyCode == 40) { // Fleche Bas
    var myId = "aDiv" + (Number(this.id.substring(4)) + 1);
    var myDiv = document.getElementById(myId);
    if (myDiv != null) {
      this.className = "AutoCompleteBackground";
      myDiv.focus();
      ac.oDivFocus = myDiv;
    }
  }
  else if(iKeyCode == 27) { // Escape
    cleanDiv();
    ac.oDivFocus = null;
  }
  else if(iKeyCode == 32) { // Espace
    this.onmousedown();
    ac.oDivFocus = null;
  }
  else if(iKeyCode == 39) { // Fleche Droite
    this.onmousedown();
    ac.oDivFocus = null;
  }
  else {
//    alert(iKeyCode);
  }
}

AutoComplete.prototype.handleHttpResponse = function() {
//alert("handleHttpResponse ac.oHttp.readyState: "+ac.oHttp.readyState);
  switch (ac.oHttp.readyState) {
    case 0: //uninitialized : Object has not started loading data yet
    	break;
    case 1: //loading : Data is loading
      //setTimeout("buildDiv()", 2000);
      break;
    case 2: //loaded : Data is loaded, but object may be starting up
      break;
    case 3: //interactive : Data may not be loaded fully, but user can interact with element
      break;
    case 4: //complete : Element and data fully loaded
      var tmp = ac.oHttp.responseText.split(":");
      if(typeof(tmp[1]) != "undefined") {
        var size = tmp.length;
        for(var i=0 ; i<size ; i++) {
	  ac.db.push(tmp[i]);
        }
      }
      buildDiv();
      break;
    default:
      alert("handleHttpResponse ac.oHttp.readyState: "+ac.oHttp.readyState);
  }
}

AutoComplete.prototype.storeCaret = function() {
  if (this.oText.createTextRange) {
    this.oText.caretPos = document.selection.createRange().duplicate();
  }
}

AutoComplete.prototype.onchange = function() {
//alert("AutoCompleteDB.prototype.onchange");
    if ( this.oText.isTextEdit && this.oText.caretPos ) {
      var bookmark = "~";
      var orig = this.oText.value;
      var caretPos = this.oText.caretPos;
      // Place la marque de position au niveau du curseur
      caretPos.text = bookmark;
      // Recherche la postion de la marque
      var pos = this.oText.value.search(bookmark);
      var posOrig = pos;
      // Affiche dans la barre de status la postion du curseur
      window.status = "Caret is at character " + pos;
      // Re mets le texte d'origine
      this.oText.value = orig;
      this.db = new Array();
      var txt = this.oText.value;
      var urlParam = "event=EditorJavaCompletion&caretPos=" + pos + "&source=" + escape(txt);
      var method   = "POST";//"GET";
      if(method == "GET") {
      	this.oHttp.open(method, url + "&" + urlParam, true);
      	this.oHttp.onreadystatechange = AutoComplete.prototype.handleHttpResponse;
      	this.oHttp.send(null);
      }
      else { // POST
      	this.oHttp.open(method, url, true);
      	this.oHttp.onreadystatechange = AutoComplete.prototype.handleHttpResponse;
      	this.oHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
      	this.oHttp.send(urlParam);
      }

      // Damp;eacute;cramp;eacute;mente le nombre de retour chario du nombre de caractères
      for(var i=0;i<posOrig;i++) {
        if (orig.charAt(i)=="\r")
          pos--;
      }

      // Positionne le curseur
      setCursorPosition(this.oText, pos, pos);
   }
}

AutoComplete.prototype.cleanData = function() {
//alert("AutoCompleteDB.prototype.cleanData");
  this.db = new Array();
}

function cleanDiv() {
//alert("AutoCompleteDB.prototype.cleanDiv");
  // clear the popup-div.
  while (ac.oDiv.hasChildNodes())
    ac.oDiv.removeChild(ac.oDiv.firstChild);
  ac.oDiv.innerHTML = "";
  ac.oDiv.style.visibility = "hidden";
}

function buildDiv() {
//alert("AutoCompleteDB.prototype.buildDiv");

  // add each string to the popup-div
  var n = ac.db.length;
  if (n>0) {
    // clear the popup-div.
    cleanDiv();

    var lDiv = document.createElement("div");
    lDiv.id = "aDiv0";
    lDiv.innerHTML = ac.db[0];
    lDiv.className = "AutoCompleteHeader";
    lDiv.AutoComplete = this;
    ac.oDiv.appendChild(lDiv);

    var aDiv = document.createElement("div");
    aDiv.id = "aDiv";
    aDiv.className = "comboCompletion";
    ac.oDiv.appendChild(aDiv);
    for (var i=1 ; i<n ; i++ ) {
      lDiv = document.createElement("div");
      lDiv.id = "aDiv"+i;
      lDiv.innerHTML = ac.db[i];
      lDiv.onmousedown = AutoComplete.prototype.onDivMouseDown;
      lDiv.onmouseover = AutoComplete.prototype.onDivMouseOver;
      lDiv.onmouseout = AutoComplete.prototype.onDivMouseOut;
      lDiv.onfocus = AutoComplete.prototype.onDivMouseOver;
      lDiv.onkeyup = AutoComplete.prototype.onDivKeyUp;
      lDiv.className = "AutoCompleteBackground";
      lDiv.AutoComplete = ac;
      aDiv.appendChild(lDiv);
    }
    setToAnchor(ac.oAnchorId, ac.oAnchorName, ac.oDivName);
    ac.oDiv.style.visibility = "visible";
    document.getElementById("aDiv1").focus();
    ac.cleanData();
  }
}

/*********
 * Positionnement d'un Div par Rapport à un Anchor
 */


var ns4 = (document.layers)? true:false;   //NS 4
var ie4 = (document.all)? true:false;   //IE 4
var dom = (document.getElementById)? true:false;   //DOM


function setToAnchor(aAnchorId, aAnchorName, aDiv)
//Fonction permettant de positionner un DIV à une position occupamp;eacute;e par une ancre
    {
var DivLeft = 0;   //Position du Div par rapport au côtamp;eacute; gauche de la page
var DivTop = 0;   //Position du Div par rapport au haut de la page

    if (dom) {
        DivLeft = ac.oText.caretPos.offsetLeft;//getLeft(document.getElementById(aAnchorId));
        DivTop = ac.oText.caretPos.offsetTop;//getTop(document.getElementById(aAnchorId));
        document.getElementById(aDiv).style.left = DivLeft;
        document.getElementById(aDiv).style.top = DivTop;
    }
    else if (ie4) {
        DivLeft = ac.oText.caretPos.offsetLeft;//getLeft(document.all(aAnchorId));
        DivTop = ac.oText.caretPos.offsetTop;//getTop(document.all(aAnchorId));
        document.all(aDiv).style.posLeft = DivLeft;
        document.all(aDiv).style.posTop = DivTop;
    }
    else if (ns4) {
        DivLeft = ac.oText.caretPos.offsetLeft;//aAnchorName.x;
        DivTop = ac.oText.caretPos.offsetTop;//aAnchorName.y;
        aDiv.pageX = DivLeft;
        aDiv.pageY = DivTop;
    }
//    alert("DivLeft:"+DivLeft+" DivTop:"+DivTop);
}

function getLeft(obj)
//Fonction permettant de connaître la position d'un objet
//par rapport au bord gauche de la page.
//Cet objet peut être à l'intamp;eacute;rieur d'un autre objet.
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
//Cet objet peut être à l'intamp;eacute;rieur d'un autre objet.
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

/****
 * textArea_Event
 */

/*
textArea_Event.prototype.insertAtCaret = function(text) {
*/
function insertAtCaret(lText, text) {
  lText.focus();
  if (lText.createTextRange) {
     var text;
     lText.focus(lText.caretPos);
     lText.caretPos = document.selection.createRange().duplicate();
     if(lText.caretPos.text.length>0) {
        //gère les espace de fin de samp;eacute;lection. Un double-click samp;eacute;lectionne le mot
        //+ un espace qu'on ne souhaite pas forcamp;eacute;ment...
        var sel = lText.caretPos.text;
        var fin = '';
        while(sel.substring(sel.length-1, sel.length)==' ') {
           sel = sel.substring(0, sel.length-1)
           fin += ' ';
        }
        lText.caretPos.text = sel + fin;
     }
     else
        lText.caretPos.text = text;
  }
  else lText.value += text;
}

function setCursorPosition(oInput,oStart,oEnd) {
   if( oInput.setSelectionRange ) {
     oInput.setSelectionRange(oStart,oEnd);
   }
   else if( oInput.createTextRange ) {
      var range = oInput.createTextRange();
      range.collapse(true);
      range.moveEnd('character',oEnd);
      range.moveStart('character',oStart);
      range.select();
   }
}

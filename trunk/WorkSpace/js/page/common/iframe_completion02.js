var url = "/WorkSpace/action.servlet";//"/WorkSpace/action.servlet?event=EditorJavaCompletion&"; // The server-side script
/*
function SymError() {
  return true;
}

window.onerror = SymError;
*/
var ac;

var source = [
"void",
"public",
"protected",
"private",
"import",
"package",
"class",
"switch",
"function",
"if",
"else",
"try",
"catch",
"static",
"\"",
"}",
"{"
];


var remplacant = [
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=green>', '</font></b>'],
['<font color=black>', '</font>'],
['<font color=black>', '</font>']
];

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

function onsumbitform() {
  document.getElementById('FileEditor').value = document.getElementById('htmle').contentWindow.document.body.innerText;
/*
  var text = document.getElementById('htmle').contentWindow.document.body.outerHTML;
  var idxS = 0, idxE = 0, len;
  /**
   * Suppression de toutes les balises Html
   *-/
  do {
    idxS = text.indexOf('<', idxS);
    idxE = text.indexOf('>', idxE);
    len = text.length
    if ((idxS>0)&&(idxE>0)) {
      text = text.substring(0, idxS) + text.substring(idxE+1, len);
    }
    else
      break;
  } while(true);
  document.getElementById('FileEditor').value = text;
*/
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

        if (this.oText.tagName.toUpperCase() == 'IFRAME') {
          frames[this.oTextName].document.designMode='On';
        }
        else
          this.oText.isTextEdit = true;

	// preprocess the texts for fast access
	this.db = new Array();
        // attach handlers to the text-box
        this.getDocument().AutoComplete = this;
        this.getDocument().onkeyup = AutoComplete.prototype.onTextChange;
        this.getDocument().onclick = AutoComplete.prototype.onClick;
        this.getDocument().onselect = AutoComplete.prototype.onSelect;
}
function test() {
  alert(event);
}

AutoComplete.prototype.getDocument = function() {
//alert("AutoCompleteDB.prototype.getDocument");
  if (this.oText.tagName.toUpperCase() == 'IFRAME')
    return frames[this.oText.name].document;
  else
    return this.oText;
}

AutoComplete.prototype.getRange = function() {
//alert("AutoCompleteDB.prototype.getDocument");
  if (this.oText.tagName.toUpperCase() == 'IFRAME') {
    return frames[this.oText.name].document.selection.createRange().duplicate();
  }
  else {
    if(this.getDocument.createTextRange ) {
      return this.oText.createTextRange();
    }
    else
      return;
  }
}

AutoComplete.prototype.getText = function() {
//alert("AutoCompleteDB.prototype.getText");
  if (this.oText.tagName.toUpperCase() == 'IFRAME')
    return frames[this.oText.name].document.body.innerText;
  else
    return this.oText.value;
}

AutoComplete.prototype.setText = function(text) {
//alert("AutoCompleteDB.prototype.getText");
  if (this.oText.tagName.toUpperCase() == 'IFRAME')
    frames[this.oText.name].document.body.innerText = text;
  else
    this.oText.value = text;
}

AutoComplete.prototype.setHtml = function(text) {
//alert("AutoCompleteDB.prototype.getText");
  if (this.oText.tagName.toUpperCase() == 'IFRAME')
    frames[this.oText.name].document.body.innerHTML = text;
  else
    this.oText.value = text;
}

AutoComplete.prototype.getIsTextEdit = function() {
//alert("AutoCompleteDB.prototype.isTextEdit");
  if (this.oText.tagName.toUpperCase() == 'IFRAME')
    return (frames[this.oText.name].document.designMode.toUpperCase() == 'ON');
  else
    return this.oText.isTextEdit;
}

AutoComplete.prototype.getCaretPos = function() {
//alert("AutoCompleteDB.prototype.getCaretPos");
      var bookmark = "~";
      var orig;
      var pos = 0;

      if (this.oText.tagName.toUpperCase() == 'IFRAME') {
        var workRange=frames[this.oText.name].document.selection.createRange();
        var len = workRange.text.length;
        var lenTmp = len-1;
        while (len != lenTmp) {
          lenTmp = len;
          workRange.moveStart('character', -1);
          pos++;
          len = workRange.text.length;
        }
        pos--;
        workRange.moveStart('character', pos);
      }
      else {
        orig = this.oText.value;
        // Place la marque de position au niveau du curseur
        this.oText.caretPos.text = bookmark;
        // Recherche la postion de la marque
        pos = this.oText.value.search(bookmark);
        // Re mets le texte d'origine
        this.oText.value = orig;
      }

      // Affiche dans la barre de status la postion du curseur
      window.status = "Caret is at character " + pos;

      return pos;
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
//alert("AutoCompleteDB.prototype.onTextChange:");
  this.AutoComplete.storeCaret();
  var aRange = this.AutoComplete.getRange();//frames['htmle'].document.selection.createRange().duplicate()
  aRange.moveStart('character', -1);
  var aText = aRange.text;
  var aCar = '';
  if (aText!='')
    aCar = aText.charCodeAt(0);
  else
    aRange.moveStart('character', 1);
  if (isCompletionCar(aCar)) { // Caractere : '.'
    var pos = this.AutoComplete.getCaretPos();
    var text = this.AutoComplete.getText();
    if (this.AutoComplete.getIsTextEdit() && this.AutoComplete.oText.caretPos) {
      this.db = new Array();
      completion(text, pos);
    }
    document.focus();
  }
  else { //if (isSpaceCar(aCar)) {
    if (isSpaceCar(aCar) && (aCar!='') && (aCar!=NaN))
      aRange.moveEnd('character', -1);
    aRange.moveStart('word', -1);
    aText = aRange.text;
    for (var i=0; i<source.length; i++) {
      // parcours des tableaux de mots a formater (colorizer)
      if (aText.toUpperCase()==source[i].toUpperCase()) {
        aRange.pasteHTML(remplacant[i][0] + aText + remplacant[i][1]);
        break;
      }
    }
  }
}

AutoComplete.prototype.colorizeHtml = function(text) {
/*
  var newText = colorize(text, '&nbsp;');
  newText = colorize(newText, '<br>');
  return newText;
*/
  return colorize(text);
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
//alert("AutoCompleteDB.prototype.storeCaret");
  if (this.getDocument().selection) {
    this.oText.caretPos = this.getDocument().selection.createRange().duplicate();
  }
}

AutoComplete.prototype.cleanData = function() {
//alert("AutoCompleteDB.prototype.cleanData");
  this.db = new Array();
}


function colorize(text) {
  var newText = '';
  var len = 0, pos = 0, i, j, k;
  var textab = text.split('&nbsp;');
  for (i=0; i<textab.length; i++) {   // parcours du textarea
    var texBr = textab[i].split('<br>');
    for (j=0; j<texBr.length; j++) {   // parcours du textarea
      len = texBr[j].length;
      pos += len;
      add = true;
      for (k=0; k<source.length; k++) {   // parcours des tableaux de mots a corriger
        if (texBr[j]==source[k]) {
          newText += remplacant[k][0] + texBr[j] + remplacant[k][1];
          add = false;
          break;
        }
      }
      if (add)
        newText += texBr[j];
      if (j<(texBr.length-1)) {
        newText += '<br>';
        pos += 1;
      }
    }
    if (i<(textab.length-1)) {
      newText += '&nbsp;';
      pos += 1;
    }
  }
  return newText;
}
/*
function colorize(text, sep) {
  var newText = '';
  var len = 0, pos = 0, i;
  var textab = text.split(sep);
  for (i=0; i<textab.length; i++) {   // parcours du textarea
    len = textab[i].length;
    pos += len;
    add = true;
    for (j=0; j<source.length; j++) {   // parcours des tableaux de mots a corriger
      if (textab[i]==source[j]) {
        newText += remplacant[j][0] + textab[i]	 + remplacant[j][1];
        add = false;
      }
    }
    if (add)
      newText += textab[i];
    if (i<(textab.length-1)) {
      newText += sep;
      pos += 1;
    }
  }
  return newText;
}
*/
function isTextCaractere(car) {
  return (!isSpaceCar(car)) ||
      // entre A et Z
      (((car >= 65) && (car <= 90))) ||
      // entre a et z
      (((car >= 97) && (car <= 122))) ||
      // entre À [&Agrave;] et ÿ [&yuml;] sauf × [&times;], ÷ [&divide;]
      (((car >= 192) && (car <= 255) && (car != 215) && (car != 247)))
}

function isSpaceCar(car) {
  return ((car==32) || (car=='\t') || (car=='\r') || (car=='\n') || (car==160) || (car==10) || (car==32));
}

function initIframe(text) {
//alert("initIframe");
  text = AutoComplete.prototype.colorizeHtml(formatHtml(text));
  frames['htmle'].document.open("text/html","replace");
  frames['htmle'].document.write('<html><head>');
  frames['htmle'].document.write('<link href="/WorkSpace/css/component/wysywyg/editor_iframe.css" rel="stylesheet" type="text/css">');
  frames['htmle'].document.write('</head>');
  frames['htmle'].document.write('<body>');
  frames['htmle'].document.write('<div>');
  frames['htmle'].document.write(text);
  frames['htmle'].document.write('</div>');
  frames['htmle'].document.write('</body></html>');
  frames['htmle'].document.close();
}

function updateIframe() {
//alert("updateIframe");
  var text = initIframe(frames['htmle'].document.body.innerHTML);//outerHTML);
}

function formatHtml(text) {
//alert("formatHtml");
  var ret = "";
  var size = text.length;
  for(var i=0;i<size;i++) {
    car = text.charAt(i);
    if (car=="\n")
      ret += "<br>";
    else if (car==" ")
      ret += "&nbsp;";
    else if (car!="\r")
      ret += car;
  }
  return ret;
}

function completion(txt, pos) {
//alert("completion");
  // Suppression des \n
  txt = txt.replace(/\n|\n/g, "");
  var urlParam = "event=EditorJavaCompletion&caretPos=" + pos + "&source=" + escape(txt);
  var method   = "POST";//"GET";
  if(method == "GET") {
    ac.oHttp.open(method, url + "&" + urlParam, true);
    ac.oHttp.onreadystatechange = AutoComplete.prototype.handleHttpResponse;
    ac.oHttp.send(null);
  }
  else { // POST
    ac.oHttp.open(method, url, true);
    ac.oHttp.onreadystatechange = AutoComplete.prototype.handleHttpResponse;
    ac.oHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    ac.oHttp.send(urlParam);
  }

  // Damp;eacute;cramp;eacute;mente le nombre de retour chario du nombre de caractères
  var posOrig = pos;
  for(var i=0;i<posOrig;i++) {
    if (txt.charAt(i)=="\r")
      pos--;
  }
}

function isCompletionCar(iKeyCode) {
//alert("isCompletionCar iKeyCode:"+iKeyCode);
//  return ((iKeyCode == 110) || (iKeyCode == 190));
  return (iKeyCode == 46);
//  return (iKeyCode == 13);
}

function cleanDiv() {
//alert("cleanDiv");
  // clear the popup-div.
  while (ac.oDiv.hasChildNodes())
    ac.oDiv.removeChild(ac.oDiv.firstChild);
  ac.oDiv.innerHTML = "";
  ac.oDiv.style.visibility = "hidden";
}

function buildDiv() {
//alert("buildDiv");

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
    ac.oDiv.focus();
    document.getElementById("aDiv1").focus();
    ac.cleanData();
  }
}

function insertAtCaret(lText, text) {
//alert("insertAtCaret");
  frames[ac.oTextName].focus();
  var aRange = ac.getRange();
  aRange.pasteHTML(text);
}

function setCursorPosition(oInput, range, oStart, oEnd) {
//alert('setCursorPosition oStart:'+oStart+' oEnd:'+oEnd);
  oInput.focus();
  if (oInput.tagName.toUpperCase() == 'IFRAME') {
    range.collapse(true);
    range.moveEnd('character',oEnd);
    range.moveStart('character',oStart);
    range.select();
  }
  else {
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
        DivLeft = getLeft(document.getElementById(aAnchorId)) + ac.oText.caretPos.offsetLeft;
        DivTop = getTop(document.getElementById(aAnchorId)) + ac.oText.caretPos.offsetTop + 15;
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

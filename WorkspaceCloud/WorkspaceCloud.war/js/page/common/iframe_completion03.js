var url = "/action.servlet";//"/action.servlet?event=EditorJavaCompletion&"; // The server-side script
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
"extends",
"instanceof",
"final",
"import",
"package",
"class",
"switch",
"function",
"if",
"else",
"while",
"for",
"try",
"catch",
"static",
"return",
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
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=blue>', '</font></b>'],
['<b><font color=gray>', '</font></b>'],
['<font color=black>', '</font>'],
['<font color=black>', '</font>']
];

var comment = ['<font color=green>', '</font>'];
var stringChar = ['<font color=gray>', '</font>'];

var _agt       = navigator.userAgent.toLowerCase();
var _is_ie     = ((_agt.indexOf("msie") != -1) && (_agt.indexOf("opera") == -1));
var _is_opera  = (_agt.indexOf("opera") != -1);
var _is_mac    = (_agt.indexOf("mac") != -1);
var _is_mac_ie = (_is_ie && _is_mac);
var _is_win_ie = (_is_ie && !_is_mac);
var _is_gecko  = (navigator.product == "Gecko");

_addEvent = function(el, evname, func) {
    if (_is_ie) {
        el.attachEvent("on" + evname, func);
    } else {
        el.addEventListener(evname, func, true);
    }
}

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
    _addEvent(this.getDocument(), 'keydown', AutoComplete.prototype.beforeTextChange);
    _addEvent(this.getDocument(), 'keyup', AutoComplete.prototype.onTextChange);
    _addEvent(this.getDocument(), 'click', AutoComplete.prototype.onClick);
    _addEvent(this.getDocument(), 'select', AutoComplete.prototype.onSelect);
}

AutoComplete.prototype.getDocument = function() {
//alert("AutoCompleteDB.prototype.getDocument");
  if (this.oText.tagName.toUpperCase() == 'IFRAME')
    return frames[this.oText.name].document;
  else
    return this.oText;
}

AutoComplete.prototype.getRange = function() {
//alert("AutoCompleteDB.prototype.getRange");
  if (this.oText.tagName.toUpperCase() == 'IFRAME') {
    return frames[this.oText.name].document.selection.createRange().duplicate();
  }
  else {
    if(this.getDocument().createTextRange ) {
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

AutoComplete.prototype.onClick = function(evt) {
//alert("AutoCompleteDB.prototype.onClick");
  ac.storeCaret();
}

AutoComplete.prototype.onSelect = function(evt) {
//alert("AutoCompleteDB.prototype.onSelect");
  ac.storeCaret();
}

AutoComplete.prototype.beforeTextChange = function(evt) {
//alert("AutoComplete.prototype.beforeTextChange:");
  var aCar = evt.keyCode;
  var car, cnt, len;
  var pos=0;
  var middle = false;
  var unComment = false, unCommentBlock = false;
  var aRange;
  if (aCar==8){ //DELETE BACK
    aRange = ac.getRange();
    aRange.moveStart('character', -2);
    cnt=2;
    car = aRange.text;
    unComment = car=='//';
    unCommentBlock = !unComment && (car=='/*' || car=='*/');
    if (!unComment && !unCommentBlock) {
      aRange.moveStart('character', 1);
      aRange.moveEnd('character', 1);
      car = aRange.text;
      unComment = car=='//';
      unCommentBlock = !unComment && (car=='/*' || car=='*/');
      middle = true;
    }
  }
  else if (aCar==46) {  //DELETE
    aRange = ac.getRange();
    aRange.moveEnd('character', 2);
    cnt=2;
    pos=1;
    cnt++;
    car = aRange.text;
    unComment = car=='//';
    unCommentBlock = !unComment && (car=='/*' || car=='*/');
    if (!unComment && !unCommentBlock) {
      aRange.moveStart('character', -1);
      aRange.moveEnd('character', -1);
      cnt++;
      car = aRange.text;
      unComment = car=='//';
      unCommentBlock = !unComment && (car=='/*' || car=='*/');
      middle = true;
    }
    else
      cnt+=2;
  }
  else if (aCar==13) {  //RETURN
  }

  if (unComment) {
    do {
      len = car.length;
      aRange.moveEnd('character', 1);
      car = aRange.htmlText;
      if(car.toLowerCase().indexOf('<br>')>=0) {
        aRange.moveStart('character', -1);
        aRange.moveEnd('character', 1);
        var html = trimDiv(aRange.htmlText);
        html = html.toLowerCase();
        html = html.replace(comment[0], '');
        html = html.replace(comment[1], '');
        aRange.pasteHTML('<font>'+html+'</font>');
        aRange.moveStart('character', -cnt);
        aRange.moveEnd('character', -cnt);
        aRange.select();
        break;
      }
      cnt++;
    }
    while(len!=car.length);
  }
  else if (unCommentBlock) {
    var aEnd, aSens;
    if (car=='*/') {
      aEnd = '/*';
      aSens = -1;
    }
    else {
      aEnd = '*/';
      aSens = 1;
    }
    var ret = 0;
    do {
      len = car.length;
      if (aSens>0) {
        ret=aRange.moveEnd('character', aSens);
      }
      else {
        ret=aRange.moveStart('character', aSens);
      }
      car = aRange.htmlText;
      if (((len>=4)&&(car.substring(len-4, len).toLowerCase()=='<br>')) ||
          ((len>=5)&&(car.substring(len-5, len).toLowerCase()=='<div>'))) {
        cnt++;
      }
      if(car.indexOf(aEnd)>=0) {
        aRange.moveStart('character', -1);
        aRange.moveEnd('character', 1);
        var html = trimDiv(aRange.htmlText);
        html = html.toLowerCase();
        html = html.replace(comment[0], '');
        html = html.replace(comment[1], '');
        aRange.pasteHTML(html);
        if (aSens>0) {
          if(pos==1)       cnt--;
          else if (middle) cnt++;
          aRange.moveStart('character', -cnt);
          aRange.moveEnd('character', -cnt);
        }
        else {
            if (middle) cnt = 2;
            else        cnt = (pos==0) ? 1 : 3;
            aRange.moveStart('character', -cnt);
            aRange.moveEnd('character', -cnt);
        }
        aRange.select();
        break;
      }
      cnt+=aSens;
    }
    while(ret!=0);
  }
}

AutoComplete.prototype.onTextChange = function(evt) {
//alert("AutoComplete.prototype.onTextChange:");
  if (!evt)
    evt = window.event;
  ac.storeCaret();
  var aRange = ac.getRange();
  var aCar = evt.keyCode;
  if (evt.ctrlKey && isCompletionCar(aCar)) { // Caractere : '.'
    var pos = ac.getCaretPos();
    var text = ac.getText();
    if (ac.getIsTextEdit() && ac.oText.caretPos) {
      this.db = new Array();
      completion(text, pos);
    }
    document.focus();
  }
  else if (aCar==51) { // Caractere : '"'
    aRange.moveStart('character', -1);
    aRange.pasteHTML(stringChar[0] + '"' + stringChar[1]);
  }
  else if (aCar==106) { // Caractere : '*'
    aRange.moveStart('character', -2);
    var c = aRange.text;
    if (c=='/*') {
      aRange.moveEnd('character', +1);
      c = aRange.text;
      var len = 0;
      var cnt = 2;
      while(len!=c.length) {
        len = c.length;
        aRange.moveEnd('character', +1);
        c = aRange.text.substring(2);
        if(c.indexOf('/*')>=0) {
          break;
        }
        else if(c.indexOf('*/')>=0) {
          var html = trimDiv(aRange.htmlText);
          aRange.pasteHTML(comment[0] + html + comment[1]);
          aRange.moveStart('character', -cnt);
          aRange.moveEnd('character', -cnt);
          aRange.select();
          break;
        }
        cnt++;
      }
    }
  }
  else if (aCar==111) { // Caractere : '/'
    aRange.moveStart('character', -2);
    var c = aRange.text;
    if (c=='*/') {
      var len = 0;
      do {
        len = c.length;
        aRange.moveStart('character', -1);
        c = aRange.text;
        var aLen = c.length-2;
        if(c.substring(0, aLen).indexOf('/*')>=0) {
          var html = trimDiv(aRange.htmlText);
          aRange.pasteHTML(comment[0] + html + comment[1]);
          break;
        }
        else if(c.substring(0, aLen).indexOf('*/')>=0) {
          break;
        }
      }
      while(len!=c.length);
    }
    else if (c=='//') {
      var len = 0, cnt = 1;
      do {
        len = c.length;
        aRange.moveEnd('character', 1);
        c = aRange.htmlText;
        if(c.toLowerCase().indexOf('<br>')>=0) {
          var html = trimDiv(aRange.htmlText);
          aRange.pasteHTML(comment[0] + html + comment[1]);
          aRange.moveStart('character', -cnt);
          aRange.moveEnd('character', -cnt);
          aRange.select();
          break;
        }
        cnt++;
      }
      while(len!=c.length);
    }
  }
  else { //if (isSpaceCar(aCar)) {
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
    
    // Insertion du text ? la postion actuelle
    insertAtCaret(this.AutoComplete.oText, "."+this.innerHTML);

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
  else if(iKeyCode == 32 || iKeyCode == 13) { // Espace || Enter
    this.onmousedown();
    ac.oDivFocus = null;
  }
  else if(iKeyCode == 39) { // Fleche Droite
    this.onmousedown();
    ac.oDivFocus = null;
  }
  else {
    //alert(iKeyCode);
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
  // Variables pour la colorization des '"'
  var posQuot=0, nbQuot=0, lenQuot1=(6+stringChar[0].length), lenQuot2=6;
  var posComM1=0, posComM2=0, lenComM1=(10+comment[0].length), lenComM2=10;
  var textab = text.split('&nbsp;');
  var inCommentM = false;
  var inComment = false;
  var inString = false;
  for (i=0; i<textab.length; i++) {   // parcours du textarea
    var texBr = textab[i].split('<br>');
    for (j=0; j<texBr.length; j++) {   // parcours du textarea

      len = texBr[j].length;
      posQuot = 0;
      posComM1 = posComM2 = 0;

      // Colorization des '//'
      if (!inCommentM && !inComment && !inString) {
        var cnt = texBr[j].indexOf('&#47;&#47;');
        if (cnt>=0) {
          texBr[j] = texBr[j].substring(0, cnt) + comment[0] + texBr[j].substring(cnt);
          inComment = true;
        }
        else {
          cnt = texBr[j].indexOf('//');
          if (cnt>=0) {
            texBr[j] = texBr[j].substring(0, cnt) + comment[0] + texBr[j].substring(cnt);
            inComment = true;
          }
        }
      }

      // Colorization des '/*' '*/'
      //newText = newText.replace(/\s*&#47;&#42;/g, comment[0] + "&#47;&#42;");
      //newText = newText.replace(/\s*&#42;&#47;/g, "&#42;&#47;" + comment[1]);
      if (!inComment && !inString) {
        do {
          posComM1 = texBr[j].indexOf('&#47;&#42;', posComM1);
          posComM2 = texBr[j].indexOf('&#42;&#47;', ((posComM1>=0)&&(posComM1<len)) ? posComM1 : 0);
          if(posComM1>len)
            posComM1=-1;
          else if(posComM1>=0) {
            if (((posComM1<1)||(texBr[j].substr((posComM1-1), 1)!='\\')) &&
                ((posComM1<5)||(texBr[j].substr((posComM1-5), 5)!='&#92;'))) {
              texBr[j]=texBr[j].substring(0, posComM1) + comment[0] + texBr[j].substring(posComM1);
              inCommentM = true;
            }
            posComM1+=lenComM1;
          }
          if(posComM2>len)
            posComM2=-1;
          else if(posComM2>=0) {
            posComM2+=lenComM2;
            if (((posComM2<1)||(texBr[j].substr((posComM2-1-lenComM2), 1)!='\\')) &&
                ((posComM2<5)||(texBr[j].substr((posComM2-5-lenComM2), 5)!='&#92;'))) {
              texBr[j]=texBr[j].substring(0, posComM2) + comment[1] + texBr[j].substring(posComM2);
              inCommentM = false;
            }
            if ((posComM1>=0)&&(posComM1<len))
              posComM1=posComM2;
          }
        }
        while(posComM1>=0);
      }

      if (!inCommentM && !inComment && !inString) {
        // colorization des '"'
        do {
          posQuot = texBr[j].indexOf('&quot;', posQuot);
          if(posQuot>=0) {
            // Si '"' n'est pas precede par un '\'
            if ((posQuot<5)||(texBr[j].substr(posQuot-5, 5)!='&#92;')) {
              if (nbQuot%2==0) {
                texBr[j]=texBr[j].substring(0, posQuot) + stringChar[0] + texBr[j].substring(posQuot);
                posQuot+=lenQuot1;
                inString = true;
              }
              else {
                posQuot+=lenQuot2;
                texBr[j]=texBr[j].substring(0, posQuot) + stringChar[1] + texBr[j].substring(posQuot);
                inString = false;
              }
              nbQuot++;
            }
            else {
              posQuot++;
            }
          }
        }
        while(posQuot>=0);
      }

      if (!inCommentM && !inComment && !inString) {
        pos += len;
        add = true;
        for (k=0; k<source.length; k++) {   // parcours des tableaux de mots a corriger
          if (texBr[j]==source[k]) {
            newText += remplacant[k][0] + texBr[j] + remplacant[k][1];
            add = false;
            break;
          }
        }
        if (add) {
          newText += texBr[j];
        }
      }
      else
        newText += texBr[j];

      if (j<(texBr.length-1)) {
        if (inComment) {
          newText += comment[1];
        }
        // colorization des '"'
        if (inString) {
          newText += stringChar[1];
          nbQuot++;
        }
        newText += '<br>';
        pos += 1;
        inComment = false;
        inString = false;
      }
    }
    if (i<(textab.length-1)) {
      newText += '&nbsp;';
      pos += 1;
    }
  }

//  alert(newText.substr(newText.indexOf('startsWith')-10, 10000));

  return newText;
}

function isTextCaractere(car) {
  return (!isSpaceCar(car)) ||
      // entre A et Z
      (((car >= 65) && (car <= 90))) ||
      // entre a et z
      (((car >= 97) && (car <= 122))) ||
      // entre ? [&Agrave;] et ? [&yuml;] sauf ? [&times;], ? [&divide;]
      (((car >= 192) && (car <= 255) && (car != 215) && (car != 247)))
}

function isSpaceCar(car) {
  return ((car==32) || (car=='\t') || (car=='\r') || (car=='\n') || (car==160) || (car==10) || (car==32));
}

function InitSynchoScroll() {
    frames['htmle'].document.body.onscroll = function() {
        document.getElementById('numberline').scrollTop = frames['htmle'].document.body.scrollTop;
    }
}

function initIframe(text, colorize) {
//alert("initIframe:"+text);
  text = formatHtml(text);
  if (colorize==true)
      text = AutoComplete.prototype.colorizeHtml(text);
  var iFTop = frames['htmle'].document.body.scrollTop;
  var iFLeft= frames['htmle'].document.body.scrollLeft;
  frames['htmle'].document.open("text/html","replace");
  frames['htmle'].document.write('<html><head>');
  frames['htmle'].document.write('<link href="/css/component/wysywyg/editor_iframe.css" rel="stylesheet" type="text/css">');
  frames['htmle'].document.write('</head>');
  frames['htmle'].document.write('<body>');
  //frames['htmle'].document.write('<div>');
  frames['htmle'].document.write(text);
  //frames['htmle'].document.write('</div>');
  frames['htmle'].document.write('</body></html>');
  frames['htmle'].document.close();
/*
  frames['htmle'].document.body.onscroll = function() {
  document.getElementById('numberline').scrollTop = frames['htmle'].document.body.scrollTop;
  }
*/
  //InitSynchoScroll();
  self.setTimeout("InitSynchoScroll()", 2*1000)
  iniNumberLine();
  if (colorize==true) {
      createAutoComplete('htmle', 'classNameDiv', 'classNameAncre', 'classIdAncre');
  }
  // Les deux lignes suivantes sont a concerver
  // car si non les deux autres lignes d'affectation
  // de scrollTop et scrollLeft ne fonctionnent pas
  frames['htmle'].document.body.scrollTop;
  frames['htmle'].document.body.scrollLeft;
  frames['htmle'].document.body.scrollTop = iFTop;
  frames['htmle'].document.body.scrollLeft = iFLeft;
}

function fOnScroll() {
alert('1');
}

function addIframe(text, colorize) {
//alert("addIframe:text:"+text);
  text = formatHtml(text);
  if (colorize==true)
      text = AutoComplete.prototype.colorizeHtml(text);
  var iFTop = frames['htmle'].document.body.scrollTop;
  var iFLeft= frames['htmle'].document.body.scrollLeft;
  var html = trimDiv(frames['htmle'].document.body.innerHTML);
  frames['htmle'].document.open("text/html","replace");
  frames['htmle'].document.write('<html><head>');
  frames['htmle'].document.write('<link href="/css/component/wysywyg/editor_iframe.css" rel="stylesheet" type="text/css">');
  frames['htmle'].document.write('</head>');
  frames['htmle'].document.write('<body>');
  //frames['htmle'].document.write('<div>');
  frames['htmle'].document.write(html);
  frames['htmle'].document.write(text);
  //frames['htmle'].document.write('</div>');
  frames['htmle'].document.write('</body></html>');
  frames['htmle'].document.close();
//  frames['htmle'].document.body.onscroll = function() {
//  document.getElementById('numberline').scrollTop = frames['htmle'].document.body.scrollTop;
//  }
  InitSynchoScroll();
  if (colorize==true) {
      createAutoComplete('htmle', 'classNameDiv', 'classNameAncre', 'classIdAncre');
  }
  // Les deux lignes suivantes sont a concerver
  // car si non les deux autres lignes d'affectation
  // de scrollTop et scrollLeft ne fonctionnent pas
  frames['htmle'].document.body.scrollTop;
  frames['htmle'].document.body.scrollLeft;
  frames['htmle'].document.body.scrollTop = iFTop;
  frames['htmle'].document.body.scrollLeft = iFLeft;
}

function updateIframe(colorize) {
//alert("updateIframe");
  var html = trimDiv(frames['htmle'].document.body.outerText);//outerText);//innerText);//innerHTML);//outerHTML;
  var text = initIframe(html, colorize);
}

// Supprime :
//   - en debut de chaine, tous les caract?res d'espacement (trim) si besoin et <div>
//   - en fin de chaine, tous les caract?res d'espacement (trim) si besoin et </div>
function trimDiv(html) {
  html = html.replace(/^\s*<div>|<\/div>\s*$/gi, '');
//  alert(html);
  return html;
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
    else if (car=='"')
      ret += "&quot;";
    else if (car!="\r")
      ret += car;
  }
  ret = ret.replace(/\/\*/g, '&#47;&#42;');
  ret = ret.replace(/\*\//g, '&#42;&#47;');
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

  // Damp;eacute;cramp;eacute;mente le nombre de retour chario du nombre de caract?res
  var posOrig = pos;
  for(var i=0;i<posOrig;i++) {
    if (txt.charAt(i)=="\r")
      pos--;
  }
}

function isCompletionCar(iKeyCode) {
//alert("isCompletionCar iKeyCode:"+iKeyCode);
  return ((iKeyCode == 110) || (iKeyCode == 190));
//  return (iKeyCode == 46);
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

var szHead = "<table width='100%'><tr><td align='left' class='AutoCompleteHeader'>" + ac.db[0] + "</td><td align='right'><a href='javascript:cleanDiv()'>[X]</a></td></tr></table>";
    var lDiv = document.createElement("div");
    lDiv.id = "aDiv0";
    lDiv.innerHTML = szHead ;
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
      //lDiv.onmouseout = AutoComplete.prototype.onDivMouseOut;
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
 * Positionnement d'un Div par Rapport ? un Anchor
 */


var ns4 = (document.layers)? true:false;   //NS 4
var ie4 = (document.all)? true:false;   //IE 4
var dom = (document.getElementById)? true:false;   //DOM

/*
ESSAI DE RECUPERATION DE LA POSITION DU CURSEUR DANS LA IFRAME
        function initPosition(textBox) {
            var storedValue = textBox.value;
            textBox.value = "";
            textBox.select();

            var caretPos = document.selection.createRange();
            textBox.__boundingTop = caretPos.boundingTop;
            textBox.__boundingLeft = caretPos.boundingLeft;

            textBox.value = " ";
            textBox.select();

            caretPos = document.selection.createRange();
            textBox.__boundingWidth = caretPos.boundingWidth;
            textBox.__boundingHeight = caretPos.boundingHeight;

            textBox.value = storedValue;
        }

        initPosition(document.getElementById('htmle'))
*/
function setToAnchor(aAnchorId, aAnchorName, aDiv)
//Fonction permettant de positionner un DIV ? une position occupamp;eacute;e par une ancre
    {
var DivLeft = 0;   //Position du Div par rapport au c?tamp;eacute; gauche de la page
var DivTop = 0;   //Position du Div par rapport au haut de la page

/*
RECUPERATION DE LA POSITION DU CURSEUR DANS LA IFRAME
*/
var textBox = document.getElementById('htmle')
var caretPos = document.selection.createRange();
var boundingTop = caretPos.offsetTop;
if (textBox.scrollTop != undefined)
    boundingTop += textBox.scrollTop;

var boundingLeft = caretPos.offsetLeft;
if (textBox.scrollLeft != undefined)
    boundingLeft += textBox.scrollLeft;

boundingTop += (caretPos.boundingHeight * 2);
boundingLeft += caretPos.boundingWidth + 1;

// Colonne avec les numeros de ligne
var numberline = document.getElementById('numberline');
boundingLeft += numberline.offsetWidth;
/*
RECUPERATION DE LA POSITION DU CURSEUR DANS LA IFRAME
*/
    if (dom) {
        DivLeft = getLeft(document.getElementById(aAnchorId));// + ac.oText.caretPos.offsetLeft;
        DivTop = getTop(document.getElementById(aAnchorId));// + ac.oText.caretPos.offsetTop + 15;

        DivLeft += boundingLeft;
        DivTop += boundingTop;

        //alert('document.getElementById(aDiv).offsetHeight:'+document.getElementById(aDiv).offsetHeight+' DivTop:'+DivTop);
        //alert('getTop(textBox):'+getTop(textBox)+' textBox.offsetHeight:'+textBox.offsetHeight);

        // Decale vers le haut si la liste de competion deborde du textarea en bas
        var divH = document.getElementById(aDiv).offsetHeight + DivTop;
        var txtH = getTop(textBox)+textBox.offsetHeight;
        //alert('divH:'+divH+' txtH:'+txtH);
        if (txtH<divH)
            DivTop -= (divH-txtH);
        
        //document.getElementById(aDiv).style.position = 'absolute';
        document.getElementById(aDiv).style.left = DivLeft;
        document.getElementById(aDiv).style.top = DivTop;
    }
    else if (ie4) {
        DivLeft = ac.oText.caretPos.offsetLeft;//getLeft(document.all(aAnchorId));
        DivTop = ac.oText.caretPos.offsetTop;//getTop(document.all(aAnchorId));
        DivLeft += boundingLeft;
        DivTop += boundingTop;
        alert("DivLeft:" & DivLeft & " DivTop:" & DivTop)
        document.all(aDiv).style.posLeft = DivLeft;
        document.all(aDiv).style.posTop = DivTop;
    }
    else if (ns4) {
        DivLeft = ac.oText.caretPos.offsetLeft;//aAnchorName.x;
        DivTop = ac.oText.caretPos.offsetTop;//aAnchorName.y;
        DivLeft += boundingLeft;
        DivTop += boundingTop;
        aDiv.pageX = DivLeft;
        aDiv.pageY = DivTop;
    }
//    alert("DivLeft:"+DivLeft+" DivTop:"+DivTop);
}

function getLeft(obj)
//Fonction permettant de conna?tre la position d'un objet
//par rapport au bord gauche de la page.
//Cet objet peut ?tre ? l'intamp;eacute;rieur d'un autre objet.
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
//Fonction permettant de conna?tre la position d'un objet
//par rapport au bord haut de la page.
//Cet objet peut ?tre ? l'intamp;eacute;rieur d'un autre objet.
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
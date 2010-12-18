function init() {
  frames['htmle'].document.designMode='On';
  createAutoComplete('htmle', 'classNameDiv', 'classNameAncre', 'classIdAncre');
}


function range_selection_start() {
  var range = frames['htmle'].document.selection.createRange().duplicate();
  range.collapse(true);
  range.setEndPoint('StartToStart', -1);
  range.select();
  return range;
}

function range_selection_back() {
  var range = frames['htmle'].document.selection.createRange().duplicate();
  range.collapse(true);
  range.moveStart('character', -1);
  range.select();
  return range;
}

function range_selection_next() {
  var range = frames['htmle'].document.selection.createRange().duplicate();
  range.collapse(true);
  range.moveEnd('character', 1);
  range.select();
  return range;
}

function range_expand_back() {
  var range = frames['htmle'].document.selection.createRange().duplicate();
  range.expand(true);
  range.moveStart('character', -1);
  range.select();
  return range;
}

function range_expand_next() {
  var range = frames['htmle'].document.selection.createRange().duplicate();
  range.expand(true);
  range.moveEnd('character', 1);
  range.select();
  return range;
}

function udateeditor_innerHTML() {
  document.getElementById('FileEditor').value = document.getElementById('htmle').contentWindow.document.body.innerHTML;
}

function udateframe_innerText() {
//  frames['htmle'].document.body.innerText = document.getElementById('FileEditor').value;
  document.getElementById('htmle').contentWindow.document.body.innerText = document.getElementById('FileEditor').value;
}

function refresh() {
  window.document.GoEditorJava.submit();
}

/*
  Retourne le document de l'editeur
*/
function getDoc(aID){
alert("getDoc");
	if (document.getElementById(aID).contentDocument){
		return document.getElementById(aID).contentDocument;
	} else {
		return document.frames[aID].document;
	}
}

/*
  Execute une commande dans l'editeur
*/
function EditCommand(cNom,cArg){
	document.getElementById('FileEditor').contentWindow.focus();
	getDoc('FileEditor').execCommand(cNom, false, cArg);
	document.getElementById('FileEditor').contentWindow.focus();
}

/*
	Function non utilisamp;eacute;
*/
function getFileNameFromURI(szFileName) {
	szFileName = szFileName.substring(6, szFileName.length);
	szFileName = replaceAll(szFileName, '/', '\\');
	return szFileName;
}

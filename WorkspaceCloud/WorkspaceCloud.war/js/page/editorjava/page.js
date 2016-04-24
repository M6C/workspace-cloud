function save() {
 document.forms['ValiderEditorJava'].navIndex.value = 1;
 javascript:onsumbitform();
 javascript:document.forms['ValiderEditorJava'].submit();
}
function init(autoComplete) {
//alert('init autoComplete:' + autoComplete)
  frames['htmle'].document.designMode='On';
  if (autoComplete==true) {
   createAutoComplete('htmle', 'classNameDiv', 'classNameAncre', 'classIdAncre');
  }
/*
 createAutoComplete('FileEditor', 'classNameDiv', 'classNameAncre', 'classIdAncre');
 document.getElementById('FileEditor').focus();
*/
}

function refresh() {
    window.document.GoEditorJava.submit();
}
/*
  Retourne le document de l'editeur
*/
function getDoc(aID){
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
function onClickTvDir(param, anchor) {
 //var szAfterReloadDir = "document.getElementById('treeviewDir').scrollTop = document.getElementById('"+anchor+"').offsetTop";
 var szAfterReloadDir = "afterClickTvDir('"+param+"', '"+anchor+"')";
 reloadDir('/Web/Component/TreeView/TreeViewDir_Border01.jsp', param, szAfterReloadDir);
 reloadFile('/Web/Component/TreeView/TreeViewFile_Border01.jsp', param);
 reloadMenu('/Web/Component/Menu/EditorJava/MenuHeader.jsp', param);
}
function afterClickTvDir(param, anchor) {
    document.getElementById('treeviewDir').scrollTop = document.getElementById(anchor).offsetTop;
}
function onClickTvFile(param, filename) {
 var szAfterReloadEditor = "reloadEditorNavBar('/Web/Component/Reload/Reload_Editor_NavBar_Border01.jsp', '"+param+"')";
 reloadEditor('/Web/Component/Reload/Reload_Editor_Border01.jsp', param, szAfterReloadEditor);
 reloadEditorFilename('/Web/Component/Reload/Reload_Editor_Filename_Border01.jsp', param);
 reloadMenu('/Web/Component/Menu/EditorJava/MenuHeader.jsp', param);
 document.forms["ValiderEditorJava"].navIndex.value = 0;
}
function onClickNavBar(param, index, nbRow, filename) {
 var iIndex = parseInt(index.substring(index.indexOf('=')+1,index.length));
 var iNavIndex = document.forms["ValiderEditorJava"].navIndex.value;
// alert("index:"+index+"iIndex:"+iIndex+"-iNavIndex:"+iNavIndex+"-nbRow:"+nbRow);
 var iNavNbRow = iIndex - iNavIndex + nbRow;
// alert("iNavNbRow:"+iNavNbRow);
 //var param1 = param + "&navIndex="+iIndex+"&navNbRow=50";
 var param1 = param + "&"+index+"&navNbRow=50";
// alert("param1:"+param1);
 var szAfterReloadEditor = "reloadEditorNavBar('/Web/Component/Reload/Reload_Editor_NavBar_Border01.jsp', '"+param1+"')";
// alert("szAfterReloadEditor:"+szAfterReloadEditor);
 if (iIndex>=iNavIndex) {
  var param2 = param + "&navIndex="+iNavIndex+"&navNbRow="+iNavNbRow;
  //var param2 = param + "&"+index+"&navNbRow="+iNavNbRow;
  reloadEditorAppend('/Web/Component/Reload/Reload_Editor_Append_Border01.jsp', param2, szAfterReloadEditor);
// alert("iIndex + nbRow:"+(iIndex + nbRow));
  document.forms["ValiderEditorJava"].navIndex.value = iIndex + nbRow;// - 1;
  document.forms["ValiderEditorJava"].navNbRow.value = iIndex + nbRow;
  updNumberLine(iNavNbRow);
 }
 else {
  eval(szAfterReloadEditor);
 }
}

function onClickNavBarNextPrev(param, index, nbRow) {
 //var param1 = param + "&navIndex="+index+"&navNbRow="+nbRow;
 var param1 = param + "&"+index+"&navNbRow="+nbRow;
 reloadEditorNavBar('/Web/Component/Reload/Reload_Editor_NavBar_Border01.jsp', param1);
}
function iniNumberLine() {
   var numline = document.getElementById("numberline").value;
   var text = frames['htmle'].document.body.innerText;
   if (text!='') {
    var split = text.split("\n");
    var len = split.length;
    numline = "";
    for (i=1 ; i<=len ; i++) {
       numline = numline + i + "\n";
    }
    numline = numline + "\n";
 
   document.getElementById("numberline").value = numline;
    document.getElementById("len").value = len;
    var tnum = "" + len;
    //resizeNumberLine(tnum.length);
   }
}
function updNumberLine(nbRow) {
   var numline = document.getElementById("numberline").value;
   var len = document.getElementById("len").value;
   if (len=='') len = 0;
   numline = numline.substring(0, (numline.length-2));
   for (i=1 ; i<=nbRow ; i++) {
     numline = numline + (++len) + "\n";
   }
   numline = numline + "\n";
   document.getElementById("numberline").value = numline;
   document.getElementById("len").value = len;
   var tnum = "" + len;
   //resizeNumberLine(tnum.length);
}
function resizeNumberLine(nbCar) {
   var w = (nbCar * 11) + "px";
   var numline = document.getElementById("numberline");
   numline.style.width=w;
}

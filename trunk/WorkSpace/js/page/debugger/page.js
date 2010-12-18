function init() {
  frames['htmle'].document.designMode='On';
  createAutoComplete('htmle', 'classNameDiv', 'classNameAncre', 'classIdAncre');
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

function onClickTvDir(param) {
	reloadDir('/Web/Component/TreeView/TreeViewDir_Border01.jsp', param);
	reloadFile('/Web/Component/TreeView/TreeViewFile_Border01.jsp', param);
	reloadMenu('/Web/Component/Menu/Debugger/MenuHeader.jsp', param);
}

function onClickTvFile(param, filename) {
//	window.location = 'action.servlet?event=DebuggerPage&' + param;
	reloadDebug('/Web/Component/Reload/Reload_Debug_Border01.jsp', param);
}

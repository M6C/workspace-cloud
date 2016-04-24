	function refresh() {
		window.document.GoEditorJava.submit();
	}

/*
  Retourne le document de l'editeur
*/
function getDocument(aID){
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
	getDocument('FileEditor').execCommand(cNom, false, cArg);
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
	reloadFile('/Web/Component/TreeView/TreeViewFileVersioning.jsp', param);
	reloadMenu('/Web/Component/Menu/FileBrowser/MenuHeader.jsp', param);
}

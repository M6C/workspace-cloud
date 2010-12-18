function refresh() {
	window.document.GoFileBrowser.submit();
}

function onClickTvDir(param, anchor) {
	//var szAfterReloadDir = "document.getElementById('treeviewDir').scrollTop = document.getElementById('"+anchor+"').offsetTop";
	var szAfterReloadDir = "afterClickTvDir('"+param+"', '"+anchor+"')";
	reloadDir('/Web/Component/TreeView/TreeViewDir_Border01.jsp', param, szAfterReloadDir);
	reloadFile('/Web/Component/TreeView/TreeViewFileExt_Border01.jsp', param);
	reloadMenu('/Web/Component/Menu/FileBrowser/MenuHeader.jsp', param);
}

function afterClickTvDir(param, anchor) {
    document.getElementById('treeviewDir').scrollTop = document.getElementById(anchor).offsetTop;
}

function refresh() {
	window.document.GoFileBrowser.submit();
}

function openWindow(url) {
  popupWin = window.open(url, 'zoom', 'scrollbars,resizable,dependent,width=840,height=650,top=1,left=1')
}

function onClickTvDir(param) {
	reloadDir('/Web/Component/TreeView/TreeViewDir_Border01.jsp', param);
	reloadFile('/Web/Component/TreeView/TreeViewImage_Border02.jsp', param);
	reloadMenu('/Web/Component/Menu/ImageViewer/MenuHeader.jsp', param);
}

function onClickTvFile(param) {
	reloadFile('/Web/Component/TreeView/TreeViewImage_Border02.jsp', param);
}

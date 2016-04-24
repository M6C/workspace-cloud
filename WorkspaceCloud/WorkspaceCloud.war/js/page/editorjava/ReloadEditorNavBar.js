
// The server-side script
var urlReloadEditorNavBar = ""//Pour Google App Engine"/WorkSpace";
var hHttp_ReloadEditorNavBar;

include_js("/js/HTTPObject.js")

function reloadEditorNavBar(urlPage, urlParam) {
  hHttp_ReloadEditorNavBar = getHTTPObject();
  sendToUrlPost(hHttp_ReloadEditorNavBar, urlReloadEditorNavBar + urlPage, urlParam, "handleHttpResponse_ReloadEditorNavBar");
}

function handleHttpResponse_ReloadEditorNavBar() {
//alert("handleHttpResponse_ReloadEditorNavBar: "+hHttp_ReloadEditorNavBar.readyState);
  switch (hHttp_ReloadEditorNavBar.readyState) {
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
      var txt = hHttp_ReloadEditorNavBar.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
	        var div = document.getElementById("reloadeditornavbar");
	        div.innerHTML = txt;
      }
      break;
    default:
      alert("handleHttpResponse_ReloadEditorNavBar hHttp_ReloadEditorNavBar.readyState: "+ac.hHttp_ReloadEditorNavBar.readyState);
  }
}

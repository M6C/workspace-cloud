
// The server-side script
var urlReloadEditorFilename = ""//Pour Google App Engine"/WorkSpace";
var hHttp_ReloadEditorFilename;

include_js("/js/HTTPObject.js")

function reloadEditorFilename(urlPage, urlParam) {
  hHttp_ReloadEditorFilename = getHTTPObject();
  sendToUrlPost(hHttp_ReloadEditorFilename, urlReloadEditorFilename + urlPage, urlParam, "handleHttpResponse_ReloadEditorFilename");
}

function handleHttpResponse_ReloadEditorFilename() {
//alert("handleHttpResponse_ReloadEditorFilename: "+hHttp_ReloadEditorFilename.readyState);
  switch (hHttp_ReloadEditorFilename.readyState) {
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
      var txt = hHttp_ReloadEditorFilename.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
	        var div = document.getElementById("reloadeditorfilename");
	        div.innerHTML = txt;
      }
      break;
    default:
      alert("handleHttpResponse_ReloadEditorFilename hHttp_ReloadEditorFilename.readyState: "+ac.hHttp_ReloadEditorFilename.readyState);
  }
}


// The server-side script
var urlReloadEditorAppend = ""//Pour Google App Engine"/WorkSpace";
var hHttp_ReloadEditorAppend;
var afterReloadEditorAppend;

include_js("/js/HTTPObject.js")

function reloadEditorAppend(urlPage, urlParam, szAfterReloadEditorAppend) {
  afterReloadEditorAppend = szAfterReloadEditorAppend;
  hHttp_ReloadEditorAppend = getHTTPObject();
  sendToUrlPost(hHttp_ReloadEditorAppend, urlReloadEditorAppend + urlPage, urlParam, "handleHttpResponse_ReloadEditorAppend");
}

function handleHttpResponse_ReloadEditorAppend() {
//alert("handleHttpResponse_ReloadEditorAppend: "+hHttp_ReloadEditorAppend.readyState);
  switch (hHttp_ReloadEditorAppend.readyState) {
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
      var txt = hHttp_ReloadEditorAppend.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
      	eval(txt)
        if ((afterReloadEditorAppend!=null) && (afterReloadEditorAppend!="") && (afterReloadEditorAppend!="undefined"))
	        eval(afterReloadEditorAppend);
      }
      break;
    default:
      alert("handleHttpResponse_ReloadEditorAppend hHttp_ReloadEditorAppend.readyState: "+ac.hHttp_ReloadEditorAppend.readyState);
  }
}

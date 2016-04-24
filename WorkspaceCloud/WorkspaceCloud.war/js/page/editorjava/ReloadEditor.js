
// The server-side script
var urlReloadEditor = ""//Pour Google App Engine"/WorkSpace";
var hHttp_ReloadEditor;
var afterReloadEditor;

include_js("/js/HTTPObject.js")

function reloadEditor(urlPage, urlParam, szAfterReloadEditor) {
  afterReloadEditor = szAfterReloadEditor;
  hHttp_ReloadEditor = getHTTPObject();
  sendToUrlPost(hHttp_ReloadEditor, urlReloadEditor + urlPage, urlParam, "handleHttpResponse_ReloadEditor");
}

function handleHttpResponse_ReloadEditor() {
//alert("handleHttpResponse_ReloadEditor: "+hHttp_ReloadEditor.readyState);
  switch (hHttp_ReloadEditor.readyState) {
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
      var txt = hHttp_ReloadEditor.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
      	eval(txt)
        if ((afterReloadEditor!=null) && (afterReloadEditor!="") && (afterReloadEditor!="undefined"))
	        eval(afterReloadEditor);
//	        var div = document.getElementById("reloadeditor");
//	        div.innerHTML = txt;
      }
      break;
    default:
      alert("handleHttpResponse_ReloadEditor hHttp_ReloadEditor.readyState: "+ac.hHttp_ReloadEditor.readyState);
  }
}

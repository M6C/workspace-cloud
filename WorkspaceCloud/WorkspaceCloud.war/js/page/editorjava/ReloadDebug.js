
// The server-side script
var urlReloadDebug = ""//Pour Google App Engine"/WorkSpace";
var hHttp_ReloadDebug;

include_js("/js/HTTPObject.js")

function reloadDebug(urlPage, urlParam) {
//alert("reloadDebug: '"+urlPage+"' '"+urlParam+"'");
  hHttp_ReloadDebug = getHTTPObject();
  sendToUrlPost(hHttp_ReloadDebug, urlReloadDebug + urlPage, urlParam, "handleHttpResponse_ReloadDebug");
}

function handleHttpResponse_ReloadDebug() {
//alert("handleHttpResponse_ReloadDebug: "+hHttp_ReloadDebug.readyState);
  switch (hHttp_ReloadDebug.readyState) {
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
      var txt = hHttp_ReloadDebug.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
        eval(txt);
//        var div = document.getElementById("reloaddebug");
//        div.innerHTML = txt;
      }
      break;
    default:
      alert("handleHttpResponse_ReloadDebug hHttp_ReloadDebug.readyState: "+ac.hHttp_ReloadDebug.readyState);
  }
}

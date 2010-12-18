
// The server-side script
var urlReloadFile = "/WorkSpace";
var hHttp_ReloadFile;

include_js("/WorkSpace/js/HTTPObject.js")

function reloadFile(urlPage, urlParam) {
  hHttp_ReloadFile = getHTTPObject();
  sendToUrlPost(hHttp_ReloadFile, urlReloadFile + urlPage, urlParam, "handleHttpResponse_ReloadFile");
}

function handleHttpResponse_ReloadFile() {
//alert("handleHttpResponse_ReloadFile: "+hHttp_ReloadFile.readyState);
  switch (hHttp_ReloadFile.readyState) {
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
      var txt = hHttp_ReloadFile.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
	        var div = document.getElementById("reloadfile");
	        div.innerHTML = txt;
      }
      break;
    default:
      alert("handleHttpResponse_ReloadFile hHttp_ReloadFile.readyState: "+ac.hHttp_ReloadFile.readyState);
  }
}

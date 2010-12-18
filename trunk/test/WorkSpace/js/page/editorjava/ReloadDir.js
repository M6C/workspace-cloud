
// The server-side script
var urlReloadDir = "/WorkSpace";
var hHttp_ReloadDir;
var afterReloadDir;

include_js("/WorkSpace/js/HTTPObject.js")

function reloadDir(urlPage, urlParam, szAfterReloadDir) {
  afterReloadDir = szAfterReloadDir;
  hHttp_ReloadDir = getHTTPObject();
  sendToUrlPost(hHttp_ReloadDir, urlReloadDir + urlPage, urlParam, "handleHttpResponse_ReloadDir");
}

function handleHttpResponse_ReloadDir() {
//alert("handleHttpResponse_ReloadFile: "+hHttp_ReloadDir.readyState);
  switch (hHttp_ReloadDir.readyState) {
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
      var txt = hHttp_ReloadDir.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
	        var div = document.getElementById("reloaddir");
	        //alert(txt.substring(txt.length-1000, txt.length-250));
	        div.innerHTML = txt;
	        if ((afterReloadDir!=null) && (afterReloadDir!="") && (afterReloadDir!="undefined"))
		        eval(afterReloadDir);
      }
      break;
    default:
      alert("handleHttpResponse_ReloadFile hHttp_ReloadDir.readyState: "+ac.hHttp_ReloadDir.readyState);
  }
}

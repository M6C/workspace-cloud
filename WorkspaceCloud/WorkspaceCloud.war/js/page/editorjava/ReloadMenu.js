
// The server-side script
var urlReloadMenu = ""//Pour Google App Engine"/WorkSpace";
var hHttp_ReloadMenu;

include_js("/js/HTTPObject.js")

function reloadMenu(urlPage, urlParam) {
  hHttp_ReloadMenu = getHTTPObject();
  sendToUrlPost(hHttp_ReloadMenu, urlReloadMenu + urlPage, urlParam, "handleHttpResponse_ReloadMenu");
}

function handleHttpResponse_ReloadMenu() {
//alert("handleHttpResponse_ReloadFile: "+hHttp_ReloadMenu.readyState);
  switch (hHttp_ReloadMenu.readyState) {
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
      var txt = hHttp_ReloadMenu.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
	        var div = document.getElementById("reloadmenu");
	        div.innerHTML = txt;
      }
      break;
    default:
      alert("handleHttpResponse_ReloadFile hHttp_ReloadMenu.readyState: "+ac.hHttp_ReloadMenu.readyState);
  }
}

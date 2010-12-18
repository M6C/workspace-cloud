// The server-side script
var urlMousePress = "/WorkSpace/ActionMouseEvent";
var hHttp_ReloadMouseClick;

include_js("/WorkSpace/js/HTTPObject.js")

function getMouseDown(e) {
  reloadMouseClick(e, "CLICK") ;
}

function getMousePress(e) {
  reloadMouseClick(e, "PRESS") ;
}

function getMouseRelease(e) {
  reloadMouseClick(e, "RELEASE") ;
}

function reloadMouseClick(e, event, param) {
//alert('reloadMouseClick event:'+event);
  var targetXReal = (isNS?e.pageX:e.x);
  var targetYReal = (isNS?e.pageY:e.y);
//alert('targetXReal:'+targetXReal+'targetYReal:'+targetYReal);
  var targetX = targetXReal - getLeft(document.getElementById('imageScreen'));
  var targetY = targetYReal - getTop(document.getElementById('imageScreen'));
//alert('targetX:'+targetX+'targetY:'+targetY);
  var button = document.getElementById('button').value;
  var nbClick = document.getElementById('nbClick').value;
  var urlParam = 'x=' + targetXReal + '&y=' + targetYReal;
  urlParam = urlParam + '&button=' + button + '&nbClick=' + nbClick;
window.document.title = 'reloadMouseClick urlParam:'+urlParam;
  reloadMouse(e, event, urlParam);

  var refreshonclick = document.getElementById('refreshonclick').value;
  alert('refreshonclick:'+refreshonclick);
  if (refreshonclick == '1') {
    refresh();
  }
}

function reloadMouse(e, event, param) {
//alert('reloadMouse event:'+event);
  var button = document.getElementById('button').value;
  var nbClick = document.getElementById('nbClick').value;
  var urlParam = 'button=' + button + '&nbClick=' + nbClick;
  if (event!='') urlParam = urlParam + '&event=' + event;
  if (param!='') urlParam = urlParam + '&' + param;
window.document.title = 'reloadMouse urlParam:'+urlParam;
  hHttp_ReloadMouseClick = getHTTPObject();
  sendToUrlGet(hHttp_ReloadMouseClick, urlMousePress, urlParam, "handleHttpResponse_reloadMouseClick");
}
function handleHttpResponse_reloadMouseClick() {
//alert("handleHttpResponse_reloadMouseClick: "+hHttp_ReloadMouseClick.readyState);
  switch (hHttp_ReloadMouseClick.readyState) {
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
      break;
    default:
      alert("handleHttpResponse_reloadMouseClick hHttp_ReloadMouseClick.readyState: "+ac.hHttp_ReloadMouseClick.readyState);
  }
}

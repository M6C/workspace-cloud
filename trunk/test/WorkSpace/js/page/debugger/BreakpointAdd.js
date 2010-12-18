// The server-side script
var url = "/WorkSpace/action.servlet";
var oHttp;

function setBreakpoint(pApplication, pPath, pClass, pFileName, pLine) {
//alert("setBreakpoint");
	oHttp = getHTTPObject();
  var urlParam = "event=DebuggerBreakpointAdd&application=" + escape(pApplication) + "&pathToExpand=" + escape(pPath) + "&FileName=" + escape(pFileName) + "&breakpointClass=" + escape(pClass) + "&breakpointLine=" + pLine;
  sendToUrlPost(oHttp, url, urlParam, "handleHttpResponse_BreakpointAdd");
}

function handleHttpResponse_BreakpointAdd() {
//alert("handleHttpResponse_BreakpointAdd: "+oHttp.readyState);
  switch (oHttp.readyState) {
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
      var txt = oHttp.responseText;
      if ((txt!=null) && (txt!="") && (txt != "undefined")) {
	      var tmp = txt.split(":");
	      if ((typeof(tmp[0]) != "undefined")&&(tmp.length==3)) {
	        var file = tmp[0];
	        var line = tmp[1];
	        var text = tmp[2];
	        showBreakpoint(line, text);
	        //Declanche la verification des breakpoints
	        //Start_BreakpointCheck();
	      }
	      else {
	        var div = document.getElementById("text");
//	        div.innerHTML = txt;
	        div.innerText = txt;
	      }
      }
      break;
    default:
      alert("handleHttpResponse_BreakpointAdd oHttp.readyState: "+ac.oHttp.readyState);
  }
}

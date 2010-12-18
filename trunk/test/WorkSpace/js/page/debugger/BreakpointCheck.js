var timerID = 0;

function BreakpointCheck() {
//alert("setBreakpoint");
	oHttp = getHTTPObject();
  // Suppression des \n
  //txt = txt.replace(/\n|\n/g, "");
  var urlParam = "event=DebuggerBreakpointCheck";
  sendToUrlPost(oHttp, url, urlParam, "handleHttpResponse_BreakpointCheck");
}

//-->
// The server-side script
var url = "/WorkSpace/action.servlet";
var oHttp;

function handleHttpResponse_BreakpointCheck() {
//alert("handleHttpResponse_BreakpointCheck: "+oHttp.readyState);
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
	      if ((typeof(tmp[0]) != "undefined")&&(tmp.length==4)) {
	        var application = tmp[0];
	        var path = unescape(tmp[1]);
	        var file = unescape(tmp[2]);
	        var line = unescape(tmp[3]);
	        var url = "/WorkSpace/action.servlet?event=DebuggerPage&application="+application+"&pathToExpand="+path+"&FileName=/"+file+"&line="+line;
	        url += "#line"+line;
	        document.location = url;
      		//Stop_BreakpointCheck();
	      }
      }
      break;
    default:
      alert("handleHttpResponse_BreakpointCheck oHttp.readyState: "+ac.oHttp.readyState);
  }
}

function Update_BreakpointCheck() {
   if(timerID) {
      clearTimeout(timerID);
   }
   
   BreakpointCheck();

   timerID = setTimeout("Update_BreakpointCheck()", 10000);
}

function Start_BreakpointCheck() {
//alert("Start_BreakpointCheck timerID:" + timerID + " (timerID==0):" + (timerID==0));
	 if (timerID==0) {
	    timerID  = setTimeout("Update_BreakpointCheck()", 10000);
   }
}

function Stop_BreakpointCheck() {
//alert("Stop_BreakpointCheck timerID:" + timerID + " (timerID==0):" + (timerID==0));
   if(timerID) {
      clearTimeout(timerID);
   }
   timerID=0;
}

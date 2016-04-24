//-->
// The server-side script
var url = "/action.servlet";
var oHttp;

function handleHttpResponse_BreakpointResume() {
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
	      if (typeof(tmp[0]) != "undefined") {
	        if (tmp[0]=='resume') {
	        	cleanId();
		        //Demarre la verification des breakpoints
			      Start_BreakpointCheck();;
	        }
	      }
      }
      break;
    default:
      alert("handleHttpResponse_BreakpointCheck oHttp.readyState: "+ac.oHttp.readyState);
  }
}

function BreakpointResume() {
//alert("BreakpointResume");
	oHttp = getHTTPObject();
  // Suppression des \n
  //txt = txt.replace(/\n|\n/g, "");
  var urlParam = "event=DebuggerBreakpointResume";
  sendToUrlPost(oHttp, url, urlParam, "handleHttpResponse_BreakpointResume");
}

function cleanId() {
    var div = document.getElementById("text");
    var table = div.getElementsByTagName("table");
    var tr = div.getElementsByTagName("tr");
    var trSize = tr.length;
    var i;
    for(i=0 ; i<trSize ; i++) {
    	var td = tr[i].getElementsByTagName("td");
    	td[1].id = "";
    }
}

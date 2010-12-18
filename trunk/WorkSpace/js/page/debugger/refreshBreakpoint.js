var timerID = 0;

function Update() {
   if(timerID) {
      clearTimeout(timerID);
   }

   timerID = setTimeout("Update()", 1000);
}

function Start() {
   timerID  = setTimeout("Update()", 1000);
}

function Stop() {
   if(timerID) {
      clearTimeout(timerID);
      timerID  = 0;
   }
}

//-->
// The server-side script
var url = "/WorkSpace/action.servlet";
var oHttp;

function handleHttpResponse() {
//alert("handleHttpResponse: "+oHttp.readyState);
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
      var tmp = oHttp.responseText.split(":");
      if ((typeof(tmp[0]) != "undefined")&&(tmp.length==3)) {
        var file = tmp[0];
        var line = tmp[1];
        var text = tmp[2];
        var div = document.getElementById("text");
        var table = div.getElementsByTagName("table");
        var tr = div.getElementsByTagName("tr")[line];
        var td = tr.getElementsByTagName("td")[0];
        td.id = (text=="added") ? "breakpoint" : "";
      }
      break;
    default:
      alert("handleHttpResponse oHttp.readyState: "+ac.oHttp.readyState);
  }
}

function setBreakpoint(pClass, pLine) {
//alert("setBreakpoint");
	oHttp = getHTTPObject();
  // Suppression des \n
  //txt = txt.replace(/\n|\n/g, "");
  var urlParam = "event=DebuggerBreakpointAdd&class=" + escape(pClass) + "&line=" + pLine;
  var method   = "POST";//"GET";
  if(method == "GET") {
    oHttp.open(method, url + "&" + urlParam, true);
    oHttp.onreadystatechange = handleHttpResponse;
    oHttp.send(null);
  }
  else { // POST
    oHttp.open(method, url, true);
    oHttp.onreadystatechange = handleHttpResponse;
    oHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    oHttp.send(urlParam);
  }

  // Damp;eacute;cramp;eacute;mente le nombre de retour chario du nombre de caract?res
  var posOrig = pos;
  for(var i=0;i<posOrig;i++) {
    if (txt.charAt(i)=="\r")
      pos--;
  }
}

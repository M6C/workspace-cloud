/*
	Completion

Affichage des methodes d'une classe parte une alerte
*/
var url = "/WorkSpace/action.servlet?event=EditorJavaCompletion&"; // The server-side script
var http = getHTTPObject(); // We create the HTTP Object
function showCompletion() {
  var className = document.getElementById("className").value;
  var method   = "GET";//"POST";
  http.open(method, url + "className=" + escape(className), true);
  http.onreadystatechange = handleHttpResponse;
  http.send(null);
  if(method == "POST")
    http.setRequestHeader("Content-type", "application/x-www-form-urlencoded");

}

function handleHttpResponse() {
  if (http.readyState == 4) {
    var tmp = http.responseText.split(":");
    if(typeof(tmp[1]) != "undefined") {
      var sz = "";
      var size = tmp.length;
      for(var i=0 ; i<size ; i++) {
        sz += tmp[i] + "\r\n";
      }
      alert(sz);
    }
  }
}

function getHTTPObject() {
  var xhr_object = null;
  if(window.XMLHttpRequest) // Firefox
    xhr_object = new XMLHttpRequest();
  else if(window.ActiveXObject) // Internet Explorer
    xhr_object = new ActiveXObject("Microsoft.XMLHTTP");
  else { // XMLHttpRequest non supporté par le navigateur
    alert("You do not support XMLHTTPRequest objet");
    return;
  }
  return xhr_object;
}

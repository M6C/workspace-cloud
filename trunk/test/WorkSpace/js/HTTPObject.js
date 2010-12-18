function getHTTPObject() {
//alert("getHTTPObject");
  var xhr_object = null;
  if(window.XMLHttpRequest) // Firefox
    xhr_object = new XMLHttpRequest();
  else if(window.ActiveXObject) { // Internet Explorer
      try {
        xhr_object = new ActiveXObject("Msxml2.XMLHTTP");
      } catch (E) {
        xhr_object = new ActiveXObject("Microsoft.XMLHTTP");
      }
  } else { // XMLHttpRequest non supportamp;eacute; par le navigateur
    //alert("You do not support XMLHTTPRequest objet");
    return;
  }
  return xhr_object;
}

function sendToUrlPost(oHttp, url, urlParam, handleMethod) {
//alert("sendToUrlPost url:" + url + " urlParam:" + urlParam + " handleMethod:" + handleMethod);
  oHttp.open("POST", url + "?" + urlParam, true);
  oHttp.onreadystatechange = eval(handleMethod);
  oHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
  oHttp.send(urlParam);
}

function sendToUrlGet(oHttp, url, urlParam, handleMethod) {
//alert("sendToUrlPost url:" + url + " urlParam:" + urlParam + " handleMethod:" + handleMethod);
  //oHttp.open(method, url + "&" + urlParam, true);
  oHttp.open("GET", url + "?" + urlParam, true);
  oHttp.onreadystatechange = eval(handleMethod);
  oHttp.send(null);
}

function sendToUrl(oHttp, url, urlParam, handleMethod, method) {
//alert("sendToUrl url:" + url + " urlParam:" + urlParam + " handleMethod:" + handleMethod);
  //var method   = "POST";//"GET";
  if(method == "GET") {
    //oHttp.open(method, url + "&" + urlParam, true);
    oHttp.open(method, url + "?" + urlParam, true);
    oHttp.onreadystatechange = eval(handleMethod);
    oHttp.send(null);
  }
  else { // POST
//alert("sendToUrl url:" + url + "?" + urlParam);
    oHttp.open(method, url + "?" + urlParam, true);
    oHttp.onreadystatechange = eval(handleMethod);
    oHttp.setRequestHeader("Content-type", "application/x-www-form-urlencoded");
    oHttp.send(urlParam);
  }
}

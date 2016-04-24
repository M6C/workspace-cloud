//var sURL = unescape(window.location.pathname);
var sURL = 'action.servlet?event=AdminPageScreenShoot'

function refresh() {
    //var img = document.getElementById('imageScreen');
    var img = document.getElementById('idImageScreen');
    var sec = document.getElementById('refreshSec').value;
    var qualityRate = document.getElementById('refreshqualityRate').value;
    var refreshonclick = document.getElementById('refreshonclick').value;

    if (qualityRate == 0 || qualityRate == '' || qualityRate  == 'NaN' || qualityRate == undefined) {
      qualityRate  = 25;
      document.getElementById('qualityRate').value = qualityRate;
    }
    var url = "/Actionscreenshoot";
//    var param = "qualityRate=" + qualityRate + "&screenHeight=" + img.height + "&screenWidth=" + img.width + "&time=" + new Date().getTime();
    var param = "qualityRate=" + qualityRate;
    var param = param + "&screenHeight=" + img.offsetHeight + "&screenWidth=" + img.offsetWidth
    var param = param + "&time=" + new Date().getTime();
    var src = url + '?' + param;
    var idImageScreen = "<img width='100%' height='100%' id='imageScreen' src='" + src + "'>";// onmousemove='javascript:getMousePosition()' onmousedown='javascript:getMouseDown()'>"
    window.document.title = 'refresh: param:' + param;
    
    SetDivIdContent("idImageScreen", idImageScreen);
    // the timeout value should be the same as in the "refresh" meta-tag
    if (sec!=0 && sec!='' && sec!='NaN' && sec!=undefined) {
      sec = sec * 1000;
      setTimeout( "refresh()", sec);
    }
      
    //  This version of the refresh function will cause a new
    //  entry in the visitor's history.  It is provided for
    //  those browsers that only support JavaScript 1.0.
    //
    //window.location.href = sURL;
}

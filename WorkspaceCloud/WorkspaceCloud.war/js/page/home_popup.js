
function CloseWindow(href) {
/*
    var winX = (document.all)?window.screenLeft:window.screenX;
    var winY = (document.all)?window.screenTop:window.screenY;
    var obj_window = openPopup('action.servlet?event=Home', '', document.body.clientWidth, document.body.clientHeight, null, 'status=1, resizable=yes, screenX='+window.event.screenX+',screenY='+window.event.screenY+',Left='+winX+',Top='+winY);
*/
    var obj_window = openPopupRet('action.servlet?event=Home', '', screen.width*0.90 , screen.height*0.75, null, 'status=1, resizable=yes, _self');
    obj_window.opener = window;
    //obj_window.focus();
    opener=self;
    self.close();
}

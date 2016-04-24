function openPopupRet(url,name,width, height, timeOut, parameters)
{
  var tmpWindow
  /*
  width: window width size
  height: window height size
  timeOut: close window after 'timeOut' secondes.
  parameters: reste des parametres (commence obligatoirement par ",")
  */
  if (name == null) name="s4f";
  if (width == null) width=460;
  if (height == null) height = 360;

  if (parameters == null)
//    parameters =",toolbar=0,location=0,directories=0,status=0,menubar=0, scrollbars=0, resizable=no"
    parameters =",toolbar=0,location=0,directories=0,status=0,menubar=0, scrollbars=1, resizable=yes";
  else
    parameters = "," + parameters;

  var top, top2, left;
  top = (screen.height - height)/2;
  top2 = -1;
  left = (screen.width - width)/2;
  tmpWindow = window.open(url,name,'width=' + width + ',height=' + height +',screenX=' + left +',screenY=' + top2 + ',Left=' + left + ',Top=' + top + parameters);

  if (timeOut !=null)
    setTimeout('tmpWindow.close()',timeOut*1000);
  tmpWindow.focus();
  return tmpWindow;
}

function openPopup(url,name,width, height, timeOut, parameters)
{
  var tmpWindow = openPopupRet(url,name,width, height, timeOut, parameters);
}

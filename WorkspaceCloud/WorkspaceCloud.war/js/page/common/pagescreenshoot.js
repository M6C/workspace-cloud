var isNS = document.layers?true:false;
var isIE = document.all?true:false;
var isDOM = (document.getElementById)? true:false;   //NS 6 ou IE 5 
function getLeft(obj) {
//Fonction permettant de conna?tre la position d'un objet
//par rapport au bord gauche de la page.
//Cet objet peut ?tre ? l'intamp;eacute;rieur d'un autre objet.
    var curleft = 0;
    if (obj.offsetParent)
    {
        while (obj.offsetParent)
        {
            curleft += obj.offsetLeft
            obj = obj.offsetParent;
        }
    }
    else if (obj.x)
        curleft += obj.x;
    return curleft;
}
function getTop(obj)
//Fonction permettant de conna?tre la position d'un objet
//par rapport au bord haut de la page.
//Cet objet peut ?tre ? l'intamp;eacute;rieur d'un autre objet.
    {
    var curtop = 0;
    if (obj.offsetParent)
    {
        while (obj.offsetParent)
        {
            curtop += obj.offsetTop
            obj = obj.offsetParent;
        }
    }
    else if (obj.y)
        curtop += obj.y;
    return curtop;
 }
 
function SetDivIdContent(ID,Content) {
   //document.title = 'SetDivIdContent: [ID:' + ID + ', Content:' + Content + ']';
   if (isDOM) {
   document.getElementById(ID).innerHTML = Content;
      return;
   }
   if (isIE) {
       document.all[ID].innerHTML = Content;
      return;
   }
   if (isNS) {
       with (eval('document.'+ID+'.document')) {
          open();
          write(Content);
          close();
      }
      return;
   }
}

// retourne vrai si le dernier clic de souris concerne le bouton droit
function boutonDroit(e) {
  if (window.event)
    return (window.event.button==2);
  else
    return (e.which==3);
} // fin boutonDroit(e)

// retourne vrai si le dernier clic de souris concerne le bouton gauche
function boutonGauche(e) {
  if (window.event)
    return (window.event.button==1);
  else {
    if (e.type=="mousemove")
      return (false);
    else
      return (e.which==1);
  }
} // fin boutonGauche(e)

// retourne vrai si le dernier clic de souris concerne le bouton du milieu
function boutonMilieu(e) {
  if (window.event)
    return ((window.event.button==3) || (window.event.button==4));
  else
    return (e.which==2);
} // fin boutonMilieu(e)

// retourne la position horizontale a l'ecran du pointeur de la souris
function pointeurEcranX(e) {
  if (window.event)
    return (window.event.screenX);
  else
    return(e.screenX);
} // fin pointeurEcranX(e)

// retourne la position verticale a l'ecran du pointeur de la souris
function pointeurEcranY(e) {
  if (window.event)
    return (window.event.screenY);
  else
    return(e.screenY);
} // fin pointeurEcranY(e)

// retourne la position horizontale sur la page du pointeur de la souris
function pointeurX(e) {
  var ret;
  if (window.event)
    ret = (window.event.clientX);
  else
    ret =(e.pageX);
  ret = ret - getLeft(document.getElementById('idImageScreen'));
  return ret;
} // fin pointeurX(e)

// retourne la position verticale sur la page du pointeur de la souris
function pointeurY(e) {
  var ret;
  if (window.event)
    ret = (window.event.clientY);
  else
    ret = (e.pageY);
  ret = ret - getTop(document.getElementById('idImageScreen'));
  return ret;
} // fin pointeurY(e)

function pointeurDeplace(e) {
//  document.f1.r1[0].checked = true;
//  majFormulaire(e);
  majServeurMove(e);
}
function boutonEnfonce(e) {
//  document.f1.r1[1].checked = true;
//  majFormulaire(e);
  majServeurClick(e);
}
function boutonRelache(e) {
//  document.f1.r1[2].checked = true;
//  majFormulaire(e);
//  majServeur(e);
}
function majFormulaire(e) {
  document.f1.t1.value = pointeurX(e);
  document.f1.t2.value = pointeurY(e);
  document.f1.t3.value = pointeurEcranX(e);
  document.f1.t4.value = pointeurEcranY(e);
  document.f1.c1.checked = boutonGauche(e);
  document.f1.c2.checked = boutonMilieu(e);
  document.f1.c3.checked = boutonDroit(e);
}

function toucheEnfonce(e) {
  capsLock(e);
}

function majServeurMove(e) {
  var img = document.getElementById('idImageScreen');
  var param = 'x=' + pointeurX(e) + '&y=' + pointeurY(e);
  var param = param + "&screenHeight=" + img.offsetHeight + "&screenWidth=" + img.offsetWidth
  reloadMouse(e, '', param);
}

function majServeurClick(e) {
  var img = document.getElementById('idImageScreen');
  var param = 'x=' + pointeurX(e) + '&y=' + pointeurY(e);
  var param = param + "&screenHeight=" + img.offsetHeight + "&screenWidth=" + img.offsetWidth
  reloadMouse(e, 'CLICK1', param);
}

function initScreenShoot() {
//document.onmousemove = pointeurDeplace;
document.getElementById('idImageScreen').onmousemove = pointeurDeplace;
//document.onmousedown = boutonEnfonce;
document.getElementById('idImageScreen').onmousedown = boutonEnfonce;
//document.onmouseup = boutonRelache;
document.getElementById('idImageScreen').onmouseup = boutonRelache;

document.getElementById('idImageScreen').onKeyDown = toucheEnfonce;
document.getElementById('idImageScreen').onKeyUp = toucheEnfonce;
document.getElementById('idImageScreen').onKeyPress = toucheEnfonce;
}
function capsLock(e) {
alert(1);
/*
 kc = e.keyCode?e.keyCode:e.which;
 sk = e.shiftKey?e.shiftKey:((kc == 16)?true:false);
 if(((kc >= 65 && kc <= 90) && !sk)||((kc >= 97 && kc <= 122) && sk)) {
  document.getElementById('divCapsLockOn').style.visibility = 'visible';
  document.getElementById('divCapsLockOff').style.visibility = 'hidden';
 }
 else {
  document.getElementById('divCapsLockOn').style.visibility = 'hidden';
  document.getElementById('divCapsLockOff').style.visibility = 'visible';
 }
*/
}

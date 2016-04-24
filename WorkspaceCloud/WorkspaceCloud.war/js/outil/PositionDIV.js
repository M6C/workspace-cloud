<SCRIPT>
<!--
var ns4 = (document.layers)? true:false;   //NS 4
var ie4 = (document.all)? true:false;   //IE 4
var dom = (document.getElementById)? true:false;   //DOM

//Fonction permettant de positionner un DIV à une position occupée par une ancre
function setToAnchor(ID_Anchor,Name_Anchor,ID_Div)
{
  var DivLeft = 0;   //Position du Div par rapport au côté gauche de la page
  var DivTop = 0;   //Position du Div par rapport au haut de la page

  if (dom)
  {
    pos = document.getElementById(ID_Anchor);
    DivLeft = getLeft(pos);
    DivTop = getTop(pos);
    document.getElementById(ID_Div).style.left = DivLeft;
    document.getElementById(ID_Div).style.top = DivTop;
  }
  else if (ie4)
  {
    pos = document.all[ID_Anchor];
    DivLeft = getLeft(pos);
    DivTop = getTop(pos);
    document.all[ID_Div].style.posLeft = DivLeft;
    document.all[ID_Div].style.posTop = DivTop;
  }
  else if (ns4)
  {
    pos = document.anchors[Name_Anchor];
    DivLeft = pos.x;
    DivTop = pos.y;
    document.layers[ID_Div].pageX = DivLeft;
    document.layers[ID_Div].pageY = DivTop;
  }
}
//-->
</SCRIPT>
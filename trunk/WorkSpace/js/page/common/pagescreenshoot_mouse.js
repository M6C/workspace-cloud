var X=0;
var Y=1;
var windowBuffer=50;
var yMAX=(isNS?innerHeight:300) - windowBuffer;
var xMAX=(isNS?innerWidth:300)  - windowBuffer;
var yMIN=windowBuffer;
var xMIN=windowBuffer;
var smiles = new Array();
var smilesId = new Array();
var smileCnt = 0;
var imageCnt = 0;
var targetX = parseInt(Math.random()*xMAX) + xMIN;
var targetY = parseInt(Math.random()*yMAX) + yMIN;
var targetXReal = parseInt(Math.random()*xMAX) + xMIN;
var targetYReal = parseInt(Math.random()*yMAX) + yMIN;
var smileWidth=50;
var smileHeight=50;
var circleRadius = 50;
var smileRunning = false;
var mT= null;
var mD=40;

function addSmile(pSmileId) {
    smiles[smileCnt] = isNS?document.layers[pSmileId]:document.all[pSmileId].style;
    smilesId[smileCnt] = pSmileId;
    smileCnt++;
}

function moveIt() {
window.opener.document.title = 'moveIt: [targetX:' + targetX + ', targetY:' + targetY + '] [targetXReal:' + targetXReal + ', targetYReal:' + targetYReal + ']';
  if (!smileRunning) {
    smileRunning = true;
    for(i in smiles) {
      var img = (isIE?document.all['image1']:document.getElementById('image1'));
      var imgW = (img?img.width/2:0);
      var imgH = (img?img.height/2:0);
      var imageSrc = '/WorkSpace/Actionscreenshoot';
      imageSrc = imageSrc + '?qualityRate=25&width=50&height=50&screenWidth=800&screenHeight=600';
      imageSrc = imageSrc + '&x=' + targetX + '&y=' + targetY;
      imageSrc = imageSrc + '&mousex=' + targetX + '&mousey=' + targetY; 
      SetDivIdContent(smilesId[i], '<img border=0 id=image1 src='+imageSrc+'>');
      if (isNS) {
        smiles[i].x=targetXReal - (smileWidth/2);
        smiles[i].y=targetYReal - (smileHeight/2);
//document.title = 'moveIt: [smiles[i].x:' + smiles[i].x + ', smiles[i].y:' + smiles[i].y + '] [targetX:' + targetX + ', targetY:' + targetY + ']';
//document.title = 'moveIt: [targetX:' + targetX + ', targetY:' + targetY + '] [img.width:' + img.width + ', img.height:' + img.height + ']';
      }
      if (isIE) {
        smiles[i].posLeft=targetXReal - (smileWidth/2);
        smiles[i].posLeft=targetXReal - (smileWidth/2);
        smiles[i].posTop=targetYReal - (smileHeight/2);
//document.title = 'moveIt: [smil es[i].posLeft:' + smiles[i].posLeft + ', smiles[i].posTop:' + smiles[i].posTop + '] [targetX:' + targetX + ', targetY:' + targetY + ']';
//document.title = 'moveIt: [targetX:' + targetX + ', targetY:' + targetY + '] [img.width:' + img.width + ', img.height:' + img.height + ']';
      }
    }
    smileRunning = false;
  }
}

moveIt();
//if (isNS) document.captureEvents(Event.MOUSEMOVE);
//document.onmousemove=getMousePosition;

//if (isNS) document.smile1.document.captureEvents(Event.MOUSEMOVE);
//document.getElementById('smile1').onmousemove=getMousePosition;

function getMousePosition(e) {
//  targetX = (isNS?e.pageX:event.x) - Math.round(circleRadius / 2 / 2);
//  targetY = (isNS?e.pageY:event.y) - Math.round(circleRadius / 2 / 2);
//  if (!smileRunning) {moveIt();}
//window.opener.document.title = 'getMousePosition: [targetX:' + targetX + ', targetY:' + targetY + '] [targetXReal:' + targetXReal + ', targetYReal:' + targetYReal + ']';
  targetXReal = (isNS?e.pageX:event.x);// - (smileWidth/2);
  targetYReal = (isNS?e.pageY:event.y);// - (smileHeight/2);
  targetX = targetXReal - getLeft(document.getElementById('imageScreen'));// - (smileWidth/2);
  targetY = targetYReal - getTop(document.getElementById('imageScreen'));// - (smileHeight/2);
  moveIt();
//document.title = 'getMousePosition: [targetX:' + targetX + ', targetY:' + targetY + ']';
}

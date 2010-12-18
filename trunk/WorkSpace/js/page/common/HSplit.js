var nameFrame = 'htmle';//rFrame
var nameDiv = 'rDiv';//rDiv
var nameData = 'lData';//lData
var nameData1 = 'rData1';//rData1
var nameData2 = 'rData2';//rData2
var nameStep = 'lSep';//lSep
  // Copyright 2000-2006 (c) Exalead S.A. All rights reserved.
  // Copying or reverse-engineering this code strictly prohitibited.
  var bCur = -1;
  var bSel = -1;
  var bHilited = -1;
  var bCount = -1;
  var bVis = 0;
  var bObj = null;
  var bRegexp = '';
  var bOrigin = -1;
  var bIgnored = false;
  var bStart = 0;
  var bRange = 0;
  var bMax = 0;
  var bHitUrl = null;
  var bHitLang = null;
  var bHitPair = null;
  var bHitConvert = false;
  var bHitFP = null;
  var bHitRank = -1;
  var bLang = '';
  var pCurrentFrame;
  var bWin = true;
  var bVSplitRatio = GetCookie('bVSplitRatio', 50);
  var bBookmarkRevertTitle = null;
  var bBookmarkRevertSource = null;
  var bBookmarkTitle = bBookmarkDecode();
  var bIsShifKey = false;
  var bVisDisplay = 0;
  var bFrameOut = false;
  var bMaximized=GetCookie('bMaximized', 0);
  function bSetCapture(elt, move, stop) {
    if (elt) {
      if (client.isIE) {
        elt.setCapture(true);
      } else {
        var f = frames[nameFrame];
        document.addEventListener('mousemove', move, true);
        document.addEventListener('mouseover', move, true);
        document.addEventListener('mouseup', stop, true);
        document.addEventListener('click', stop, true);
        if (f) {
          f.document.addEventListener('mousemove', move, true);
          f.document.addEventListener('mouseover', move, true);
          f.document.addEventListener('mouseup', stop, true);
          f.document.addEventListener('click', stop, true);
      }
      }
    }
  }
  function bReleaseCapture(move, stop) {
    if (client.isIE) {
      document.releaseCapture();
    } else {
      var f = frames[nameFrame];
      document.removeEventListener('mousemove', move, true);
      document.removeEventListener('mouseover', move, true);
      document.removeEventListener('mouseup', stop, true);
      document.removeEventListener('click', stop, true);
      if (f) {
        f.document.removeEventListener('mousemove', move, true);
        f.document.removeEventListener('mouseover', move, true);
        f.document.removeEventListener('mouseup', stop, true);
        f.document.removeEventListener('click', stop, true);
      }
    }
  }
  function bIgnore() {
    bIgnored = true;
    return true;
  }
  function bFocus() {
    if (client.isIE) {
      Focus(nameDiv);
    }
  }
  function bBack() {
    return Exec(event,1,null,'2z','');
  }
  function bTranslate(translate) {
    var bLogo = document.getElementById('bLogo');
    if (bLogo) {
      bLogo.innerHTML = translate ? '<a target="systran" href="http://www.systransoft.com/"><img width="103" heigh="18" border="0" src="/site/systran.gif" /></a>' : '';
    }
  }
  function bExclude(event) {
    var limit = 27;
    var x = event.clientX;
    var elt = Source(event);
    if (elt.tagName != 'TD') {
      return false;
    }
    if (elt.className.match(/^[mgepqrt][01] i/)) {
      var no = elt.className.substring(4).split(' ')[0];
      limit = 15 * no + 26;
    }
    return (x + 10) < limit && limit < (x + 23);
  }
  function bActionExclude(event) {
    if (bExclude(event)) {
      var elt = Source(event);
      var update = smooth ? 1 : 0;
      var elts = PureSearch(elt.firstChild).split('&');
      var action = elts[elts.length - 1].split('=');
      var value = decodeURIComponent(action[1]);
      Exec(window.event, update, null, action[0], '-' + value.substring(1));
    }
    return Cancel(event);
  }
  function bActionOver(event) {
    if (!submitted) {
      var elt = Source(event);
      if (bExclude(event)) {
        var elt = elt.firstChild;
        elt.style.color = '#ff6f05';
        elt.style.textDecoration = 'line-through';
        elt.parentNode.style.cursor = 'hand';
      } else if (elt.tagName == 'A') {
        elt.style.color = '#ff6f05';
      } else if (elt.firstChild && elt.firstChild.style) {
        elt.style.cursor = 'default';
        elt.firstChild.style.color = 'black';
        elt.firstChild.style.textDecoration = 'none';
      }
    }
    return Cancel(event);
  }
  function bActionOut(event) {
    if (!submitted) {
      var elt = Source(event);
      if (elt.tagName == 'TD') {
        elt = elt.firstChild;
      }
      elt.style.color = 'black';
      elt.style.textDecoration = 'none';
      elt.parentNode.style.cursor = 'default';
    }
    return Cancel(event);
  }
  function bOpen(event) {
    var elt = Source(event);
    while (elt && elt.tagName != 'A') {
      elt = elt.parentNode;
    }
    if (elt) {
      var url = HRef(elt);
      if (elt.target || event.shiftKey) {
        window.open(url, elt.target);
      } else {
        window.location = url;
      }
      return Cancel(event);
    } else {
      return true;
    }
  }
  function bHit(n) {
    return document.getElementById('H' + n);
  }
  function bHitEncode(convert, fp, info) {
    return convert + fp + ' ' + info;
  }
  function bHitDecode(code) {
    var triple = new Array();
    triple[0] = code.charAt(0);
    for (var i = 1 ; i < code.length ; ++i) {
      if (code.charAt(i) == ' ') {
        triple[1] = code.substring(1, i);
        triple[2] = code.substring(i + 1);
        return triple;
      }
    }
    return null;
  }
  function bSelectHit(hit, color, style, bg) {
    if (hit.tagName == 'TR') {
      var len = hit.childNodes.length;
      if (len > 0) {
        hit.childNodes[0].style.borderColor = color;
        hit.childNodes[0].style.borderStyle = style;
        if (len > 1) {
          hit.childNodes[1].style.borderColor = color;
          hit.childNodes[1].style.borderStyle = style;

        }
        if (bg) {
          hit.childNodes[0].style.backgroundColor = bg;
          if (len > 1) {
            hit.childNodes[1].style.backgroundColor = bg;
          }
        }
      }
    } else {
      hit.style.borderColor = color;
      hit.style.borderStyle = style;
      if (bg) {
        hit.style.backgroundColor = bg;
      }
    }
  }
  function bSelectNav(event, delta, sel) {
    var n = bCur + delta;
    var hitno = bStart + n;
    if (bCur == -1 || hitno < 0 || hitno >= bMax) {
      return Cancel(event);
    } else if (n < 0) {
      return Exec(event, 1, null, '2s', (bStart - bRange) + '.' + sel, 'disableShift', '');
    } else if (n >= bRange) {
      return Exec(event, 1, null, '2s', (bStart + bRange) + '.' + sel);
    } else {
      return bPreviewHit(event, n, true);
    }
  }
  function bFind(event) {
    var hit = Source(event);
    while (hit.tagName != 'HTML' &&
           hit.tagName != 'TR' &&
           hit.tagName != 'TD') {
      hit = hit.parentNode;
    }
    if (hit.tagName == 'TD') {
      if (hit.id.match(/^H[0-9][0-9]*$/)) {
        return parseInt(hit.id.substring(1));
      }
      hit = hit.parentNode;
    }
    if (hit.tagName == 'TR' && hit.id.match(/^H[0-9][0-9]*$/)) {
      return parseInt(hit.id.substring(1));
    }
    return -1;
  }
  function bHilite(event) {
    if (!submitted) {
      var n = bFind(event);
      if (n != -1) {
        bHilited = n;
        bSelectHit(bHit(n), 'gray', 'dashed', null);
      }
    }
    return Cancel(event);
  }
  function bUnHilite(event) {
    if (!submitted) {
      var n = bFind(event);
      if (n != -1 && n != bSel && bHilited != -1) {
        bHilited = -1;
        bSelectHit(bHit(n), 'white', 'solid', null);
      }
    }
    return Cancel(event);
  }
  function bCommandKey(event) {
    if (event.keyCode == 27) {
      bVSplit(100);
      return Cancel(event);
    } else if (event.keyCode == 32 || (client.isGK && event.charCode == 32)) {
      var delta = (event.shiftKey || bIsShifKey) ? -1 : +1;
      var sel = (event.shiftKey || bIsShifKey) ? -1 : 0;
      if (bCur == -1) {
        bCur = 0;
        bSel = 0;
        delta = 0;
        sel = 0;
      }
      bSelectNav(event, delta, sel);
    } else if (event.keyCode == 13) {
      bPreviewHit(event, bCur == -1 ? 0 : bCur, false);
    } else {
      return true;
    }
  }
  function bPreview(event) {
    if (bIgnored) {
      bIgnored = false;
      return true;
    }
    var n = bFind(event);
    return n == -1 ? true : bPreviewHit(event, n, false);
  }
  function bPreviewOpen(event) {
    if (bHitUrl) {
      window.open(bHitUrl);
    }
    return Cancel(event);
  }
  function bPreviewTranslate(event) {
    var pFrame = document.getElementById(nameFrame);
    var bMessage = document.getElementById('bMessage');
    var bLogo = document.getElementById('bLogo');
    if (pFrame && bMessage && bLogo && bHitUrl) {
      if (bHitPair == null && bHitLang != null) {
        bHitPair = bHitLang + '_' + bLang;
      } else {
        bHitPair = null;
      }
      bCount = 0;
      bLogo.innerHTML = '';
      bMessage.innerHTML = getLabel('loadingLabel');
      pFrame.src = bPreviewUrl(bHitUrl, bHitPair,
                               bHitConvert,
                               bHitFP, bRegexp, bHitRank);
    }
    return Cancel(event);
  }
  function bPreviewUrl(url, pair, convert, fp, regexp, rank) {
    return ('/search' + '?C=' + Context() +
            '&2v=' + encodeURIComponent(url) + '&f=' + fp +
            (pair ? '&g=' + pair : '') +
            (convert ? '&k=' : '') +
            (regexp ? '&r=' + encodeURIComponent(bRegexp) : '') +
            '&n=' + rank);
  }  
  function bBookmarkIllegal(title) {
    for (var url in bBookmarkTitle) {
      if (bBookmarkTitle[url] != null && bBookmarkTitle[url] == title) {
        return true;
      }
    }
    return title.length == 0;
  }
  function bBookmarkRename(event, code) {
    if (bBookmarkRevertSource) {
      var src = bBookmarkRevertSource;
      var title = null;
      if (code == 13) {
        var url = src.parentNode.childNodes[1].innerHTML;
        var triple = bHitDecode(url);
        var convert = triple[0];
        var fp = triple[1];
        url = triple[2];
        if (bBookmarkIllegal(src.value)) {
          title = bBookmarkRevertTitle;
        } else {
          title = src.value;
          bBookmarkTitle[url] = bHitEncode(convert, fp, title);
          bBookmarkEncode();
        }
      } else if (code == 27) {
        title = bBookmarkRevertTitle;
      } else if (code == 38 || code == 60 || code == 62) {
        return Cancel(event);
      } else {
        return true;
      }
      bBookmarkRevertTitle = null;
      bBookmarkRevertSource = null;
      var a = document.createElement('A');
      a.innerHTML = title.replace(/&/g, "").replace(/</g, "").replace(/>/g, "");
      a.className = 's10';
      a.href = '#';
      Attach(a, 'click', bBookmarkClick);
      src.parentNode.replaceChild(a, src);
      Detach(document.body, 'click', bBookmarkEnd);
      return Cancel(event);
    } else {
      return true;
    }
  }
  function bBookmarkEnd(event) {
    return bBookmarkRename(event, 13);
  }
  function bBookmarkKey(event) {
    return bBookmarkRename(event, event.keyCode);
  }
  function bBookmarkRemoveUrl(event) {
    var src = Source(event).parentNode.parentNode;
    var url = src.childNodes[1].childNodes[1].innerHTML;
    var triple = bHitDecode(url);
    bBookmarkTitle[triple[2]] = null;
    if (bBookmarkEncode()) {
      src = src.parentNode;
      src.parentNode.removeChild(src);
    } else {
      bBookmarkClose();
    }
    return Cancel(event);
  }
  function bBookmarkSaveUrl(event) {
    var src = Source(event).parentNode.parentNode;
    var url = src.childNodes[1].childNodes[1].innerHTML;
    var title = src.childNodes[1].firstChild.innerHTML;
    var triple = bHitDecode(url);
    external.AddFavorite(triple[2], title);
    return Cancel(event);
  }
  function bBookmarkClick(event) {
    var src = Source(event);
    var pSite = document.getElementById('pSite');
    var pFrame = document.getElementById(nameFrame);
    var bMessage = document.getElementById('bMessage');
    var bLogo = document.getElementById('bLogo');
    var bTranslate1 = document.getElementById('bTranslate1');
    var bTranslate2 = document.getElementById('bTranslate2');
    if (bBookmarkRevertSource) {
      return Cancel(event);
    } else if (src.tagName == 'A') {
      if (pFrame) {
        var triple;
        var url = src.parentNode.childNodes[1].innerHTML;
        triple = bHitDecode(url);
        var disp = triple[2];
        if (disp.length > 55) {
          disp = disp.substring(0, 55) + '...';
        }
        bHitUrl = triple[2];
        bHitPair = null;
        bHitLang = null;       
        pSite.innerHTML = disp;
        bCount = 0;
        bLogo.innerHTML = '';
        if (bTranslate1) {
          bTranslate1.style.display = 'none';
        }
        if (bTranslate2) {
          bTranslate2.style.display = 'none';
        }
        bMessage.innerHTML = getLabel('loadingLabel');
        pFrame.src = bPreviewUrl(triple[2], null,
                                 triple[0] == '1',
                                 triple[1], null, -1);
        bMaximize();

        // new behaviour: max preview when opening bookmarks
        //bVSplit(bVSplitRatio);
      }
      return Cancel(event);
    } else {
      var elt = src.firstChild;
      var input = document.createElement('INPUT');
      bBookmarkRevertTitle = elt.innerHTML;
      bBookmarkRevertSource = input;
      Attach(input, 'keypress', bBookmarkKey);
      input.type = 'text';
      input.className = 's11';
      input.value = bBookmarkRevertTitle;
      src.replaceChild(input, elt);
      Attach(document.body, 'click', bBookmarkEnd);
      Select(input, 0, input.value.length);
      return Cancel(event);
    }
  }
  function bBookmarkEncode() {
    var code = '';
    var empty = true;
    for (var url in bBookmarkTitle) {
      var title = bBookmarkTitle[url];
      if (title) {
        empty = false;
        code += url;
        code += String.fromCharCode(27);
        code += title;
        code += String.fromCharCode(27);
      }
    }
    SetCookie('bBookmarkTitle', code);
    return !empty;
  }
  function bBookmarkDecode() {
    var code = GetCookie('bBookmarkTitle', '');
    bBookmarkTitle = new Array();
    try {
      var seq = code.split(String.fromCharCode(27));
      for (var i = 0 ; (i + 1) < seq.length ; i += 2) {
        bBookmarkTitle[seq[i]] = seq[i + 1];
      }
    } catch (ex) {
      bBookmarkTitle = new Array();
    }
    return bBookmarkTitle;
  }
  function bBookmarkClose() {
    var i;
    var lData = document.getElementById(nameData);
    var lSep = document.getElementById(nameStep);
    var lTable = lData.firstChild.firstChild.firstChild;
    var lRows = lTable.childNodes;
    bBookmarkTitle = new Array();
    SetCookie('bBookmarkTitle', '');
    for (i = lRows.length ; i > 0 ; ) {
      var elt = lRows[--i];
      if (elt.className == 'S') {
        elt.style.display = 'none';
      } else if (elt.className == 's') {
        lTable.removeChild(elt);
      } else {
        break;
      }
    }
    if (i == 0) {
      lData.style.display = 'none';
      lSep.style.display = 'none';
    }
  }
  function bBookmarkAddPreview(event) {
    if (bHitUrl && !bBookmarkTitle[bHitUrl]) {
      var title;
      if(bHitUrl.match(/^file:\/\//)){
        var spl = bHitUrl.split('/');
        title = spl[spl.length-1];
      }else {
        title = bHitUrl.split('/')[2];
      }
      var convert = bHitConvert ? '1' : '0';
      bBookmarkTitle[bHitUrl] = bHitEncode(convert, bHitFP, title);
      bBookmarkEncode();
      bBookmarkAddUrl(bHitUrl, bBookmarkTitle[bHitUrl]);
    }
    return Cancel(event);
  }
  function bBookmarkAddUrl(url, title) {
    var lData = document.getElementById(nameData);
    var lSep = document.getElementById(nameStep);
    var lTable = lData.firstChild.firstChild.firstChild;
    var lRows = lTable.childNodes;
    var table = document.createElement('TABLE');
    var tbody = document.createElement('TBODY');
    var tr = document.createElement('TR');
    var td = document.createElement('TD');
    var img1 = document.createElement('IMG');
    var img2 = document.createElement('IMG');
    var td1 = document.createElement('TD');
    var td2 = document.createElement('TD');
    var td3 = document.createElement('TD');
    var a = document.createElement('A');
    var span = document.createElement('SPAN');
    var triple = bHitDecode(title);
    img1.src = '/site/save.gif';
    img2.src = '/site/bclose.gif';
    a.innerHTML = triple[2];
    a.className = 's10';
    a.href = '#';
    span.innerHTML = bHitEncode(triple[0], triple[1], url);
    span.style.display = 'none';
    td1.className = 's7';
    td2.className = 's8';
    td1.appendChild(img1);
    td2.appendChild(a);
    td2.appendChild(span);
    td3.className = 's9';
    td3.appendChild(img2);
    tr.appendChild(td1);
    tr.appendChild(td2);
    tr.appendChild(td3);
    tbody.appendChild(tr);
    table.appendChild(tbody);
    table.cellspacing = '0';
    table.cellpadding = '0';
    table.border = '0';
    table.width = '100%';
    td.appendChild(table);
    tr = document.createElement('TR');
    tr.appendChild(td);
    tr.className = 's';
    Attach(td2, 'click', bBookmarkClick);
    Attach(a, 'click', bBookmarkClick);
    Attach(img1, 'click', bBookmarkSaveUrl);
    Attach(img2, 'click', bBookmarkRemoveUrl);
    for (var i = 0 ; i < lRows.length ; ++i) {
      lRows[i].style.display = '';
    }
    lData.style.display = '';
    lSep.style.display = '';
    lTable.appendChild(tr);
  }
  function bPreviewHit(event, n, scroll) {
    try {
      var url = null;
      var title = null;
      var lang = null;
      var hit = null;
      var convert = null;
      var fp = null;
      var rDiv = document.getElementById(nameDiv);
      var pSite = document.getElementById('pSite');
      var pFrame = document.getElementById(nameFrame);
      var bMessage = document.getElementById('bMessage');
      var bLogo = document.getElementById('bLogo');
      var bTranslate1 = document.getElementById('bTranslate1');
      var bTranslate2 = document.getElementById('bTranslate2');
      var rData0 = document.getElementById('rData0');
      var rData2 = document.getElementById('rData2');
      if (n != -1) {
        if (bCur != -1) {
          hit = bHit(bCur);
          if (hit && hit.style) {
            bSel = -1;
            bSelectHit(hit, 'white', 'solid', 'white');
          }
        }
        if (bHilited != -1) {
          hit = bHit(bHilited);
          if (hit && hit.style) {
            bHilited = -1;
            bSelectHit(hit, 'white', 'solid', 'white');
          }
        }
        if (bCur != n || rData2.style.display != '') {
          hit = bHit(n);
          if (hit && hit.style) {
            var triple;
            bCur = n;
            bSel = n;
            if (hit.tagName == 'TR') {
              var hitDiv = hit.firstChild.firstChild;
              if (hit.firstChild.firstChild.tagName != 'DIV') {
                hitDiv = hit.childNodes[1].firstChild;
              }
              url = HRef(hitDiv.firstChild);
              lang = hitDiv.childNodes[1].innerHTML;
            }else {
              if (hit.firstChild.tagName == "A") {
                url = HRef(hit.firstChild);
                lang = hit.childNodes[3].innerHTML;
              }else {
                var lnk = hit.firstChild;
                while (lnk.tagName != "A") {
                  lnk = lnk.firstChild;
                }
                url = HRef(lnk);
                lang = hit.childNodes[2].innerHTML;
              } 
            }

            triple = bHitDecode(lang);
            convert = triple[0] == '1';
            fp = triple[1];
            lang = triple[2];
            bSelectHit(hit, 'gray', 'dashed',
                       (scroll && bHitUrl == null ? 'white' :
                        '#f6ffc6'));
          
          }
        }
        if('true' == 'true') {
          if (url) {
            var nBeg = url.indexOf("n=") + 2;
            var uBeg = url.indexOf("&u=") + 3;
            bHitRank = url.substring(nBeg, uBeg - 3);
            url = decodeURIComponent(url.substring(uBeg));
          }
        }
        if (rData0 && bCur != -1) {
          var nav = '';
          var cur = bStart + bCur;
          if ((cur - bRange) >= 0) {
            nav = '<img width="26" height="18" onclick="bSelectNav(event, -' + bRange + ',0)" class="s5" src="/site/pprev.gif" border="0" align="absmiddle"/>';
          }
          if ((cur - 1) >= 0) {
            nav += '<img width="15" height="18" onclick="bSelectNav(event, -1, -1)" class="s5" src="/site/prev.gif" border="0" align="absmiddle"/>';
          }
          nav += getLabel('documentLabel') + ' ' + (cur + 1);
          if ((cur + 1) < bMax) {
            nav += '<img width="15" height="18" onclick="bSelectNav(event, 1, 0)" class="s5" src="/site/next.gif" border="0" align="absmiddle"/>';
          }
          if ((bStart + bRange) < bMax) {
            nav += '<img width="26" height="18" onclick="bSelectNav(event, ' + bRange + ',0)" class="s5" src="/site/pnext.gif" border="0" align="absmiddle"/>';
          }
          rData0.innerHTML = nav;
        }
      }
      if (bCur == -1 || !url || (scroll && rData2.style.display == 'none')) {
        bHitUrl = null;
        bHitLang = null;
        bHitPair = null;
        bHitConvert = false;
        bCount = 0;
        pFrame.src = 'about:blank';
        bVSplit(100);
      } else {
        var disp = url.substring(7);
        if (title) {
          disp = title;
        }
        var translate = lang != 'xx' && lang != bLang;
        if (disp.length > 55) {
          disp = disp.substring(0, 55) + '...';
        }
        scroll |= rData2.style.display == 'none';
        bHitUrl = url;
        bHitLang = lang;
        bHitConvert = convert;
        bHitFP = fp;
        bHitPair = null;
        if (bTranslate1) {
          bTranslate1.style.display = translate ? '' : 'none';
        }
        if (bTranslate2) {
          bTranslate2.style.display = translate ? '' : 'none';
        }
        pSite.innerHTML = disp;
        bCount = 0;
        bLogo.innerHTML = '';
        bMessage.innerHTML =  getLabel('loadingLabel');
        pFrame.src = bPreviewUrl(url, null, convert, fp, bRegexp, bHitRank);
        // bVSplit(bVSplitRatio);
        bSetPrevMenu();
        if (bMaximized == 1) {
          bLimitVSplit();
        }else {
       
          bVSplit(bVSplitRatio);
        }
      }
      if (hit && scroll) {
        var offset = 0;
        while (hit && hit.tagName != 'DIV') {
          offset += hit.offsetTop;
          if (hit.offsetParent != hit.parentNode) {
            while (hit && hit.tagName != 'DIV' && hit != hit.offsetParent) {
              hit = hit.parentNode;
            }
            if (hit.tagName == 'DIV') {
              break;
            }
          }
        }
        rDiv.scrollTop = offset - 1;
      }
    }
    catch (ex) {
      bCur = -1;
      bSel = -1;
      bHilited = -1;
    }
    return Cancel(event);
  }
  function bIsFrame(obj){
    if(obj && (obj.tagName=='FRAME' || obj.tagName=='IFRAME')){
      return true;
    }
    return false;
  }
 function bIncrementDisplayCounter(delta){
   if (delta > 0) {
      top.bVisDisplay = (top.bVisDisplay + 1) % bCount;
    } else if (top.bVisDisplay <= 0) {
      top.bVisDisplay = top.bCount - 1;
    } else {
      top.bVisDisplay -= 1;
    }
  }
  function bUpdateCounterDisplay(){
    obj = document.getElementById('bCounter');
    if (obj) {
     obj.innerHTML = getLabel('termLabel') + ' ' + (top.bVisDisplay+1);
    }
  } 
 // Zap current object 
 function bZap(delta){
   var framesAndTerms = pCurrentFrame.frameCount + pCurrentFrame.frameNum;
   if (delta > 0) {
     pCurrentFrame.frameVis = (pCurrentFrame.frameVis + 1) % framesAndTerms;
   } else if (pCurrentFrame.frameVis == 0) {
     pCurrentFrame.frameVis = framesAndTerms - 1;
   } else {
     pCurrentFrame.frameVis -= 1;
   }
 }

  function bOut(delta){
    if(pCurrentFrame.name == nameFrame){    
      return false;
    }
    // recursive out in limit frames 
    if(pCurrentFrame.parent.name != nameFrame){
      var fn = pCurrentFrame.name.slice(1,pCurrentFrame.name.length);
      var limSup = pCurrentFrame.parent.frameNum-1;
      var limInf = 0;
      if((fn==limSup && delta>0) || (fn==limInf && delta<0)){
        pCurrentFrame = pCurrentFrame.parent;
        return out(delta);
      }
    }
    pCurrentFrame = pCurrentFrame.parent;
    var obj  = pCurrentFrame.document.getElementById('$' + pCurrentFrame.frameVis)
    if(isFrame(obj) && !pCurrentFrame.frameObj){
      zap(delta);
      bFrameOut = true;
    }
    return true;
  }
  function bNavigat(event, delta){
    if(pCurrentFrame.frameTotalCount>0){
      if(bFrameOut && pCurrentFrame.name != nameFrame && pCurrentFrame.frameCount>0){
        bIncrementDisplayCounter(delta);
        bFrameOut = false;
      }
      if(pCurrentFrame.frameObj){
        pCurrentFrame.frameObj.style.borderStyle = 'solid';
        pCurrentFrame.frameObj.style.backgroundColor = '#ffff00';
        pCurrentFrame.frameObj.style.borderColor = '#ffff00';
        if((delta<0 && pCurrentFrame.frameVis <= 0) || (delta > 0 && pCurrentFrame.frameVis>=pCurrentFrame.frameCount - 1)){
          if(bOut(delta)){          
            return bNavigat(event, delta);
          }
        }
        var framesAndTerms = pCurrentFrame.frameCount + pCurrentFrame.frameNum;
        if (delta > 0) {
          pCurrentFrame.frameVis = (pCurrentFrame.frameVis + 1) % framesAndTerms;
          top.bVisDisplay = (top.bVisDisplay + 1) % bCount;
        } else if (pCurrentFrame.frameVis <= 0) {
          pCurrentFrame.frameVis = framesAndTerms - 1;
          top.bVisDisplay = top.bCount - 1;
        } else {
          pCurrentFrame.frameVis -= 1;
          top.bVisDisplay -= 1;
        }
      }
      var obj = pCurrentFrame.document.getElementById('$' + pCurrentFrame.frameVis);
      if (obj && obj.scrollIntoView) {
        if(bIsFrame(obj)){
          var f = pCurrentFrame.frames['$' + pCurrentFrame.frameVis];
          if(f.frameTotalCount>0){
            pCurrentFrame = f;
            if(delta>0){
              pCurrentFrame.frameVis = 0;
            }else{
              if(bFrameOut){
                pCurrentFrame.frameVis = pCurrentFrame.frameCount + pCurrentFrame.frameNum - 1;
              }
            }
            pCurrentFrame.frameObj = null;
          }else {
            if(!pCurrentFrame.frameObj){
              bZap(delta);
            }else{
              pCurrentFrame.frameObj = null;
            }
          }
          return bNavigat(event, delta);
        }
        pCurrentFrame.frameObj = obj;
        obj.style.borderStyle = 'dashed';
        pCurrentFrame.frameObj.style.backgroundColor = '#ddff44';
        obj.style.borderColor = '#666666'
        obj.scrollIntoView(false);
      } 
      bUpdateCounterDisplay();
    } 
    return Cancel(event);
  }    
  function bHiliteNav(event, delta) {
    if (bCount > 0) {
      var win = frames[nameFrame];
      if (bObj) {
        bObj.style.borderStyle = 'solid';
        bObj.style.backgroundColor = '#ffff00';
        bObj.style.borderColor = '#ffff00';
        if (delta > 0) {
          bVis = (bVis + 1) % bCount;
          bVisDisplay = (bVisDisplay + 1) % bCount;
        } else if (bVis == 0) {
          bVis = bCount - 1;
          bVisDisplay = bCount - 1;
        } else {
          bVis -= 1;
          bVisDisplay -= 1;
        }
      }
      if (win && win.document) {
        var obj = win.document.getElementById('$' + bVis);
        if (obj && obj.scrollIntoView) {
          bObj = obj;
          obj.style.borderStyle = 'dashed';
          bObj.style.backgroundColor = '#ddff44';
          obj.style.borderColor = '#666666'
          obj.scrollIntoView(false);
        }
        updateTermLabel(bVisDisplay+1);
      }
    }
    return Cancel(event);
  }
  function Offset(elt) {
    var offset = 0;
    while (elt) {
      offset += elt.offsetTop;
      elt = elt.offsetParent;
    }
    return offset;
  }
  function bResize(event) {
    if (bVSplitRatio != 100) {
      bVSplit(100);
    }
  }
  function bVSplit(percent) {
    var rDiv = document.getElementById(nameDiv);
    var rData1 = document.getElementById(nameData1);
    var rData2 = document.getElementById(nameData2);
    var pFrame = document.getElementById(nameFrame);
    if (percent > 98) {
      rData1.style.display = '';
      rData1.style.height = '100%';
      rData2.style.display = 'none';
      pFrame.src = 'about:blank';
      if (bSel != -1) {
        bSelectHit(bHit(bSel), 'gray', 'dashed', 'white');
      }
    } else if (percent < 2) {
      bVSplitRatio = 0;
      bCount = -1;
      rData1.style.display = 'none';
      rData2.style.display = '';
      rData2.style.height = '100%';
    } else if (window.innerHeight) {
      var table = rDiv.parentNode.parentNode.parentNode.parentNode;
      var height = window.innerHeight - Offset(table) - 22;
      var top = (height * percent) / 100;
      bVSplitRatio = percent;
      rData1.style.display = '';
      rData1.style.height = '' + top + 'px';
      rData2.style.display = '';
      rData2.style.height = '' + (height - top) + 'px';
      table.style.height = height + 'px';
      document.body.style.width = '0%';
      document.body.style.width = '100%';
      document.body.style.height = '0%';
      document.body.style.height = '100%';
      pCurrentFrame = frames[nameFrame];
    } else {
      bVSplitRatio = percent;
      rData1.style.display = '';
      rData1.style.height = bVSplitRatio + '%';
      rData2.style.display = '';
      rData2.style.height = (100 - bVSplitRatio) + '%';
      pCurrentFrame = frames[nameFrame];
    }
    SetCookie('bVSplitRatio', bVSplitRatio);
  }
  function bVSplitStart(event) {
    if (bMaximized==1) {
      return Cancel(event);
    }
    var elt = Source(event);
    bOrigin = event.clientY;
    bSetCapture(elt, bVSplitMove, bVSplitStop);
    var vSep = document.getElementById('vSep');
    vSep.style.zIndex = 100;
    vSep.style.top = '0px';
    vSep.style.display = '';
    return Cancel(event);
  }
  function bVSplitMove(event) {
    if (bMaximized==1) {
      return Cancel(event);
    }
    if (bOrigin >= 0) {
      var delta = event.clientY - bOrigin;
      var vSep = document.getElementById('vSep');
      vSep.style.top = '' + delta + 'px';
      vSep.style.display = '';
    }
    return Cancel(event);
  }
  function bVSplitStop(event) {
    if (bMaximized==1) {
      return Cancel(event);
    }
    var rData1 = document.getElementById(nameData1);
    var rData2 = document.getElementById(nameData2);
    var vSep = document.getElementById('vSep');
    vSep.style.display = 'none';
    if (rData1 && rData2) {
      var delta = event.clientY - bOrigin;
      var height = rData1.offsetHeight;
      var sum = rData1.offsetHeight + rData2.offsetHeight;
      if ((delta + height) < 0) {
        bVSplit(0);
      } else {
        bVSplit((100 * (delta + height)) / sum);
      }
    }
    bReleaseCapture(bVSplitMove, bVSplitStop);
    bOrigin = -1;
    return Cancel(event);
  }
  function bHSplitStart(event) {
    var elt = Source(event);
    var hSep = document.getElementById('hSep');
    bOrigin = event.clientX;
    bSetCapture(elt, bHSplitMove, bHSplitStop);
    hSep.style.zIndex = 100;
    hSep.style.top = '0px';
    hSep.style.display = '';
    return Cancel(event);
  }
  function bHSplitMove(event) {
    if (bOrigin >= 0) {
      var delta = event.clientX - bOrigin;
      var hSep = document.getElementById('hSep');
      hSep.style.left = '' + delta + 'px';
      hSep.style.display = '';
    }
    return Cancel(event);
  }
  function bHSplitStop(event) {
    var hSep = document.getElementById('hSep');
    hSep.style.left = '0px';
    hSep.style.display = 'none';
    var lData = document.getElementById(nameData);
    if (lData) {
      var width = parseInt(lData.width) + (event.clientX - bOrigin);
      if (width < 150) {
        width = 150;
      }
      lData.width = '' + width;
      lData.firstChild.style.width = '' + width + 'px';
      SetCookie('bHSplitSize', width);
    }
    bReleaseCapture(bHSplitMove, bHSplitStop);
    bOrigin = -1;
    return Cancel(event);
  }
  function bInit(first) {
    var lData = document.getElementById(nameData);
    var rData1 = document.getElementById(nameData1);
    var rData2 = document.getElementById(nameData2);
    var imgs = document.getElementsByTagName('IMG');
    for (var i = 0 ; i < imgs.length ; ++i) {
      var img = imgs[i];
      if (img.src) {
        var j = img.src.indexOf('/thumb?g=');
        if (j > 0) {
          img.src = (img.src.substring(0, j + 7) + 'f' +
                     img.src.substring(j + 8));
        }
      }
    }
    if (lData) {
      var elts = lData.firstChild.firstChild.firstChild.childNodes;
      for (var i = 0 ; i < elts.length ; ++i) {
        var elt = elts[i].firstChild;
        if (elt.className.match(/^k n/) ||
            elt.className.match(/^[mgepqrt][01] i[0-9]* n/)) {
          Attach(elt, 'mouseover', bActionOver);
          Attach(elt, 'mousemove', bActionOver);
          Attach(elt, 'mouseout', bActionOut);
          Attach(elt, 'click', bActionExclude);
          Attach(elt.firstChild, 'mouseover', bActionOver);
          Attach(elt.firstChild, 'mousemove', bActionOver);
          Attach(elt.firstChild, 'mouseout', bActionOut);
        }
      }
    }
    if (rData1) {
      var k = 0;
      var elts = rData1.firstChild.firstChild.firstChild.childNodes;
      for (var i = 0 ; i < elts.length ; ++i) {
        var elt = elts[i];
        var processElt =  elt.firstChild.className.match(/^d[01]/) ||
          (elt.childNodes[1] &&
           elt.childNodes[1].className.match(/^d[01]/));
        if (processElt) {
          var thumb;
          var divs;
          if (elt.firstChild.className.match(/^d[01]/)) {
            thumb = elt.childNodes[1];
            divs = elt.firstChild.childNodes;
          } else {
            divs = elt.childNodes[1].childNodes;
            thumb = elt.firstChild;
          }
          for (var j = 0 ; j < divs.length ; ++j) {
            var div = divs[j];
            if (div.tagName == "DIV" &&
                div.firstChild && div.firstChild.tagName == "A" &&
                (j == 0 || div.firstChild.target)) {
                Attach(div.firstChild, 'click', bOpen);
            }
          }
          elt.id = 'H' + k++;
          Attach(elt, 'click', bPreview);
          Attach(elt, 'mouseover', bHilite);
          Attach(elt, 'mouseout', bUnHilite);
          Attach(elt, 'selectstart', bIgnore);
          if (thumb) {
            thumb.firstChild.style.cursor = 'default';
          }
        } else if (elt.firstChild.className.match(/^d2/)) {
          for (var j = 0 ; j < elt.childNodes.length ; ++j) {
            var data = elt.childNodes[j];            
            data.id = 'H' + k++;
            data.childNodes[0].style.cursor = 'default';
            for (var c = 2 ; c < data.childNodes.length ; ++c) {
              var lnk = data.childNodes[c];
              if (lnk.tagName == 'A') {
                Attach(lnk, 'click', bOpen);
              }
            }
            Attach(data, 'click', bPreview);
            Attach(data, 'mouseover', bHilite);
            Attach(data, 'mouseout', bUnHilite);
            Attach(data, 'selectstart', bIgnore);
          }
        }
      }
    }
    if (first) {
      if (lData) {
        var lTable = lData.firstChild.firstChild.firstChild;
        if (!lTable || !lTable.lastChild ||
            lTable.lastChild.className != 'S' ||
            lTable.lastChild.style.display == 'none') {
          bBookmarkRevertTitle = null;
          bBookmarkRevertSource = null;
          for (var url in bBookmarkTitle) {
            var title = bBookmarkTitle[url];
            if (title) {
              bBookmarkAddUrl(url, title);
            }
          }
        }
      }
      if (rData1) {       
        Attach(rData1.parentNode.parentNode.parentNode,
               'keypress', bCommandKey);
      }
      if (rData2) {
        var trans = "";
        if ('true' == 'true') {
          trans =  '<td id="bTranslate1" class="s24"><img width="2" height="1" src="/site/pixel.gif" /></td><td id="bTranslate2" class="s29 s25"><a href="#" onclick="bPreviewTranslate(event)" class="s29"><img width="24" height="12" border="0" align="top" src="/site/translate.gif" />&nbsp;' + getLabel('translateLabel') + '</a></td>';
        }
        var separator = '<div class="s19" style="position:relative;display:none" id="vSep" />';
        var spacer = '<img height="6" width="100%" src="/site/pixel.gif" />';
        var maxStyle;
        var minStyle;
        if (bMaximized == 1) {
          maxStyle = 'none';
          minStyle = 'block';
        }else {
          minStyle = 'none';
          maxStyle = 'block';
        }

        rData2.innerHTML = '<table border="0" cellpadding="0" cellspacing="0" style="width:100%;height:100%"><tr><td onmousedown="bVSplitStart(event)" onmousemove="bVSplitMove(event)" onmouseup="bVSplitStop(event)" colspan="3" class="s18" >' + separator + spacer + '</td></tr><tr class="s27"><td class="s29 s25" ondblclick="bPrevDBClick(event)"><table cellspacing="0" cellpadding="0" border="0"><tr><td class="s29 s25"><a href="#" onclick="bPreviewOpen(event)" class="s29"><img width="14" height="14" align="top" border="0" src="/site/newwin.gif"/>&nbsp;'+getLabel('openLabel')+'</a></td><td class="s24"><img width="2" height="1" src="/site/pixel.gif" /></td><td class="s29 s25"><a href="#" onclick="bBookmarkAddPreview(event)" class="s29"><img width="15" height="14" border="0" align="top" src="/site/bookmark.gif"/>&nbsp;'+getLabel('bookmarkLabel')+'<a></td>'+trans+'</tr></table></td><td align="right" ondblclick="bPrevDBClick(event)"><table cellpadding="0" cellspacing="0" class="icons"><tr><td style="display:'+maxStyle+'"><img width="14" height="14" onclick="bMaximize()" id="_max" src="/site/maximize.gif"/></td><td style="display:'+minStyle+'"><img width="14" height="14" onclick="bMinimize()" id="_min" src="/site/minimize.gif"/></td><td style="padding-right:0px"><img width="14" height="14" onclick="bVSplit(100)" src="/site/close2.gif"/></td><td><img width="2" height="1" src="/site/pixel.gif"/></td></tr></table></td></tr><tr class="s38"><td><table cellspacing="0" cellpadding="0" border="0"><tr><td class="s39"><span id="pSite"></span></td><td class="s28"/></tr></table></td><td valign="bottom" align="right"><table cellpadding="0" cellspacing="0" border="0"><tr><td id="bLogo"></td><td class="s13" id="bMessage">'+getLabel('loadingLabel')+'</td><td class="s28"></td></tr></table></td></tr><tr><td colspan="4" class="pR0 f"><iframe xmlns="http://www.w3.org/1999/xhtml" id="'+nameFrame+'" class="pRf" name="'+nameFrame+'" frameborder="0" marginwidth="0px" marginheight="0px" scrolling="auto" height="100%" width="100%" allowtransparency="true"></iframe></td></tr></table>';
      }
     // custom handlers for Gecko
      if(client.isNS){
        // Special for Netscape
        var ua_ = navigator.userAgent;
        var s_ = "Netscape";
        if ((i = ua_.indexOf(s_)) >= 0) {
          document.onkeydown = bNSKeyDown;
            document.onkeypress = bNSKeyPress;
          document.onkeyup = bNSKeyUp;    
        }else {
          document.onkeypress = bKeyNav;
        }
      }else{
        document.body.onkeydown = bKeyNav;
      }       
    }
    if(client.isGK){
      var rDiv = document.getElementById(nameDiv);
      try {
        // Attach custom scroll event handler for gecko browsers
        rDiv.addEventListener('DOMMouseScroll', bGkScroll, false);
      }catch(ex){     
      }
    }  
  }
  function bNSKeyPress(e){
     if (e.keyCode == 9) {
       e.preventDefault();
       e.stopPropagation();
       if(pCurrentFrame){
         if(bIsShifKey){
           bNavigat(e,-1);
         }else{
           bNavigat(e,+1);
         }
         return true;
       }
     }
   }
  function bNSKeyDown(e){
  if(e.which == 16 ){
      bIsShifKey = true;
    }      
  }
  function bNSKeyUp(e){
    if(e.which == 16 ){
      bIsShifKey = false;
      return true;
    }
  }
  function bKeyNav(e){
    var capture = false;
    if(client.isIE){
      e = event;
      capture = true;
    }else if(e.eventPhase){
      capture = (e.eventPhase==2);
    }
    if(capture){
      if (e.keyCode==9) {
        if(pCurrentFrame){
          if(e.shiftKey){
            bNavigat(e,-1);
          }else{
            bNavigat(e,+1);
          }
          return Cancel(e);
        }
      }else if(client.isGK){
        bCommandKey(e);
      }
    }
  }
  // special gecko
  function bGkScroll(event) {
    if(event.currentTarget.offsetHeight != event.currentTarget.scrollHeight){
      var st = event.currentTarget.scrollTop + (event.detail * 6);
      event.currentTarget.scrollTop = st < 0 ? 0 : st;
      event.preventDefault();
    }
  }
  if (client.isNS) {
    window.onresize = bResize;
  }
  function closeBox(n,c) {
    var i;
    var lData = document.getElementById(nameData);
    var lSep = document.getElementById(nameStep);
    var lTable = lData.firstChild.firstChild.firstChild;
    var lRows = lTable.childNodes;
    var j = 0;
    var i;
    for (i = 0; i < lRows.length ; i++) {
      var elt = lRows[i];
      if (elt.className == n) {
        elt.style.display = 'none';
      } else {
        break;
      }
    }
    if (i == lRows.length-1) {
      lData.style.display = 'none';
      lSep.style.display = 'none';
    }
    var win = frames['$aframe'];
    if (win) {
    var curl = '/search' + '/?' + c + '=0';
    win.document.location = curl;
    }
  }
  function addEngine() {
    if ((typeof window.sidebar == "object") &&
        (typeof window.sidebar.addSearchEngine == "function")){
        var country = "fr";
        var srcFile;
        var imgFile;
        if (country == "fr") {
          srcFile = "exaleadFrance.src";
          imgFile = "exaleadFrance.gif";
        } else {
          country = "com";
          srcFile = "exalead.src";
          imgFile = "exalead.gif";
        }
        var srcFile = 
        window.sidebar.addSearchEngine(
            "http://www.exalead." + country + "/site/" + srcFile,
	    "http://www.exalead." + country + "/site/" + imgFile,  /* icon URL */
            "exalead." + country,	                         /* engine name */
            "Web" ); 
    }	    
    else {
        alert("Mozilla M15 or later is required to add a search engine.");
    }    
  }
function bSetPrevMenu(event) {
  if (bMaximized ==1) {
    document.getElementById("_min").parentNode.style.display = "block";
    document.getElementById("_max").parentNode.style.display = "none";
  }else {
    document.getElementById("_min").parentNode.style.display = "none";
    document.getElementById("_max").parentNode.style.display = "block";
  }
}

function bPrevDBClick(event) {
  if (bMaximized == 1) {
    bMinimize();
  }else {
    bMaximize();
  }
}

function bLimitVSplit() {
  var rDiv = document.getElementById(nameDiv);
  var rData1 = document.getElementById(nameData1);
  var rData2 = document.getElementById(nameData2);
  rData1.style.display = 'none';
  rData2.style.display = '';
  rData2.style.height = '100%';
  document.getElementById("_min").parentNode.style.display = "block";
  document.getElementById("_max").parentNode.style.display = "none";
  pCurrentFrame = frames[nameFrame];
}

function bMaximize() {
  SetCookie('bMaximized', 1);
  bMaximized = 1;
  bLimitVSplit();
  document.getElementById("_min").parentNode.style.display = "block";
  document.getElementById("_max").parentNode.style.display = "none";
}

function bMinimize() {
  bMaximized = 0;
  SetCookie('bMaximized', 0);
  bVSplit(bVSplitRatio);
  document.getElementById("_min").parentNode.style.display = "none";
  document.getElementById("_max").parentNode.style.display = "block";
}
  function getQuery() {
    var elts = document.forms[0].getElementsByTagName('INPUT');
    for (var i = 0 ; i < elts.length ; ++i) {
      if (elts[i].name == "q") {
        return elts[i].value;
      }
    }
    return "";
  }
  var exp = /\$[0-9Q]/g;
  function smartLink(event) {
    var q = getQuery();
    var vals = q.split(/,/g);
    if (vals == null || vals.length == 0) {
      vals = [q]; 
    }
    var lnk = Source(event);
    while(lnk.tagName != 'A') {
      lnk = lnk.parentNode;
    }
    if (lnk) {
      /** replace with actual values. */
      var url = HRef(lnk);
      var result;
      while ((result = exp.exec(url)) != null) {
        var index = result[0].slice(1);
        var replacement = "";
        if (index == "Q" || index == "q" || index == "0") {
          replacement = encodeURIComponent(q); 
        } else if ((index-1) < vals.length) {
          replacement = encodeURIComponent(vals[index-1]);        
        }
        url = url.replace(/\$[0-9Q]/,replacement)
          }
      window.open(url, '_blank');
    }
    return Cancel(event);
  }

function getLabel(id) {
  return document.getElementById(id).innerHTML;
}
sInit();


  // Copyright 2004.2005 (c) Exalead S.A. All rights reserved.
  // Copying or reverse-engineering this code strictly prohitibited.
  var smartupdates = false;
  var smooth = false;
  var deconnect = null;
  var aform = null;
  var submitted = false;
  function Client() {
    var ua, s, i;
    this.isIE = false;
    this.isNS = false;
    this.isGK = false;
    this.version = null;
    ua = navigator.userAgent;
    s = "MSIE";
    if ((i = ua.indexOf(s)) >= 0) {
      this.isIE = true;
      this.version = parseFloat(ua.substr(i + s.length));
      return;
    }
    s = "Netscape6/";
    if ((i = ua.indexOf(s)) >= 0) {
      this.isNS = true;
      this.version = parseFloat(ua.substr(i + s.length));
      return;
    }
    s = "Gecko";
    if ((i = ua.indexOf(s)) >= 0) {
      this.isNS = true;
      this.isGK = true;
      this.version = 6.1;
      return;
    }
  }
  var client = new Client();
  function Cancel(event) {
    if (event) {
      if (client.isIE) {
        event.returnValue = false;
        event.cancelBubble = true;
      } else {
        event.preventDefault();
        event.stopPropagation();
      }
    }
    return false;
  }
  function Deconnect(delay) {
    if (deconnect != null) {
      clearTimeout(deconnect);
      deconnect = null;
    }
    if (delay > 0) {
      deconnect = window.setTimeout('Exec(null, 1, -1)', 1000 * delay);
    }
  }
  function Open(event, url) {
    window.open(url);
    return Cancel(event);
  }
  function Select(obj, beg, end) {
    try {
      if (obj) {
        if (obj.setSelectionRange) {
          obj.focus();
          obj.setSelectionRange(beg, end);
        } else if (obj.createTextRange) {
          var range = obj.createTextRange();
          range.collapse();
          range.moveStart('character', beg);
          range.moveEnd('character', end - beg);
          range.select();
        }
      }
    }
    catch (ex) {
    }
    return false;
  }
  function Focus(id) {
    try {
      if (id) {
        var obj = document.getElementById(id);
        if (obj && obj.focus) {
          if (obj.type == 'text') {
            Select(obj, obj.value.length, obj.value.length);
          } else {
            obj.focus();
          }
        }
      }
    }
    catch (ex) {
    }
    return false;
  }



  function Exec() {
    var args = arguments.length == 1 ? arguments[0] : arguments;
    var nchildren = 0;
    var children = new Array();
    var event = args[0];
    var update = args[1];
    var action = args[2];
    var child = aform.firstChild;
    var shift = event != null && event.shiftKey;
    var disableShift = false;
    var url = (shift || (update && smartupdates)) ? null : Base();
    Deconnect(0);
    if (action == null) {
      aform.A.value = null;
    } else {
      aform.A.value = '' + action;
    }
    while (child != null) {
      if (child.tagName == 'INPUT' &&
          child.name != null &&
          child.name != '' &&
          child.name != 'C' &&
          child.name != 'A' &&
          child.name != 'U') {
        children[nchildren++] = child;
      }
      child = child.nextSibling;
    }
    for (var i = 0 ; i < nchildren ; ++i) {
      aform.removeChild(children[i]);
    }
    for (var i = 3 ; i < args.length ; ) {
      var name = args[i++];
      var value = args[i++];
      if (url == null) {
        if (name == 'A') {
          aform.A.value = value;
        } else {
          var elt = document.createElement('INPUT');
          elt.type = 'hidden';
          elt.name = name;
          elt.value = value;
          aform.appendChild(elt);
        }
      } else if (name != 'C') {
        url += '/';
        url += name;
        url += '=';
        url += encodeURIComponent(name == 'C' ? '1' : value);
      }
      if (name == "disableShift") {
        disableShift = true;
      }
    }
    submitted = true;
    
    if (shift && !disableShift) {
      aform.U.value = '';
      aform.target = '_blank';
      aform.submit();
      return Cancel(event);
    } else if (url) {
      window.location = url;
      window.status = url;
      return Cancel(event);
    } else {
      aform.U.value = '1';
      aform.target = '$aframe';
      aform.submit();
      return Cancel(event);
    }
  }
  function HRef(link) {
    if (client.isIE) {
      var hrefAttribute = link.getAttribute("href", 2);
      return hrefAttribute; 
    } else {
      return link.href;
    }
  }

  function PureSearch(link) {
     return link.search.split('?')[1]
  }
  
  function Follow(event) {
    var i = 3;
    var args = new Array();
    var elt = Source(event);
    while (elt.tagName != 'A') {
      elt = elt.parentNode;
    }
    args[0] = event;
    args[1] = smooth ? 1 : 0;
    args[2] = null;
    var elts = PureSearch(elt).split('&');
    
    for (var j = 0 ; j < elts.length ; ++j) {
      if (elts[j].match(/=/)) {
        var action = elts[j].split('=');
        if (action[0] != 'C') {
          args[i++] = action[0];
          args[i++] = decodeURIComponent(action[1]);
        }
      }
    }
    var followReturn =  Exec(args);
    return followReturn; 
  }
  function Source(event) {
    return client.isIE ? event.srcElement : event.currentTarget;
  }
  function Submit(event) {
    if (event.type == 'keypress' && event.keyCode != 13) {
      return true;
    } else {
      var form = Source(event);
      var child = form.firstChild;
      Deconnect(0);
      submitted = true;
      form.C.value = aform.C.value;
      form.U.value = '1';
      form.target = '$aframe';
      form.submit();
    }
    return Cancel(event);
  }
  function Replace(anode, inode) {
    var node = '<' + inode.nodeName;
    for (var i = 0; i < inode.attributes.length; i++) {
      if (inode.attributes.item(i).nodeValue != null) {
        node += ' '
        node += inode.attributes.item(i).nodeName;
        node += '="';
        node += inode.attributes.item(i).nodeValue;
        node += '"';
      }
    }
    if (inode.childNodes.length == 0 && leafElts[inode.nodeName]) {
      node += '>';
    } else {
      node += '>';
      node += inode.innerHTML;
      node += '<' + inode.nodeName + '>';
    }
    var range = anode.ownerDocument.createRange();
    range.setStartBefore(anode);
    var fragment = range.createContextualFragment(node);
    anode.parentNode.replaceChild(fragment, anode);
  }
  function Delete() {
    if (arguments.length > 0) {
      var alpha = document.getElementById('alpha');
      if (alpha) {
        alpha.style.display = 'none';
      }
    }
    for (var i = 0 ; i < arguments.length ; ++i) {
      var id = arguments[i];
      if (id) {
        var node = document.getElementById(id);
        if (node) {
          node.parentNode.parentNode.removeChild(node.parentNode);
        }
      }
    }
  }
  function Styles() {
    for (var i = 1 ; i < arguments.length ; ++i) {
      var ss = document.createElement('LINK');
      ss.rel = 'stylesheet';
      ss.href = arguments[0] + '/L=' + arguments[i];
      document.documentElement.childNodes[0].appendChild(ss);
    }
  }
  function Scripts() {
    for (var i = 1 ; i < arguments.length ; ++i) {
      var sc = document.createElement('SCRIPT');
      sc.language = 'javascript1.3';
      sc.type = 'text/javascript';
      sc.src = arguments[0] + '/T=' + arguments[i];
      document.documentElement.childNodes[0].appendChild(sc);
    }
  }
  function Reload(args) {
    var child = aform.firstChild;
    var base = document.getElementsByTagName('BASE')[0].href;
    location.href = base.replace(/C=.*/, args);
    return false;
  }
  function Update() {
    var aframe = frames['$aframe'];
    submitted = false;
    window.focus();
    if (aform && aframe) {
      var iform = aframe.document.forms['$iform'];
      if (iform && aform.C && iform.C) {
        aform.C.value = iform.C.value;
        for (var i = 0 ; i < arguments.length ; ++i) {
          var id = arguments[i];
          var inode = aframe.document.getElementById(id);
          if (inode) {
            var dialog = inode.className && inode.className == 'dWindow';
            var anode = document.getElementById(id);
            if (!anode) {
              if (dialog) {
                anode = document.createElement('DIV');
                anode = document.body.appendChild(anode);
                anode.innerHTML = inode.innerHTML;
                anode = anode.firstChild;
                anode.id = id;
                anode.className = 'dWindow';
              }
            } else if (client.isIE) {
              anode.outerHTML = inode.outerHTML;
            } else {
              Replace(anode, inode);
            }
            if (dialog) {
              var alpha = document.getElementById('alpha');
              var dialog = new Dialog(anode);
              if (inode.style.display == 'none') {
                alpha.style.display = 'block';
              }
              dialog.open();
            }
          }
        }
        var win = frames['bFrame'];
        var src = null;
        if (win) {
          src = aframe.document.getElementById('$bFrame').innerHTML;
        }
        aframe.document.body.innerHTML = '';
        if (win && src) {
          win.document.location = src;
        }
      }
    }
  }
  function GetCookie(name, value) {
    var c = document.cookie;
    if (c != null) {
      var list = c.split('; ');
      for (var i = 0 ; i < list.length ; ++i) {
        var p = list[i].split('=');
        if (p[0] == name) {
          return unescape(p[1]);
        }
      }
    }
    return value;
  }
  function SetCookie(name, value) {
    var expires = new Date(2036, 1, 1);
    document.cookie = (name + '=' + escape('' + value) +
                       ';path=/' +
                       ';expires=' + expires.toGMTString());
  }
  function Detach(elt, evt, handler) {
    if (elt.attachEvent) {
      elt.detachEvent('on' + evt, handler);
    } else if (elt.addEventListener) {
      elt.removeEventListener(evt, handler, false);
    }
  }
  function Attach(elt, evt, handler) {
   Detach(elt, evt, handler);    
   if (elt.attachEvent) {
     elt.attachEvent('on' + evt, handler);
   } else if (elt.addEventListener) {
     elt.addEventListener(evt, handler, false);
   }
  }
  function Context() {
    var base = document.getElementsByTagName('BASE')[0].href;
    return base.replace(/.*\/C=/, '').replace(/\/$/, '')
  }
  function Base() {
    return document.getElementsByTagName('BASE')[0].href.replace(/\/$/, '');
  }
  function Init(su, sm) {
    var elts = document.getElementsByName('$');
    smartupdates = su;
    smooth = sm;
    for (var i = 0 ; i < elts.length ; ++i) {
      var elt = elts[i];
      if (elt.tagName == 'A') {
        Attach(elt, 'click', Follow);
      } else if (elt.tagName == 'FORM') {
        Attach(elt, 'submit', Submit);
      }
    }
    if (!aform) {
      var elt;
      var base = document.getElementsByTagName('BASE')[0].href;
      aform = document.forms['$aform'];
      aform.target = '$aframe';
      aform.action = base.replace(/\/C=.*$/, '');
      aform.C.value = decodeURIComponent(base.replace(/.*\/C=/, '').replace(/\/$/, ''));
    }
  }


sInit();

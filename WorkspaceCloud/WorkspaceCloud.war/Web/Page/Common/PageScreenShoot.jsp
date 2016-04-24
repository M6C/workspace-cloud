<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<html>
    <head>
        <title>
            <request:TagPrintAttribut name="msgTitle" scope="request"/>
        </title>
            <link href="/css/page/common/pagescreenshoot.css" rel="stylesheet" type="text/css"></link>
            <script language="javascript" src="/js/page/common/function.js" type="text/javascript"></script>
            <script language="javascript" src="/js/page/common/pagescreenshoot.js" type="text/javascript"></script>
            <script language="javascript" src="/js/page/common/pagescreenshoot_refresh.js" type="text/javascript"></script>
            <script language="javascript" src="/js/page/common/pagescreenshoot_mouse.js" type="text/javascript"></script>
            <script language="javascript" src="/js/page/common/pagescreenshoot_click.js" type="text/javascript"></script>
    </head>
    <noscript>
      <!--
        We have the "refresh" meta-tag in case the user's browser does
        not correctly support JavaScript or has JavaScript disabled.

        Notice that this is nested within a "noscript" block.
      <meta http-equiv="refresh" content="5000">
      -->

    </noscript>
    <body bgcolor="black">
<div id=smile1 style="position:absolute;top:0;left:0"></div>
<script>
//addSmile('smile1');
//moveIt();
</script>
<form name="refreshForm">
      <table width="100%" height="100%">
      <tr>
          <td>
             <font color="white" size="small">Refresh OnClick:</font><input type="checkbox" id="refreshonclick" value="1"/>
             &nbsp;
             <font color="white" size="small">Refresh on:</font><input type="text" id="refreshSec" size="2" value="0"/>&nbsp;<font color="white" size="small">sec</font>
             &nbsp;
             <font color="white" size="small">Quality Rate:</font><input type="text" id="refreshqualityRate" size="2" value="10"/>
             &nbsp;
             <font color="white" size="small">Button:</font>
             <select id="button">
               <option value="1">left</option>
               <option value="2">center</option>
               <option value="3">right</option>
             </select>
             &nbsp;
             <font color="white" size="small">Nb Click:</font><input type="text" id="nbClick" size="2" value="1"/>
             &nbsp;
             <a href="javascript:refresh()"><font color="white" size="small">Refresh Now</font></a>
             &nbsp;
             <div id="divCapsLockOn" style="visibility:hidden"><font color="green" size="small">Caps Lock is on.</font></div>
             <div id="divCapsLockOff" style="visibility:hidden"><font color="red" size="small">Caps Lock is off.</font></div>
           </td>
      </tr>
      <tr>
          <td width="100%" height="100%" align="center">
              <div id="idImageScreen" width="100%" height="100%">
                  <img width='100%' height='100%' id='imageScreen' src='/img/Common/blank.gif'>
              </div>
          </td>
      </tr>
      </table>
</form>
<script language="javascript" type="text/javascript">
initScreenShoot();
refresh();
</script>
    </body>
</html>

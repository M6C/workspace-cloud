<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>
<html>
    <head>
        <title>
            Debugger
            <logic:TagIfDefine name="FileName" scope="request">
            - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/>
            </logic:TagIfDefine>
            - User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
        </title>
      <link href="/css/page/debugger/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/js/page/common/iframe_completion03.js" type="text/javascript"></script>
        <script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
        <script language="javascript" src="/js/EncodingUTF8.js" type="text/javascript"></script>
        <script language="javascript" src="/js/EncodingHTML.js" type="text/javascript"></script>
        <script language="javascript" src="/js/FunctionText.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/debugger/page.js" type="text/javascript"></script>
    </head>
    <body onload="javascript:init();">
        <table cellspacing="0" cellpadding="0">
                <tr>
                    <td colspan="2">
                    <table class="toolBar">
                        <tr>
                            <td>
                                <A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
                                &nbsp;
                                <A href="javascript:openPopup('action.servlet?event=DebuggerBreakpointAdd&class=workspace.service.SrvDebuggerNew&ligne=35', 320, 120)">DebugBreakpointAdd</A>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <form name="GoDebugger" action="action.servlet" method="post">
            <input type="hidden" name="event" value="DebuggerPage"/>
            <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
                <tr valign="top">
                    <td>
                    <jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
                        <jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
                        <jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
                        <jsp:param name="eventDst" value="DebuggerPage"/>
                    </jsp:include>
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=DebuggerPageSelectProjetDir&formNameToSubmit=GoDebugger&formName=GoDebugger&fieldNameDir=pathToExpand&fieldNamePrj=application&application=#R$application#&pathToExpand=#R$pathToExpand#', 'DebuggerPageSelectProjetDir', 300, 370)">...</html:TagA>
                    </td>
                <td>
                    <logic:TagIfDefine name="path" scope="request">
                        <html:TagInput attrType="text" attrName="pathToExpand" attrValue="#R$pathToExpand#" attrSize="100"/>
                        <input type="submit" value="Go"/>
                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=DebuggerPageSelectDir&formNameToSubmit=GoDebugger&formName=GoDebugger&fieldName=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#', 'DebuggerPageSelectDir', 340, 350)">...</html:TagA>
                           </logic:TagIfDefine>
                    <logic:TagIfNotDefine name="path" scope="request">
                        <input type="hidden" name="pathToExpand"/>
                           </logic:TagIfNotDefine>
                </td>
            </tr>
            </form>
           <tr valign="top">
            <td>
                <table cellspacing="0" cellpadding="0">
                    <tr valign="top">
                        <td>
                    <jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
                                <jsp:param name="eventDst" value="DebuggerPage"/>
                            </jsp:include>
                        </td>
                    </tr>
                    <tr><td><IMG height="5px" width="1px" src="/img/TreeView/b.gif"></td></tr>
                    <tr valign="top">
                        <td>
                      <jsp:include page="/Web/Component/TreeView/TreeViewFile_Border01.jsp" flush="true">
                                <jsp:param name="eventDst" value="DebuggerPage"/>
                            </jsp:include>
                        </td>
                    </tr>
                         </table>
                  </td>
            <td>
                <table class="treeview">
                  <form name="ValiderDebugger" action="action.servlet" method="post" onsubmit="javascript:onsumbitform()">
                      <input type="hidden" name="event" value="DebuggerPageSave"/>
                        <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
                            <html:TagInput attrType="hidden" attrName="FileName" attrValue="#R$FileName#"/>
                         <html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
                      <tbody>
                      <tr>
                          <td class="treeviewTopLeft"><IMG height="8px" width="8px" src="/img/TreeView/b.gif"></td>
                          <td class="treeviewTop"></td>
                          <td class="treeviewTopRight"></td>
                      </tr>
                            <tr>
                             <td class="treeviewLeft"></td>
                          <th class="treeviewHeader">
                              <table cellspacing="0" cellpadding="0" width="100%">
                                <tr><th class="treeviewHeader" width="100%" align="center">
                                  <logic:TagIfDefine name="FileName" scope="request">
                                      <html:TagA attrClass="treeviewHeader" attrHref="action.servlet?event=DebuggerPage&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName#&pathToExpand=#R$pathToExpand#">
                                          <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/>
                                      </html:TagA>
                  </logic:TagIfDefine>
                                </th></tr>
                              </table>
                          </th>
                          <td class="treeviewRight"></td>
                      </tr>
                        <tr>
                           <td class="treeviewLeft"></td>
                        <td class="treeviewMain" valign="top">
                <div id="classNameDiv" style="position:absolute;left:0px;top:21px;visibility:hidden;border:solid green 2px;background-color:white;z-index:1"></div>
                <A id="classIdAncre" name="classNameAncre"></A>
                    <textarea style="position:absolute;visibility:hidden;" name="FileEditor" wrap="off"></textarea>
                <iframe id="htmle" name="htmle" height="535" width="650">
                </iframe>
<script language="javascript">
var i=0;
  frames['htmle'].document.open("text/html","replace");
  frames['htmle'].document.write('<html><head>');
  frames['htmle'].document.write('</head>');
  frames['htmle'].document.write('<body>');
  frames['htmle'].document.write('<div>');
  frames['htmle'].document.write('<table width=\'100%\'>');
<file:TagFileReader path="#R$path##R$FileName#">
  frames['htmle'].document.write('<tr><td>'+(i++)+'</td><td><file:TagFileReadLine encoding="HTML" endWithNewLine="false"/></td></tr>');
</file:TagFileReader>
  frames['htmle'].document.write('</table>');
  frames['htmle'].document.write('</div>');
  frames['htmle'].document.write('</body></html>');
  frames['htmle'].document.close();
</script>
                        </td>
                             <td class="treeviewRight"></td>
                      </tr>
                      <tr>
                          <td class="treeviewBottomLeft"></td>
                          <td class="treeviewBottom"></td>
                          <td class="treeviewBottomRight"><IMG height="8px" width="8px" src="/img/TreeView/b.gif"></td>
                            </tr>
                         </tbody>
                  </form>
                </table>
               </td>
        </tr>
      </table>
    </body>
</html>
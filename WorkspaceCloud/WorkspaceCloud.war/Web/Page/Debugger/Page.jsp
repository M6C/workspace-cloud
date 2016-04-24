<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>
<html>
    <head>
        <title>
            Debugger
            <logic:TagIfDefine name="FileName" scope="request">
                <%-- - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/--%>
				- <file:TagFileName path="#R$path##R$FileName#"/>
            </logic:TagIfDefine>
            - User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
        </title>
	    <link href="/css/page/debugger/page.css" rel="stylesheet" type="text/css">
	    <script language="javascript" src="/js/page/common/iframe_completion03.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/common/HSplit.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/EncodingUTF8.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/EncodingHTML.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/FunctionText.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/HTTPObject.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/debugger/page.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/debugger/Breakpoint.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/debugger/BreakpointAdd.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/debugger/BreakpointCheck.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/debugger/BreakpointStep.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/debugger/BreakpointResume.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/editorjava/ReloadMenu.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/editorjava/ReloadDir.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/editorjava/ReloadFile.js" type="text/javascript"></script>
	    <script language="javascript" src="/js/page/editorjava/ReloadDebug.js" type="text/javascript"></script>
    </head>
    <body>
        <table cellspacing="0" cellpadding="0" width="100%" height="100%">
        <tr height="10%" valign="top" align="center">
            <td colspan="2" valign="top">
            <div id="reloadmenu">
                    <jsp:include page="/Web/Component/Menu/Debugger/MenuHeader.jsp" flush="true"/>
			</div>
            </td>
        </tr>
        <form name="GoEditorJava" action="action.servlet" method="post">
        <input type="hidden" name="event" value="EditorJavaPage"/>
        <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
        <input type="hidden" name="pathToExpand"/>
        </form>
        <tr height="*" valign="top">
            <td class="MainLeft">
                <table cellspacing="0" cellpadding="0" width="100%" height="100%">
                    <tr valign="top">
                        <td>
                          <div id="reloaddir">
                            <jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
                                <jsp:param name="eventDst" value="DebuggerPage"/>
                                <jsp:param name="formName" value="GoEditorJava"/>
                                <jsp:param name="formNameToSubmit" value="GoEditorJava"/>
                            </jsp:include>
                          </div>
                        </td>
                    </tr>
                    <tr valign="top">
                        <td>
		                <div id="reloadfile">
                            <jsp:include page="/Web/Component/TreeView/TreeViewFile_Border01.jsp" flush="true">
                                <jsp:param name="eventDst" value="DebuggerPage"/>
                            </jsp:include>
						</div>
                        </td>
                    </tr>
                </table>
            </td>
            <td class="MainRight">
                <table class="treeview">
                            <tr>
                                <td class="treeviewTopLeft"><IMG class="BorderTopLeft" src="/img/TreeView/b.gif"></td>
                                <td class="treeviewTop"></td>
                                <td class="treeviewTopRight"></td>
                            </tr>
                            <tr>
                                <td class="treeviewLeft"></td>
                                <th class="treeviewHeader" height="18px">
                                    <logic:TagIfDefine name="FileName" scope="request">
                                        <html:TagA attrClass="treeviewHeader" attrHref="action.servlet?event=DebuggerPage&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName#&pathToExpand=#R$pathToExpand#">
                                            <%--eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/--%>
                                            <file:TagFileName path="#R$path##R$FileName#"/>
                                        </html:TagA>
                                    </logic:TagIfDefine>
                                </th>
                                <td class="treeviewRight"></td>
                            </tr>
                            <tr>
                            <td class="treeviewLeft"></td>
                            <td class="treeviewMain" valign="top">
                            <div class="main_right" id="text">
                            </div>
                            </td>
                                <td class="treeviewRight"></td>
                            </tr>
                            <tr>
                                <td class="treeviewBottomLeft"></td>
                                <td class="treeviewBottom"></td>
                                <td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/img/TreeView/b.gif"></td>
                            </tr>
                </table>
           </td>
			<script language="javascript">
           <div id="reloaddebug">
               <jsp:include page="/Web/Component/Reload/Reload_Debug_Border01.jsp" flush="true"/>
           </div>
           </script>
<%--
            <%-- Affichage du fichier ligne par ligne --!--%>
            <script language="javascript">
                var i=1;
                var str='<table class=\'file_content\'>';
                var application = '<request:TagPrintAttribut name="application" scope="request"/>';
                var path = '<request:TagPrintAttribut name="pathToExpand" scope="request"/>';
                var fileName = '<request:TagPrintAttribut name="FileName" scope="request"/>';
                var classjava = 'workspace.service.SrvEditorJavaNew';
                var classccs = '';
                var idname = '';
                <file:TagFileReader path="#R$path##R$pathToExpand##R$FileName#">
                  classccs = (((i%2)==0) ? 'file_content': 'file_content_color')
                  idname = (((i%2)==0) ? 'row_select': 'row_select_color')
                  str += '<tr>';
                  str += '<td class=\'file_content_rownum\' onclick=\'javascript:setBreakpoint("'+classjava+'", '+i+')\'><a name="line'+i+'"/>'+i+'</td>';
                  str += '<td class=\''+classccs+'\' onmouseover=\'this.id="'+idname+'";window.status="--> '+application+', '+path+', '+classjava+', '+fileName+', '+i+'"\' onmouseout=\'this.id="";window.status=""\' onclick=\'javascript:setBreakpoint("'+application+'", "'+path+'", "'+classjava+'", "'+fileName+'", '+i+')\'>';
                  str += '<file:TagFileReadLine encoding="HTML" endWithNewLine="false"/>';
                  str += '</td>';
                  str += '</tr>';
                  i++;
                </file:TagFileReader>
              str += '</table>';
                document.getElementById('text').innerHTML=str;
            </script>
            <%-- Affiche les breakpoint dans le fichier --!%>
            <logic:TagIfDefine name="FileName" scope="request">
            <script language="javascript">
                var sourceName;
                var lineNumber;
            <list:TagList name="beanDebug.virtualMachine.eventRequestManager.breakpointRequests" scope="session">
                <list:TagListItem name="breakpoint" scope="request"/>
              <logic:TagIf expression='new java.io.File("#R$FileName#").getName().equals("#R$breakpoint.location.sourceName#")'>
                sourceName = '<request:TagPrintAttribut name="breakpoint.location.sourceName" scope="request"/>';
                lineNumber =  <request:TagPrintAttribut name="breakpoint.location.lineNumber" scope="request"/>;
                showBreakpoint(lineNumber, 'added');
                </logic:TagIf>
            </list:TagList>
            </script>
            </logic:TagIfDefine>
            <%-- Colorization de la ligne où le breakpoint c'est arrete--!%>
            <logic:TagIfDefine name="line" scope="request">
            <script language="javascript">
                var line = <request:TagPrintAttribut name="line" scope="request"/>;
              var td = find_TD_at_Line(line, 1);
          td.id = ((line%2)==0) ? 'row_brk': 'row_color_brk';
          td.onmouseover = '';
          td.onmouseout = '';
          td.onclick = '';
            </script>
            </logic:TagIfDefine>
            <%-- Declanche la verification des breakpoints --!%>
            <logic:TagIfNotDefine name="line" scope="request">
            <script language="javascript">
                Start_BreakpointCheck();
            </script>
            </logic:TagIfNotDefine>
--%>
        </tr>
       </table>
    </body>
</html>
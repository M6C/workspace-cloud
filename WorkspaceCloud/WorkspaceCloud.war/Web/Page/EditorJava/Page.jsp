<%--
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<%@ page pageEncoding="ISO-8859-1"%>
--%>
<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>
<html>
    <head>
<%--
    <meta http-equiv="content-type" content="text/html;charset=ISO-8859-1">
--%>
        <title>
            FileEditor
            <logic:TagIfDefine name="FileName" scope="request">
                <%-- - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/--%>
                - <file:TagFileName path="#R$path##R$FileName#"/>
            </logic:TagIfDefine>
            - User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
        </title>
      <link href="/css/page/editorjava/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/js/page/common/function.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/common/iframe_completion03.js" type="text/javascript"></script>
        <script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
        <script language="javascript" src="/js/EncodingUTF8.js" type="text/javascript"></script>
        <script language="javascript" src="/js/EncodingHTML.js" type="text/javascript"></script>
        <script language="javascript" src="/js/FunctionText.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/page.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadMenu.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadDir.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadFile.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadEditor.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadEditorAppend.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadEditorFilename.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadEditorNavBar.js" type="text/javascript"></script>
    </head>
    <%--logic:TagIf expression='"#R$FileName#".toLowerCase().endsWith(".java")'--%>
    
    <%if ((request.getAttribute("FileName")!=null)&&((String)request.getAttribute("FileName")).toLowerCase().endsWith(".java")) { %>
    	<body onload="javascript:init(true);">
    <%--/logic:TagIf--%>
    <%--logic:TagIf expression='!"#R$FileName#".toLowerCase().endsWith(".java")'--%>
    <%} else { %>
	    <body onload="javascript:init(false);">
    <%}%>
    <%--/logic:TagIf--%>
        <table cellspacing="0" cellpadding="0" width="100%" height="100%">
        <tr height="10%" valign="top" align="center">
            <td colspan="2" valign="top">
                <div id="reloadmenu">
                    <jsp:include page="/Web/Component/Menu/EditorJava/MenuHeader.jsp" flush="true"/>
                </div>
                <div id="reloadeditornavbar">
                    <jsp:include page="/Web/Component/Reload/Reload_Editor_NavBar_Border01.jsp" flush="true"/>
                </div>
            </td>
        </tr>
            <form name="GoEditorJava" action="action.servlet" method="post">
            <input type="hidden" name="event" value="EditorJavaPage"/>
            <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
            <html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
            </form>
            <tr height="*" valign="top">
                <td class="MainLeft" id="lData">
                    <table cellspacing="0" cellpadding="0" width="100%" height="100%">
                        <tr valign="top">
                            <td>
                                <div id="reloaddir">
<%--
              <a href="http://latest.workspacecloud.appspot.com/WorkSpace/action.servlet?event=EditorJavaPage&application=WorkSpace_Dev">
                 <img width="15px" height="14px" src="/img/Common/home_small.gif"/>
              </a>
--%>
                                    <jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
                                        <jsp:param name="eventDst" value="EditorJavaPage"/>
                                        <jsp:param name="formName" value="GoEditorJava"/>
                                        <jsp:param name="formNameToSubmit" value="GoEditorJava"/>
                                    </jsp:include>
                                </div>
                                <script type="text/javascript">
                                    document.getElementById('treeviewDir').scrollTop = document.getElementById('<request:TagPrintAttribut name="myAnchor" scope="request"/>').offsetTop;
                                </script>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td>
                            <div id="reloadfile">
                                <jsp:include page="/Web/Component/TreeView/TreeViewFile_Border01.jsp" flush="true">
                                    <jsp:param name="eventDst" value="EditorJavaPage"/>
                                </jsp:include>
                            </div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="MainRight" id="rData1">
                    <table class="treeview">
                        <form name="ValiderEditorJava" action="action.servlet" method="post">
                            <input type="hidden" name="event" value="EditorJavaPageSave"/>
                            <input type="hidden" name="len" id="len"/>
                                <tr>
                                    <td class="treeviewTopLeft"><IMG class="BorderTopLeft" src="/img/TreeView/b.gif"></td>
                                    <td class="treeviewTop"></td>
                                    <td class="treeviewTopRight"></td>
                                </tr>
                                <tr>
                                    <td class="treeviewLeft">
                                          <A id="classIdAncre" name="classNameAncre"></A>
                                    </td>
                                    <th class="treeviewHeader">
                                        <table class="treeview" cellspacing="0" cellpadding="0">
                                            <tr>
                                                <th class="treeviewHeader" width="10%">
                                                    &nbsp;
                                                    <logic:TagIfDefine name="FileName" scope="request">
													   <%--logic:TagIf expression='"#R$FileName#".toLowerCase().endsWith(".java")'--%>
													   <%if ((request.getAttribute("FileName")!=null)&&((String)request.getAttribute("FileName")).toLowerCase().endsWith(".java")) { %>
                                                            <html:TagA attrHref="javascript:updateIframe(true)">
                                                                <img unselectable="on" width="15px" height="18px" class="buttonOut" align="absmiddle" src="/img/Editor/ed_colorize.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Colorize"/>
                                                            </html:TagA>
                                                       <%} %>
													   <%--/logic:TagIf--%>
                                                    </logic:TagIfDefine>
                                                </th>
                                                <th class="treeviewHeader" width="80%">
                                                    <div id="reloadeditorfilename">
                                                        <jsp:include page="/Web/Component/Reload/Reload_Editor_Filename_Border01.jsp" flush="true">
                                                            <jsp:param name="paramOther" value="&navIndex=#R$navIndex#&navNbRow=#R$navNbRow#"/>
                                                        </jsp:include>
                                                    </div>
                                                </th>
                                                <th class="treeviewHeader" width="10%" align="right">
                                                    <html:TagA attrHref="javascript:save()">
                                                        <img unselectable="on" width="38px" height="15px" class="buttonOut" align="absmiddle" src="/img/Style/Classic/Button/Button_Save.gif" title="Save"/>
                                                    </html:TagA>
                                                </th>
                                            </tr>
                                        </table>
                                    </th>
                                    <td class="treeviewRight"></td>
                                </tr>
                                <tr>
                                    <td class="treeviewLeft"></td>
                                    <td class="treeviewMain" valign="top">
                                          <textarea class="numberline" id="numberline" contentEditable="false"></textarea>
                                          <div id="classNameDiv" style="position:absolute;left:0px;top:21px;visibility:hidden;border:solid green 2px;background-color:white;z-index:1"></div>
                                          <A id="classIdAncre" name="classNameAncre"></A>
                                          <textarea style="position:absolute;visibility:hidden;" name="FileEditor" wrap="off"></textarea>
                                          <iframe id="htmle" name="htmle" height="100%" width="100%" FRAMEBORDER="0px" class="texteditor" MARGINWIDTH="0px" MARGINHEIGHT="0px"></iframe>
                                    </td>
                                    <td class="treeviewRight"></td>
                                </tr>
                                <tr>
                                    <td class="treeviewBottomLeft"></td>
                                    <td class="treeviewBottom"></td>
                                    <td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/img/TreeView/b.gif"></td>
                                </tr>
                        </form>
                    </table>
                    <script language="javascript" type="text/javascript">
                    <%--div id="reloadeditor"--%>
                        <jsp:include page="/Web/Component/Reload/Reload_Editor_Border01.jsp" flush="true">
                            <jsp:param name="eventDst" value="EditorJavaPage"/>
                        </jsp:include>
                    <%--/div--%>
                    </script>
<%--
                    <script language="javascript" type="text/javascript">
                    function StartTheTimer() {
                        frames['htmle'].document.body.onscroll = function() {
                            document.getElementById('numberline').scrollTop = frames['htmle'].document.body.scrollTop;
                        }
                    }
                    self.setTimeout("StartTheTimer()", 10)
                    </script>
--%>
               </td>
        </tr>
       </table>
    </body>
</html>

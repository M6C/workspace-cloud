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
            Image Viewer
            <logic:TagIfDefine name="FileName" scope="request">
                - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/>
            </logic:TagIfDefine>
            - User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
        </title>
    	<link href="/WorkSpace/css/page/imageviewer/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/WorkSpace/js/page/common/function.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/imageviewer/page.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/EncodingUTF8.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/EncodingHTML.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/FunctionText.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/editorjava/ReloadMenu.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/editorjava/ReloadDir.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/editorjava/ReloadFile.js" type="text/javascript"></script>
    </head>
    <body>
        <table cellspacing="0" cellpadding="0" width="100%" height="100%">
        <tr height="10%" valign="top" align="center">
            <td colspan="2" valign="top">
                <div id="reloadmenu">
                    <jsp:include page="/Web/Component/Menu/ImageViewer/MenuHeader.jsp" flush="true"/>
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
                                    <jsp:param name="eventDst" value="ImageViewerPage"/>
                                    <jsp:param name="fileListScope" value="request"/>
                                </jsp:include>
							</div>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="MainRight">
                <div id="reloadfile">
                    <jsp:include page="/Web/Component/TreeView/TreeViewImage_Border02.jsp" flush="true">
                        <jsp:param name="eventDst" value="ImageViewerPage"/>
                        <jsp:param name="fileListScope" value="request"/>
                    </jsp:include>
				</div>
               </td>
        </tr>
       </table>
    </body>
</html>
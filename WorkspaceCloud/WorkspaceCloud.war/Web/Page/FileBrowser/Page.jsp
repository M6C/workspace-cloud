<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>
<html>
	<head>
		<title>
			FileBrowser
			<logic:TagIfDefine name="FileName" scope="request">
                <%-- - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/--%>
                - <file:TagFileName path="#R$path##R$FileName#"/>
			</logic:TagIfDefine>
			- User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
		</title>
    	<link href="/css/page/filebrowser/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/js/page/common/function.js" type="text/javascript"></script>
		<script language="javascript" src="/js/page/filebrowser/page.js" type="text/javascript"></script>
		<script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
		<script language="javascript" src="/js/EncodingUTF8.js" type="text/javascript"></script>
		<script language="javascript" src="/js/EncodingHTML.js" type="text/javascript"></script>
		<script language="javascript" src="/js/FunctionText.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadMenu.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadDir.js" type="text/javascript"></script>
        <script language="javascript" src="/js/page/editorjava/ReloadFile.js" type="text/javascript"></script>
	</head>
	<body>
		<table cellspacing="0" cellpadding="0" width="100%" height="100%">
	    <tr height="10%" valign="top" align="center">
		    <td colspan="2" valign="top">
            <div id="reloadmenu">
				<jsp:include page="/Web/Component/Menu/FileBrowser/MenuHeader.jsp" flush="true"/>
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
									<jsp:param name="eventDst" value="FileBrowserPage"/>
									<jsp:param name="fileListScope" value="request"/>
								</jsp:include>
							</div>
							</td>
						</tr>
					</table>
				</td>
				<td class="MainRight">
                <div id="reloadfile">
					<jsp:include page="/Web/Component/TreeView/TreeViewFileExt_Border01.jsp" flush="true">
						<jsp:param name="eventDst" value="FileBrowserPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
				</div>
   			</td>
    	</tr>
   	</table>
	</body>
</html>

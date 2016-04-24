<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>
<html>
	<head>
		<title>
            Versionning
			<logic:TagIfDefine name="FileName" scope="request">
                <%-- - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/--%>
                - <file:TagFileName path="#R$path##R$FileName#"/>
			</logic:TagIfDefine>
			- User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
		</title>
	    <link href="/css/page/versioning/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/js/page/common/function.js" type="text/javascript"></script>
		<script language="javascript" src="/js/page/versioning/page.js" type="text/javascript"></script>
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
<%--
				<img class="buttonOut" src="/img/Versionning/cvs_logo.gif" alt="CVS"/>
--%>
            <div id="reloadmenu">
				<jsp:include page="/Web/Component/Menu/Versioning/MenuHeader.jsp" flush="true"/>
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
									<jsp:param name="eventDst" value="VersionPage"/>
									<jsp:param name="fileListScope" value="request"/>
								</jsp:include>
							</div>
							</td>
						</tr>
					</table>
				</td>
				<td class="MainRight">
                <div id="reloadfile">
					<jsp:include page="/Web/Component/TreeView/TreeViewFileVersioning.jsp" flush="true">
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
				</div>
				</td>
			</tr>
   	</table>
	</body>
</html>



<%--



<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<html>
    <head>
        <title>
            Versionning
        </title>
	    <link href="/css/page/versioning/page.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/js/page/versioning/page.js" type="text/javascript"></script>
		<script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
	</head>
	<body>
		<table class="memo">
			<tr valign="top">
<%--
			  <td>
			    <A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
			  </td>
--%!>
			  <logic:TagIfDefine name="application" scope="request">
			  <td align="right">
			    <jsp:include page="/Web/Component/Menu/Versioning/MenuHeader.jsp" flush="true"/>
			  </td>
			  </logic:TagIfDefine>
			</tr>
            <form name="GoVersionning" action="action.servlet" method="post">
	    		<input type="hidden" name="event" value="VersionPage"/>
	    		<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
	    		<tr valign="top">
				  <td>
					<jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
						<jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
						<jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="paramOther" value="&includeSubDirectory=#R$includeSubDirectory#"/>
					</jsp:include>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDir&formNameToSubmit=GoVersionning&formName=GoVersionning&fieldNameDir=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#&includeSubDirectory=#R$includeSubDirectory#', 'VersionningPageSelectProjetDir', 300, 370)">...</html:TagA>
				  </td>
				  <td>
						<html:TagInput attrType="text" attrName="pathToExpand" attrValue="#R$pathToExpand#" attrSize="100"/>
						<input type="submit" value="Go"/>
        					<html:TagInput attrType="CHECKBOX" attrName="includeSubDirectory" attrValue="true" initFromRequestName="includeSubDirectory"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=GoVersionning&formName=GoVersionning&fieldName=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#&includeSubDirectory=#R$includeSubDirectory#', 'VersionPageSelectDir', 340, 350)">...</html:TagA>
				  </td>
	    		</tr>
			</form>
	    		<tr valign="top">
			    	<td>
          	          <jsp:include page="/Web/Component/TreeView/TreeViewDirVersioning.jsp" flush="true">
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="fileListScope" value="request"/>
					  </jsp:include>
    				</td>
			    	<td>
					<jsp:include page="/Web/Component/TreeView/TreeViewFileVersioning.jsp" flush="true">
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
	    			</td>
		    	</tr>
		</table>
	</body>
</html>
--%>
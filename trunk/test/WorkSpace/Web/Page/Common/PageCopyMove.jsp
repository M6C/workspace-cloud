<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%String paramOther = java.net.URLEncoder.encode("&pathSrc="+request.getParameter("pathSrc"));%>

<logic:TagIf expression='new java.io.File("#R$pathSrc#").isFile()'>
	<request:TagDefineAttribute scope='request' name='pathToExpand' expression='new java.io.File(&quot;#R$pathSrc#&quot;).getParentFile().toURI().getPath()' doEval="true"/>
</logic:TagIf>
<logic:TagIf expression='new java.io.File("#R$pathSrc#").isDirectory()'>
	<request:TagDefineAttribute scope="request" name="pathToExpand" expression="#R$pathSrc#"/>
</logic:TagIf>

<html>
	<head>
		<title>
			Copy/Move File
		</title>
	        <link href="/WorkSpace/css/page/common/pagecopymove.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/WorkSpace/js/page/common/pagecopymove.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
	        <form name="EditorJavaCopyMove" action="action.servlet" onSubmit="javaScript:form_submit(this);">
			<html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageCopyMoveValider"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<table width="350px">
				<tr>
		    			<td>
						    <font class="input_title_inverse">From&nbsp;:</font>
				    	</td>
		    			<td>
						<html:TagInput attrType="text" attrName="pathSrc" attrValue="#R$pathSrc#" attrSize="40"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=EditorJavaCopyMove&fieldName=pathSrc&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
    				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">To&nbsp;:</font>
				    	</td>
		    			<td>
						<html:TagInput attrType="text" attrName="pathDst" attrValue="#R$pathDst#" attrSize="40"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=EditorJavaCopyMove&fieldName=pathDst&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
    				</tr>
				<tr>
		    			<td align="center" colspan="2">
						<select name="operation">
							<option value="copy">Copy</option>
							<option value="move">Move</option>
						</select>
						<input type="submit" value="Go"/>
				    	</td>
    				</tr>
			</table>
        	</form>
	</body>
</html>

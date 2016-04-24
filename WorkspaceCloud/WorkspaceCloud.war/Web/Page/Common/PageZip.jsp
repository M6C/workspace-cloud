<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%String paramOther = java.net.URLEncoder.encode("&pathSrc="+request.getParameter("pathSrc"));%>
<html>
	<head>
		<title>
			Make Zip
		</title>
	        <link href="/css/page/common/pagezip.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/js/page/common/pagezip.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
	        <form name="EditorJavaZip" action="action.servlet" onSubmit="javaScript:form_submit(this);">
			<html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageZipValider"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<table width="350px">
				<tr>
		    			<td>
						    <font class="input_title_inverse">From&nbsp;:</font>
				    	</td>
		    			<td>
						<html:TagInput attrType="text" attrName="pathSrc" attrValue="#R$pathSrc#" attrSize="40"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=EditorJavaZip&fieldName=pathSrc&path=#R$path#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
    				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">To&nbsp;:</font>
				    	</td>
		    			<td>
						<html:TagInput attrType="text" attrName="pathDst" attrValue="#R$pathDst#" attrSize="40"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=EditorJavaZip&fieldName=pathDst&path=#R$path#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
    				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">Zip&nbsp;Name</font>
				    	</td>
		    			<td>
						<html:TagInput attrName="fileName" attrValue="#R$fileName#"/>
				    	</td>
    				</tr>
				<tr>
		    			<td align="center" colspan="2">
						<input type="submit" value="Go"/>
				    	</td>
    				</tr>
			</table>
        	</form>
	</body>
</html>

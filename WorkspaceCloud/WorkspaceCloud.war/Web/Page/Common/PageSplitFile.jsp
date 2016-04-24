<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="xml" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%--
<logic:TagIfDefine name="xmlResult" scope="request">
  <request:TagPrintAttribut name="xmlResult" scope="request"/>
</logic:TagIfDefine>

<logic:TagIfNotDefine name="xmlResult" scope="request">
--%>
<%String paramOther = java.net.URLEncoder.encode("&pathSrc="+request.getParameter("pathSrc"));%>

<html>
	<head>
		<title>
			Split File
		</title>
	        <link href="/css/page/common/pagesplitfile.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/js/page/common/pagesplitfile.js" type="text/javascript"></script>
		<script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
	<table width="100%"><tr><td align="center">
	    <form name="EditorJavaXmlXsl" action="action.servlet"><%--onSubmit="javaScript:form_submit(this);">--%>
	    <input type="hidden" name="attributName" value="xmlResult">
			<html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaSplitFileValider"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
			<table width="400px">
				<tr>
		    			<td colspan="2" align="center">
						    &nbsp;
				    	</td>
			   			<td align="center" valign="middle" rowspan="3">
							<input type="submit" value="Go"/>
				    	</td>
 				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">File&nbsp;:</font>
				    	</td>
		    			<td>
							<html:TagInput attrType="text" attrName="pathFile" attrValue="#R$pathFile#" attrSize="40"/>
							<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=EditorJavaXmlXsl&fieldNamePrj=application&fieldNameDir=pathToExpand&fieldNameFile=pathFile&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
 				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">Number&nbsp;of&nbsp;line&nbsp;:</font>
				    	</td>
		    			<td>
							<html:TagInput attrType="text" attrName="lineNumber" attrValue="#R$lineNumber#" attrSize="10"/>
				    	</td>
 				</tr>
			</table>
    </form>
    </td></tr>
	<logic:TagIfDefine name="fileList" scope="request" checkNotEmpty="true">
    <tr><td>
	    <table class="global">
		    <tr><td class="global">
			    <table class="message" id="messageTable">
				    <tr><td class="title">
						File list
					</td></tr>
				    <tr><td class="message" id="messageCell">
					    <div id="messageScroll">
							<table class="fileList">
							<list:TagList name="fileList" scope="request">
								<list:TagListItem name="file" scope="request"/>
								<tr>
						    	<td><request:TagPrintAttribut name="file.name" scope="request"/></td>
						    	<td><request:TagPrintAttribut name="file.length" scope="request"/></td>
						    	</tr>
				    		</list:TagList>
				    		</table>
						</div>
					</td></tr>
			    </table>
			</td></tr>
	    </table>
    </td></tr>
    </logic:TagIfDefine>
    </table>
	</body>
</html>
<%--
</logic:TagIfNotDefine>
--%>
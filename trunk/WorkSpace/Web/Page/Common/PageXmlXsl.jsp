<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="xml" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>
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
			Transforme XML/XSL
		</title>
	        <link href="/WorkSpace/css/page/common/pagexmlxsl.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/WorkSpace/js/page/common/pagexmlxsl.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
		<script type="text/javascript">
			function updateXslParameter() {
				document.EditorJavaXmlXsl.target = '_self';
				document.EditorJavaXmlXsl.event.value = 'EditorJavaPageXmlXsl';
				document.EditorJavaXmlXsl.submit();
			}
		</script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
	<table width="100%"><tr><td align="center">
	    <form name="EditorJavaXmlXsl" action="action.servlet" target="_blank"><%--onSubmit="javaScript:form_submit(this);">--%>
	    <input type="hidden" name="attributName" value="xmlResult">
			<html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageXmlXslValider"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
			<table width="350px">
				<tr>
		    			<td colspan="2" align="center">
						    <font class="input_title_inverse" size="12">Xml</font>
				    	</td>
			   			<td align="center" rowspan="6">
								<input type="submit" value="Go"/>
				    	</td>
 				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">File&nbsp;:</font>
				    	</td>
		    			<td>
								<html:TagInput attrType="text" attrName="pathXml" attrValue="#R$pathXml#" attrSize="40"/>
								<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=EditorJavaXmlXsl&fieldNamePrj=application&fieldNameDir=pathToExpand&fieldNameFile=pathXml&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
 				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">Name&nbsp;:</font>
				    	</td>
		    			<td>
								<html:TagInput attrType="text" attrName="xmlName" attrValue="#R$xmlName#" attrSize="40"/>
				    	</td>
 				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">Scope&nbsp;:</font>
				    	</td>
		    			<td>
								<select name="xmlScope">
									<option value="Request">Request</option>
									<option value="Session" selected>Session</option>
								</select>
				    	</td>
 				</tr>
				<tr>
		    			<td colspan="2" align="center">
						    <font class="input_title_inverse" size="12">Xsl</font>
				    	</td>
 				</tr>
				<tr>
		    			<td>
						    <font class="input_title_inverse">File&nbsp;:</font>
				    	</td>
		    			<td>
								<html:TagInput attrType="text" attrName="pathXsl" attrValue="#R$pathXsl#" attrSize="40"/>
								<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=EditorJavaXmlXsl&fieldNamePrj=application&fieldNameDir=pathToExpand&fieldNameFile=pathXsl&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				    	</td>
    				</tr>
				<tr>
				<logic:TagIfDefine name="pathXsl" scope="request" checkNotEmpty="true">
					<%-- Format le chemin du Xsl par rapport à l'application --%>
					<path:TagPathFormat name="pathXsl" scope="request" application="#R$application#"/>
					<%-- Transformation Xsl par rapport à un Xml d'un fichier --%>
					<xml:TagXsl xml="#R$pathXsl#" xsl="Xsl/Parameter/DomXslParameter.xsl">
						<xml:TagXslResultDom name="xslParamDom" scope="session"/>
					</xml:TagXsl>
					<logic:TagIfDefine name="xslParamDom" scope="session">
				<tr>
					<td align="center" colspan="3">
				    <a href="javascript:updateXslParameter()"><font class="input_title_inverse">Xsl&nbsp;parameter</font></a>
					</td>
 				</tr>
				<tr>
					<td>
					  <input type="hidden" name="xslParamName" value="<xml:TagXml name="xslParamDom" scope="session" path="/XSL-PARAM/PARAM"><xml:TagXmlValue path="@name"/>;</xml:TagXml>"/>
						<xml:TagXml name="xslParamDom" scope="session" path="/XSL-PARAM/PARAM">
							<font class="input_title_inverse"><xml:TagXmlValue path="@name"/>&nbsp;:</font>
							</td><td><input name="xsp<xml:TagXmlValue path="@name"/>" size="30"></td></tr><tr><td>
						</xml:TagXml>
					</td>
 				</tr>
					</logic:TagIfDefine>
 				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="pathXsl" scope="request" checkNotEmpty="true">
				<tr>
					<td align="center" colspan="3">
				    <a href="javascript:updateXslParameter()"><font class="input_title_inverse">Xsl&nbsp;parameter</font></a>
					</td>
 				</tr>
 				</logic:TagIfNotDefine>
			</table>
    </form>
    </td></tr></table>
	</body>
</html>
<%--
</logic:TagIfNotDefine>
--%>
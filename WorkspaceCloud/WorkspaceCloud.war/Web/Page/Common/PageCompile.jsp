<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="xml" %>
<%String paramOther = java.net.URLEncoder.encode("&pathSrc="+request.getParameter("pathSrc"));%>

<xml:TagXsl xmlName="resultDom" xmlScope="session" xsl="/Xsl/User/Application/Paths/Path/FindByName.xsl">
	<xml:TagXslParameter name="pLogin" value="#S$BeanAuthentification:login#"/>
	<xml:TagXslParameter name="pPassword" value="#S$BeanAuthentification:password#"/>
	<xml:TagXslParameter name="pApplication" value="#R$application#"/>
	<xml:TagXslParameter name="pPath" value="Class"/>
	<xml:TagXslResult name="pathDst" scope="request"/>
</xml:TagXsl>

<html>
	<head>
		<title>
			Compile a Java class
		</title>
	  <link href="/css/page/common/pagecompile.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/js/page/common/pagecompile.js" type="text/javascript"></script>
		<script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
	  <form name="EditorJavaCompile" action="action.servlet" onSubmit="javaScript:form_submit(this);">
			<html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageCompileValider"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<table width="340px">
				<tr>
		      <td>
					  <font class="input_title_inverse">Class&nbsp;:</font>
				  </td>
		    	<td>
						<html:TagInput attrType="text" attrName="pathSrc" attrValue="#R$pathSrc#" attrSize="40"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=EditorJavaCompile&fieldName=pathSrc&path=#R$path#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				  </td>
    		</tr>
				<tr>
		      <td>
					  <font class="input_title_inverse">To&nbsp;:</font>
				  </td>
		    	<td>
						<html:TagInput attrType="text" attrName="pathDst" attrValue="#R$pathDst#" attrSize="40"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=EditorJavaCompile&fieldName=pathDst&path=#R$path#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
				  </td>
    		</tr>
				<tr>
		    	<td align="center" colspan="2">
						<input type="submit" value="Go"/>
						<logic:TagIfDefine name="traceOut" scope="request">
							<html:TagA attrHref="javascript:openPopup('action.servlet?event=PageMessage&msgTitle=Compile+trace&msgText=#R$traceOut<encoding=HTML>#', 'traceCompile', 800, 480)">...</html:TagA>
<%--
							<html:TagA attrHref="javascript:openPopup('action.servlet?event=PageMessage&msgTitle=Compile+trace&msgText=#R$traceOut<encoding=HTMLSpecialChars>#', 'traceCompile', 800, 480)">...</html:TagA>
							<html:TagA attrHref="javascript:openPopup('action.servlet?event=PageMessage&msgTitle=Compile+trace&msgText=#R$traceOut<encoding=HTMLEntities>#', 'traceCompile', 800, 480)">...</html:TagA>
--%>
						</logic:TagIfDefine>
				  </td>
    		</tr>
			</table>
    </form>
	</body>
</html>

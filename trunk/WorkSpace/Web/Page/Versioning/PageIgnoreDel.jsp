<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="Xml" %>
<html>
	<head>
		<title>
			Ignore Del
		</title>
	        <link href="/WorkSpace/css/page/versioning/pageignoredel.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/WorkSpace/js/page/versioning/pageignoredel.js" type="text/javascript"></script>
	</head>
	<body>
		<form action="action.servlet">
			<input type="hidden" name="event" value="VersionIgnoreDelValider"/>
                      	<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<table class="memo">
		    		<tr valign="top">
				    	<td>
          		        		<font class="input_title_inverse">Path</font>
    					</td>
				    	<td>
						<html:TagInput attrName="fileName" attrValue="#R$fileName#"/>
	    				</td>
		    		</tr>
		    		<tr valign="top">
				    	<td colspan="2">
						<input type="submit"/>
	    				</td>
		    		</tr>
        		</table>
                        <jsp:include page="/Web/Component/Form/VersionningMessage.jsp" flush="true"/>
		</form>
	</body>
</html>

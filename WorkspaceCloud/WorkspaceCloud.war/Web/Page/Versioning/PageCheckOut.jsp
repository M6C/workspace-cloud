<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<html>
    <head>
        <title>
            Check Out
        </title>
	        <link href="/css/page/versioning/pagecheckout.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/js/page/versioning/pagecheckout.js" type="text/javascript"></script>
	</head>
	<body>
		<form action="action.servlet">
			<input type="hidden" name="event" value="VersionCheckOutValider"/>
                      	<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
			<table class="memo">
				<logic:TagIfDefine name="jcvsErrorMessage" scope="request">
		    		<tr valign="top">
				    	<td colspan="2">
						<request:TagPrintAttribut name="jcvsErrorMessage" scope="request"/>
	    				</td>
		    		</tr>
				</logic:TagIfDefine>
		    		<tr valign="top">
				    	<td>
          		        		<font class="input_title_inverse">Recursive</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="recursive" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="recursive" attrValue="#R$recursive#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="recursive" scope="request" checkNotEmpty="true">
							<input name="recursive" value="true"/>
						</logic:TagIfNotDefine>
	    				</td>
		    		</tr>
		    		<tr valign="top">
				    	<td colspan="2">
						<input type="submit"/>
	    				</td>
		    		</tr>
                                <jsp:include page="/Web/Component/Form/VersionningParameter.jsp" flush="true"/>
        		</table>
                        <jsp:include page="/Web/Component/Form/VersionningMessage.jsp" flush="true"/>
		</form>
	</body>
</html>

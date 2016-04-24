<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<html>
    <head>
        <title>
            Import project
        </title>
	        <link href="/css/page/versioning/pageimport.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/js/page/versioning/pageimport.js" type="text/javascript"></script>
	</head>
	<body>
		<form action="action.servlet">
			<input type="hidden" name="event" value="VersionImportValider"/>
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
          		        		<font class="input_title_inverse">Vendor Tag</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="vendorTag" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="vendorTag" attrValue="#R$vendorTag#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="vendorTag" scope="request" checkNotEmpty="true">
							<input name="vendorTag" value="vendor"/>
						</logic:TagIfNotDefine>
	    				</td>
		    		</tr>
		    		<tr valign="top">
				    	<td>
          		        		<font class="input_title_inverse">Release Tag</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="releaseTag" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="releaseTag" attrValue="#R$releaseTag#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="releaseTag" scope="request" checkNotEmpty="true">
							<input name="releaseTag" value="release"/>
						</logic:TagIfNotDefine>
	    				</td>
		    		</tr>
		    		<tr valign="top">
				    	<td>
          		        		<font class="input_title_inverse">Message</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="messageStr" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="messageStr" attrValue="#R$messageStr#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="messageStr" scope="request" checkNotEmpty="true">
							<input name="messageStr" value="Message"/>
						</logic:TagIfNotDefine>
	    				</td>
		    		</tr>
				<tr valign="top">
				    	<td>
          		        		<font class="input_title_inverse">Auto Update</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="autoupdate" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="autoupdate" attrValue="#R$autoupdate#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="autoupdate" scope="request" checkNotEmpty="true">
							<input name="autoupdate" value="true"/>
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

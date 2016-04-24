<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="Xml" %>
<html>
	<head>
		<title>
			Remove Directory
		</title>
	        <link href="/css/page/versioning/pageremovedirectory.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/js/page/versioning/pageremovedirectory.js" type="text/javascript"></script>
	</head>
	<body>
		<form action="action.servlet">
			<input type="hidden" name="event" value="VersionRemoveDirectoryValider"/>
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
          		        		<font class="input_title_inverse">Path</font>
    					</td>
				    	<td>
						<html:TagInput attrName="fileName" attrValue="#R$fileName#"/>
	    				</td>
		    		</tr>
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
				    	<td>
          		        		<font class="input_title_inverse">Delete before remove</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="deletefirst" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="deletefirst" attrValue="#R$deletefirst#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="deletefirst" scope="request" checkNotEmpty="true">
							<input name="deletefirst" value="true"/>
						</logic:TagIfNotDefine>
	    				</td>
		    		</tr>
				<tr valign="top">
				    	<td>
          		        		<font class="input_title_inverse">Auto Commit</font>
    					</td>
				    	<td>
						<logic:TagIfDefine name="autocommit" scope="request" checkNotEmpty="true">
							<html:TagInput attrName="autocommit" attrValue="#R$autocommit#"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="autocommit" scope="request" checkNotEmpty="true">
							<input name="autocommit" value="true"/>
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

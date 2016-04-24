<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<html>
    <head>
        <title>
            CVS Help
        </title>
	        <link href="/css/page/versioning/pageimport.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/js/page/versioning/pageimport.js" type="text/javascript"></script>
	</head>
	<body>
		<form action="action.servlet">
			<input type="hidden" name="event" value="VersionHelp"/>
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
          		        		<font class="input_title_inverse">Project Name</font>
    					</td>
				    	<td>
						<input name="keyPrj"/>
	    				</td>
		    		</tr>
		    		<tr valign="top">
				    	<td colspan="2">
						<input type="submit"/>
	    				</td>
		    		</tr>
        		</table>
		</form>
	</body>
</html>

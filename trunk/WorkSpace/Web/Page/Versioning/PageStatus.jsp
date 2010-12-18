<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>
<html>
    <head>
        <title>
            Status Information
        </title>
	        <link href="/WorkSpace/css/page/versioning/pagestatus.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/WorkSpace/js/page/versioning/pagestatus.js" type="text/javascript"></script>
	</head>
	<body>
                        <versionning:TagStatus application="#R$application#" path="#R$path#" name="statusInformation" scope="request"/>
			<table class="memo">
		    		<tr valign="top">
				    	<td>
						<request:TagPrintAttribut name="statusInformation" scope="request"/>
	    				</td>
		    		</tr>
        		</table>
	</body>
</html>

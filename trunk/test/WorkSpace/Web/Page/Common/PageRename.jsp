<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<html>
    <head>
        <title>
            Rename
        </title>
	        <link href="/WorkSpace/css/page/common/pagerename.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/WorkSpace/js/page/common/pagerename.js" type="text/javascript"></script>
    </head>
    <body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
        <form name="EditorJavaRename" action="action.servlet" onSubmit="javaScript:form_submit(this);">
		<html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageRenameValider"/>
		<html:TagInput attrType="hidden" attrName="oldName" attrValue="#R$oldName#"/>
		<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
	    	<table>
		    	<tr>
			    	<td align="center">
			    		<font class="input_title_inverse">Name</font>
		    		</td>
	    		</tr>
		    	<tr>
			    	<td>
					<html:TagInput attrType="text" attrName="newName" attrSize="40" attrValue="#R$newName#"/>
		    		</td>
	    		</tr>
		    	<tr>
			    	<td align="center">
					<input type="submit"/>
			    	</td>
		    	</tr>
	        </table>
        </form>
    </body>
</html>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<html>
    <head>
        <title>
            Reboot Server
        </title>
    </head>
    <body bgcolor="buttonface">
        <form action="action.servlet">
          <input type="hidden" name="event" value="AdminPageExecRebootValider"/>
	    	<table>
		    	<tr>
			    	<td align="center">
			    		<font class="input_title_inverse">Command Line</font>
		    		</td>
	    		</tr>
		    	<tr>
			    	<td>
					<logic:TagIfDefine name="commandLine" scope="request">
						<html:TagInput attrType="text" attrName="commandLine" attrSize="40" attrValue="#R$commandLine#"/>
					</logic:TagIfDefine>
					<logic:TagIfNotDefine name="commandLine" scope="request">
<%--
						<input type="text" name="commandLine" size="40" value="shutdown -r -f -t 20"/>
--%>
						<input type="text" name="commandLine" size="40" value="D:/Dev/Travaux/Java/JBuilder8/exe/rebooter_reboot.bat"/>
					</logic:TagIfNotDefine>
		    		</td>
	    		</tr>
		    	<tr>
			    	<td align="center">
					<input type="submit"/>
			    	</td>
		    	</tr>
	        </table>
        </form>
<html:TagFont content="#R$resultCommandLine#"/>
	<logic:TagIfDefine name="resultCommandLine" scope="request">
	    	<table>
		    	<hr>
			    	<td>
					<html:TagTextarea content="#R$resultCommandLine#" attrCols="40" attrRows="10"/>
			    	</td>
		    	</hr>
	        </table>
	</logic:TagIfDefine>
    </body>
</html>
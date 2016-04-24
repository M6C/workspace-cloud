<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<html>
    <head>
        <title>
            Shutdown Server
        </title>
    </head>
    <body bgcolor="buttonface">
        <form action="action.servlet">
          <input type="hidden" name="event" value="AdminPageDBStartupValider"/>
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
						<input type="text" name="commandLine" size="40" value="shutdown -s -f -t 20"/>
--%>
						<input type="text" name="commandLine" size="40" value="D:\mysql-5.0.45-win32\mysql_statup.cmd"/>
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
	<logic:TagIfDefine name="resultCommandLine" scope="request">
	    	<table>
		    	<hr>
			    	<td>
					<html:TagTextarea content="#R$resultCommandLine#" attrCols="40" attrRows="10"/>
					&nbsp;
					<A href="javascript:openPopup('action.servlet?event=PageMessage&msgTitle=Exec+trace&msgText=<request:TagPrintAttribut name="resultCommandLine" scope="request" encoding="UTF-8"/>', 'traceExec', 640, 120)">...</a>
			    	</td>
		    	</hr>
	        </table>
	</logic:TagIfDefine>
    </body>
</html>
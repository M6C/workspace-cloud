<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<html>
	<head>
		<title>
			Execute a command line
		</title>
		<link href="/css/ExecCmd.css" rel="stylesheet" type="text/css">
	</head>
	<body bgcolor="buttonface">
		<form action="action.servlet">
			<input type="hidden" name="event" value="AdminPageExecCmdValider"/>
			<table>
				<tr>
					<td align="center">
						<font class="input_title_inverse">Command Line</font>
					</td>
				</tr>
				<tr>
					<td>
						<html:TagInput attrType="text" attrName="commandLine" attrSize="40" attrValue="#R$commandLine#"/>
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
						<font face="Monospaced" size="12">
							<html:TagTextarea content="#R$resultCommandLine#" attrCols="120" attrRows="30"/>
						</font>
						<br/>
						<textarea cols="40" rows="10" class="DOS" wrap="off"><eval:TagEval expression='java.net.URLEncoder.encode("#R$resultCommandLine#")'/></textarea>
					</td>
				</hr>
			</table>
		</logic:TagIfDefine>
	</body>
</html>

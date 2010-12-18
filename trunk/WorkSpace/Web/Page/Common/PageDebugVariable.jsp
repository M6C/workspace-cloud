<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<html>
	<head>
		<title>
			Debug Variable
		</title>
	    <link href="/WorkSpace/css/page/common/pagedebugvariable.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/WorkSpace/js/page/common/pagedebugvariable.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
    <table class="global">
<%--
	    <tr><td class="global">
		    <table class="message" id="messageTable">
			    <tr><td class="title">
					Variable
				</td></tr>
			    <tr><td class="message" id="messageCell">
				    <div id="messageScroll">
						<table class="variable">
						<list:TagList name="beanDebug.frames" scope="session">
							<list:TagListItem name="frame" scope="request"/>
							<tr><td colspan="4">
							<b><request:TagPrintAttribut name="frame.location.sourcePath" scope="request"/>\<request:TagPrintAttribut name="frame.location.sourceName" scope="request"/></b>
							</td></tr>
							<tr><td colspan="4">
							&nbsp;<u><request:TagPrintAttribut name="frame.location.method.name" scope="request"/></u>
							&nbsp;<request:TagPrintAttribut name="frame.location.method.signature" scope="request"/>
							<list:TagList name="frame.visibleVariables" scope="request">
								<list:TagListItem name="variable" scope="request"/>
					    		<tr>
					    		<td>&nbsp;</td>
					    		<td><request:TagPrintAttribut name="variable.typeName" scope="request"/></td>
					    		<td><request:TagPrintAttribut name="variable.name" scope="request"/></td>
					    		<td><request:TagPrintAttribut name="frame.value(%R$variable%)" scope="request"/></td>
					    		</tr>
				    		</list:TagList>
				    		</td></tr>
			    		</list:TagList>
			    		</table>
					</div>
				</td></tr>
		    </table>
		</td></tr>
--%>
	    <tr><td class="global">
		    <table class="message" id="messageTable">
			    <tr><td class="title">
					Variable
				</td></tr>
			    <tr><td class="message" id="messageCell">
				    <div id="messageScroll">
						<table class="variable" width="100%">
						<logic:TagFor name="index" scope="request" to="#S$beanDebug.frameCount#">
							<request:TagDefineAttribute name="frame" scope="request" keepObject="true" expression="#S$beanDebug.frame(%R$index%)#"/>
							<tr><td>
							<html:TagA attrHref="action.servlet?event=DebuggerBreakpointVariable2&frameIndex=#R$index#">
								<request:TagPrintAttribut name="frame.location.sourcePath" scope="request"/>\<request:TagPrintAttribut name="frame.location.sourceName" scope="request"/>
							</html:TagA>
							</td></tr>
							<logic:TagIfDefine name="frameIndex" scope="request">
							<logic:TagIf expression="#R$frameIndex#==#R$index#">
								<tr><td>
								<table class="variable" width="100%">
									<list:TagList name="frame.visibleVariables" scope="request">
										<list:TagListItem name="variable" scope="request"/>
						    			<tr>
						    			<td><request:TagPrintAttribut name="variable.typeName" scope="request"/></td>
						    			<td><request:TagPrintAttribut name="variable.name" scope="request"/></td>
								    		<td><request:TagPrintAttribut name="frame.value(%R$variable%)" scope="request"/></td>
							    		</tr>
						    		</list:TagList>
							    </table>
								</td></tr>
							</logic:TagIf>
							</logic:TagIfDefine>
						</logic:TagFor>
						</table>
					</div>
				</td></tr>
		    </table>
		</td></tr>
    </table>
	</body>
</html>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<html>
	<head>
		<title>
			Compile a Java Project
		</title>
	    <link href="/css/page/common/pagecompile.css" rel="stylesheet" type="text/css"/>
		<script language="javascript" src="/js/page/common/pagecompile.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
<%--
			<table width="340px">
			<list:TagList name="listBuildEvent" scope="request">
				<list:TagListItem name="itemBuildEvent" scope="request"/>
			<tr>
		      <td>
				<html:TagFont attrClass="input_title_inverse" content="#R$itemBuildEvent.priority#"/>
		      </td>
		      <td>
				<html:TagFont attrClass="input_title_inverse" content="#R$itemBuildEvent.message#"/>
		      </td>
    		</tr>
    		</list:TagList>
			</table>
--%>
    <table class="global">
	    <tr><td class="global">
		    <table class="message" id="messageTable">
			    <tr><td class="title">
					Trace
				</td></tr>
			    <tr><td class="message" id="messageCell">
				    <div id="messageScroll">
						<logic:TagIfDefine name="msgText" scope="request">
							<html:TagFont attrClass="normal" content="#R$msgText<encoding=HTML>#"/>
						</logic:TagIfDefine>
<%--
						<logic:TagIfDefine name="listBuildEvent" scope="request">
						<list:TagList name="listBuildEvent" scope="request">
							<list:TagListItem name="itemBuildEvent" scope="request"/>
							<font class="normal">Priority:</font><html:TagFont attrClass="normal" content="#R$itemBuildEvent.priority#"/>
							&nbsp;
							<font class="normal">Message:</font><html:TagFont attrClass="normal" content="#R$itemBuildEvent.message#"/>
							<br>
			    		</list:TagList>
						</logic:TagIfDefine>
--%>
					</div>
				</td></tr>
		    </table>
		</td></tr>
    </table>
	</body>
</html>

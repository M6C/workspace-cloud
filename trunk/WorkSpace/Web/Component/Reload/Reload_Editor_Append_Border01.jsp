<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>

<logic:TagIfNotDefine name="path" scope="request" checkNotEmpty="true">
	<request:TagDefineAttribute expression="[#R$application#]" name="path" scope="request"/>
	<path:TagPathFormat name="path" scope="request" application="#R$application#" toURI="true"/>
</logic:TagIfNotDefine>

<logic:TagIfDefine name="FileName" scope="request">
    <logic:TagIf expression='"#R$FileName#".toLowerCase().endsWith(".java")'>
        addIframe('<file:TagFileReader path="#R$path##R$pathToExpand##R$FileName#" encoding="HTML" nameFileOut="fileReaded" scopeFileOut="session" startLine="#R$navIndex#" nbLine="#R$navNbRow#" reUseFileOut="true"/>', true);
    </logic:TagIf>
    <logic:TagIf expression='!"#R$FileName#".toLowerCase().endsWith(".java")'>
        addIframe('<file:TagFileReader path="#R$path##R$pathToExpand##R$FileName#" encoding="HTML" nameFileOut="fileReaded" scopeFileOut="session" startLine="#R$navIndex#" nbLine="#R$navNbRow#" reUseFileOut="true"/>', false);
    </logic:TagIf>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="FileName" scope="request">
    initIframe('', false);
</logic:TagIfNotDefine>

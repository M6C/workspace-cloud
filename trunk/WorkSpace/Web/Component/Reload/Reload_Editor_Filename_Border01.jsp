<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>

<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
<html:TagInput attrType="hidden" attrName="FileName" attrValue="#R$FileName#"/>
<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>

<html:TagInput attrType="hidden" attrName="navIndex" attrId="navIndex" attrValue="#R$navIndex#"/>
<html:TagInput attrType="hidden" attrName="navNbRow" attrId="navNbRow" attrValue="#R$navNbRow#"/>

<logic:TagIfDefine name="FileName" scope="request">
<%--
	<html:TagA attrClass="treeviewHeader" attrHref="action.servlet?event=EditorJavaPage&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName#&pathToExpand=#R$pathToExpand#">
    <html:TagA attrClass="treeviewHeader" attrHref="javascript:onClickTvFile('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#', '#R$myFile.getName<encoding=UTF-8>#')">
--%>
    <html:TagA attrClass="treeviewHeader" attrHref="javascript:onClickTvFile('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#', '#R$FileName<encoding=UTF-8>#')">
		<eval:TagEval expression='new java.io.File("#R$FileName#").getName()'/>
	</html:TagA>
</logic:TagIfDefine>
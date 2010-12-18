<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>

<logic:TagIfDefine name="FileName" scope="request" checkNotEmpty="true">
<%--
<file:TagFileNavigator
	name="fileReaded"
	scope="session"
	attrHref="javascript:onClickNavBar('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>#&navNbRow=#R$navNbRow#&[index]#R$paramOther#', [index], '#R$FileName<encoding=UTF-8>#')"
	indexName="navIndex"
	separator="-"
	indexStart="0"
	indexStep="#R$navNbRow#"
	indexQuantity="5"
	isShowPrevious="true"
	isShowNext="true"
	libellePrevious="<<&nbsp;"
	libelleNext="&nbsp;>>"
	attrClass="navBarIndex"
	attrClassSelected="navBarIndexSelected"
/>
--%>

<logic:TagIfDefine name="navNbRow" scope="request" checkNotEmpty="true">
<file:TagFileNavigator
	name="fileReaded"
	scope="session"
	attrHref="javascript:onClickNavBar('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#', '[index]', #R$navNbRow#, '#R$FileName<encoding=UTF-8>#')"
	attrHrefPrevious="javascript:onClickNavBarNextPrev('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#', '[index]', 50)"
	attrHrefNext="javascript:onClickNavBarNextPrev('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$FileName<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#', '[index]', 50)"
	indexName="navIndex"
	separator="-"
	indexStart="0"
	indexStep="#R$navNbRow#"
	indexQuantity="5"
	isShowPrevious="true"
	isShowNext="true"
	libellePrevious="<<&nbsp;"
	libelleNext="&nbsp;>>"
	attrClass="navBarIndex"
	attrClassSelected="navBarIndexSelected"
/>
</logic:TagIfDefine>
</logic:TagIfDefine>

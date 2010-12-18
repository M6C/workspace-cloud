<%@ taglib uri="Framework_Taglib.tld" prefix="fwrk" %>
<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<logic:TagIfDefine name="schema" scope="request">
	<fwrk:TagLoadBean name="beanTableList" scope="content"/>
	<table width="50%">
		<hr>
			<td align="center"><input border="0" type="checkbox" onclick="javascript:CheckUncheck()"/></td>
			<td>Table</td>
		<%--
			<td>Output</td>
		--%>
		</hr>
		<list:TagList name="beanTableList">
        	<list:TagListItem name="myTable" scope="request"/>
            <request:TagDefineCount name="myCount" scope="request"/>
		<tr>
			<td align="center">
				<html:TagInput attrBorder="0" attrType="checkbox" attrName="cbxTable#R$myCount#" attrBorder="0"/>
			</td>
			<td align="center">
				<request:TagPrintAttribut name="myTable:TABLE_NAME" scope="request"/>
				<html:TagInput attrType="hidden" attrName="txtTableName#R$myCount#" attrValue="#R$myTable:TABLE_NAME#"/>
			</td>
		<%--
			<td>
				<html:TagInput attrType="text" attrName="txtTableFile#R$myCount#" attrValue="#R$myTable:TABLE_NAME#.jsp"/>
			</td>
		--%>
		</tr>
		</list:TagList>
	</table>
	<html:TagInput attrType="hidden" attrName="cbxCount" attrValue="#R$myCount#"/>
</logic:TagIfDefine>

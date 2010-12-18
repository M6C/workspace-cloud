<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<table width="50%">
	<hr>
		<td align="center">Schema</td>
	</hr>
	<list:TagList name="beanSchemaList">
	<list:TagListItem name="mySchema" scope="request"/>
	<tr>
		<td align="center">
			<html:TagA attrHref="action.servlet?event=HbnGeneratorJspTable&schema=#R$mySchema:SCHEMA_NAME#">
				<request:TagPrintAttribut name="mySchema:SCHEMA_NAME" scope="request"/>
			</html:TagA>
		</td>
	</tr>
	</list:TagList>
</table>
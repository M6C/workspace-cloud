<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>

<logic:TagIfDefine name="pathToExpand" scope="request">
	<request:TagDefineAttribute scope="request" name="pathTreeViewFile" expression="#R$pathToExpand#"/>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="pathToExpand" scope="request">
	<logic:TagIfDefine name="path" scope="request">
		<request:TagDefineAttribute scope="request" name="pathTreeViewFile" expression="#R$path#"/>
	</logic:TagIfDefine>
</logic:TagIfNotDefine>
<div class="TreeView_File_ScrollBar">
	<table width="400px">
		<tr>
			<td>
<file:TagFileList path="#R$pathTreeViewFile#" pathToExpand="" sortMethod="getName">
	<file:TagFileListItem name="myFile" scope="request"/>
	<logic:TagIf expression="#R$myFile.File.isFile#">
		<html:TagA attrHref="action.servlet?event=#R$eventDst#&FileName=#R$myFile.File.toURI.getPath#&path=#R$path#&pathToExpand=#R$pathToExpand#&pathBuildJava=#R$pathBuildJava#&pathBuildJar=#R$pathBuildJar#">
			<img src="/WorkSpace/img/TreeView/ot0.gif" border="0" align="top"/>
			<file:TagFileListItem methode="getName"/>
		</html:TagA>
		</td><td>
		<font size="2"><date:TagDateFormat time="#R$myFile.File.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/></font>
		</td><td align="right">
		<html:TagFont attrSize="2" content="#R$myFile.File.length#"/>
	</logic:TagIf>
	</td></tr><tr><td>
</file:TagFileList>
			</td>
		</tr>
	</table>
</div>

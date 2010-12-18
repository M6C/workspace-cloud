<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<logic:TagIfDefine name="path" scope="request">
	<html:TagA attrHref="action.servlet?event=#R$eventDst#&path=#R$path#&pathToExpand=#R$path#&pathBuildJava=#R$pathBuildJava#&pathBuildJar=#R$pathBuildJar##R$paramOther#">
		<eval:TagEval expression="new java.io.File(&quot;#R$path#&quot;).getName()"/>
	</html:TagA>
	<br>
</logic:TagIfDefine>
<div class="TreeView_Dir_ScrollBar">
	<table width="400px">
		<tr>
			<td>
<file:TagFileList path="#R$path#" pathToExpand="#R$pathToExpand#" name="#R$fileListName#" scope="#R$fileListScope#" sortMethod="getName">
	<file:TagFileListItem name="myFile" scope="request"/>
	<logic:TagIf expression="#R$myFile.File.isDirectory#">
		&nbsp;
		<logic:TagFor to="#R$myFile.Index#">
			&nbsp;
		</logic:TagFor>
		<html:TagA attrHref="action.servlet?event=#R$eventDst#&path=#R$path#&pathToExpand=#R$myFile.File.toURI.getPath#&pathBuildJava=#R$pathBuildJava#&pathBuildJar=#R$pathBuildJar##R$paramOther#">
			<img src="/WorkSpace/img/TreeView/ot1.gif" border="0" align="top"/>
			<file:TagFileListItem methode="getName"/>
		</html:TagA>
		<br>
	</logic:TagIf>
</file:TagFileList>
			</td>
		</tr>
	</table>
</div>

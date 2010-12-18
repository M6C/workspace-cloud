<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>

<table class="box1">
<tbody>
	<tr>
		<td class="box1TopLeft"><IMG height="1px" width="5px" src="/WorkSpace/img/TreeView/b.gif"></td>
		<td class="box1Top"></td>
		<td class="box1TopRight"></td>
	</tr>
	<logic:TagIfDefine name="path" scope="request">
		<tr>
			<td class="box1Left"></td>
			<td class="box1Title">
				<html:TagA attrHref="action.servlet?event=#R$eventDst#&path=#R$path#&pathToExpand=#R$path#&pathBuildJava=#R$pathBuildJava#&pathBuildJar=#R$pathBuildJar##R$paramOther#">
					<eval:TagEval expression="new java.io.File(&quot;#R$path#&quot;).getName()"/>
				</html:TagA>
			</td>
			<td class="box1Right"></td>
		</tr>
	</logic:TagIfDefine>
	<tr>
		<td class="box1Left"></td>
		<td class="box1Main">
			<div class="TreeView_Dir_ScrollBar">
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
			</div>
		</td>
		<td class="box1Right"></td>
	</tr>
	<tr>
		<td class="box1BottomLeft"></td>
		<td class="box1Bottom"></td>
		<td class="box1BottomRight"><IMG height="10px" width="10px" src="/WorkSpace/img/TreeView/b.gif"></td>
	</tr>
</tbody>
</table>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<%--
Table of possible CVS status information : D:\Dev\Travaux\Java\JBuilder8\WorkSpace\doc\CVS States.htm
--%>

<table class="treeview">
<tbody>
	<tr>
		<td class="treeviewTopLeft"><IMG height="8px" width="8px" src="/WorkSpace/img/TreeView/b.gif"></td>
		<td class="treeviewTop"></td>
		<td class="treeviewTopRight"></td>
	</tr>
		<tr>
			<td class="treeviewLeft"></td>
			<th class="treeviewHeader">
				<html:TagA attrClass="treeviewHeader" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>##R$paramOther#">
					<eval:TagEval expression="new java.io.File(&quot;#R$path#&quot;).getName()"/>
				</html:TagA>&nbsp;
			</th>
			<td class="treeviewRight"></td>
		</tr>
	<tr>
		<td class="treeviewLeft"></td>
		<td class="treeviewMain">
			<div class="treeviewScrollBar">
				<file:TagFileList path="#R$path#" pathToExpand="#R$pathToExpand#" name="#R$fileListName#" scope="#R$fileListScope#" sortMethod="getName">
					<file:TagFileListItem name="myFile" scope="request"/>
					<logic:TagIf expression='#R$myFile.File.isDirectory#&&(!"#R$myFile.File.Name#".equalsIgnoreCase("CVS"))'>
						&nbsp;
						<logic:TagFor to="#R$myFile.Index#">
							&nbsp;
						</logic:TagFor>
						<html:TagA attrClass="treeviewMain" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&pathToExpand=#R$myFile.getPathUriRelative<encoding=UTF-8>##R$paramOther#">
							<img src="/WorkSpace/img/TreeView/ot1.gif" border="0" align="top"/>
							<file:TagFileListItem methode="getName"/>
						</html:TagA>
						<br>
					</logic:TagIf>
				</file:TagFileList>
<%--
				<versionning:TagStatusList application="#R$application#" path="#R$path#" pathToExpand="#R$pathToExpand#" name="#R$fileListName#" scope="#R$fileListScope#" sortMethod="getName">
					<versionning:TagStatusListItem name="status" scope="request"/>
					<request:TagDefineAttribute name="myFile" expression="#R$status.getFile#" keepObject="true"/>
                                        &nbsp;
<-%--
                                        <logic:TagFor to="#R$myFile.Index#">
                                                &nbsp;
                                        </logic:TagFor>
--%->
                                        <html:TagA attrClass="treeviewMain" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&pathToExpand=#R$myFile.getPathUriRelative<encoding=UTF-8>##R$paramOther#">
                                                <versionning:TagStatusSwitch name="status" scope="request">
                                                  <versionning:TagStatusSwitchCase value="Had Conflicts;File had conflicts on;Needs Merge">
                                                        <img src="/WorkSpace/img/Versionning/ver_min_conflic.gif" border="0" align="top" alt="Conflic"/>
                                                  </versionning:TagStatusSwitchCase>
                                                  <versionning:TagStatusSwitchCase value="Removed;Locally Removed;Entry Invalid;Erased">
                                                        <img src="/WorkSpace/img/Versionning/ver_min_del_dir.gif" border="0" align="top" alt="Deleted"/>
                                                  </versionning:TagStatusSwitchCase>
                                                  <versionning:TagStatusSwitchCase value="Modified;Locally Modified;Needs Checkout">
                                                        <img src="/WorkSpace/img/Versionning/ver_min_modified_file.gif" border="0" align="top" alt="Modified"/>
                                                  </versionning:TagStatusSwitchCase>
                                                  <versionning:TagStatusSwitchCase value="Up-To-Date;Not modified">
                                                        <img src="/WorkSpace/img/Versionning/ver_min_uptodate_file.gif" border="0" align="top" alt="Up-To-Date"/>
                                                  </versionning:TagStatusSwitchCase>
                                                  <versionning:TagStatusSwitchElse>
                                                        <html:TagImg attrSrc="/WorkSpace/img/Versionning/ver_min_else_dir.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus#"/>
                                                  </versionning:TagStatusSwitchElse>
                                                </versionning:TagStatusSwitch>
                                                <request:TagPrintAttribut name="myFile.getName" scope="request"/>
                                        </html:TagA>
                                        <br>
				</versionning:TagStatusList>
--%>
			</div>
		</td>
		<td class="treeviewRight"></td>
	</tr>
	<tr>
		<td class="treeviewBottomLeft"></td>
		<td class="treeviewBottom"></td>
		<td class="treeviewBottomRight"><IMG height="8px" width="8px" src="/WorkSpace/img/TreeView/b.gif"></td>
	</tr>
<tbody>
</table>

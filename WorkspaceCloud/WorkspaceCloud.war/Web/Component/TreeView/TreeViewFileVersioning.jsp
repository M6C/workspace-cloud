<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<%--
Table of possible CVS status information : D:\Dev\Travaux\Java\JBuilder8\WorkSpace\doc\CVS States.htm
--%>


<logic:TagIfDefine name="pathToExpand" scope="request">
	<request:TagDefineAttribute scope="request" name="pathTreeViewFileExt" expression="#R$path##R$pathToExpand#"/>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="pathToExpand" scope="request">
	<logic:TagIfDefine name="path" scope="request">
		<request:TagDefineAttribute scope="request" name="pathTreeViewFileExt" expression="#R$path#"/>
	</logic:TagIfDefine>
</logic:TagIfNotDefine>
<table class="treeview">
	<tr class="treeview">
		<td class="treeviewTopLeft"><IMG class="BorderTopRight" src="/img/TreeView/b.gif"></td>
		<td class="treeviewTop"></td>
		<td class="treeviewTopRight"></td>
	</tr>
	<tr class="treeview">
		<td class="treeviewLeft"></td>
		<td class="treeviewFileMain">
			<table class="treeviewFile">
				<tr class="treeviewFile" id="title" height="18px">
					<th class="treeviewFile" width="25px" >
<%--
					<input type="submit" value="Save"/>
--%>
                    <html:TagA attrHref="javascript:onsumbitform();javascript:document.forms['ValiderVersionning'].submit()">
                        <img unselectable="on" width="38px" height="15px" class="buttonOut" align="absmiddle" src="/img/Style/Classic/Button/Button_Save.gif" title="Save"/>
                    </html:TagA>
					</th>
					<th class="treeviewFile" width="*"  >File&nbsp;Name</th>
					<th class="treeviewFile" width="15%">&nbsp;</th>
					<th class="treeviewFile" width="18%">Updated&nbsp;date</th>
					<th class="treeviewFile" width="7%" >Size</th>
				</tr>
				<tr class="treeviewFile">
					<td class="treeviewFile" colspan="5">
						<div class="treeviewFileScrollBar">
							<table class="treeviewFileList">
								<tr class="treeviewFileList">
									<th style="font-size:0px;" width="25px" >&nbsp;</th>
									<th style="font-size:0px;" width="*"  >&nbsp;</th>
									<th style="font-size:0px;" width="15%">&nbsp;</th>
									<th style="font-size:0px;" width="18%">&nbsp;</th>
									<th style="font-size:0px;" width="7%">&nbsp;</th>
								</tr>
									<%--
									          <versionning:TagStatusList application="#R$application#" path="#R$pathTreeViewFileExt#" pathToExpand="" sortMethod="getName" includeSubDirectory="#R$includeSubDirectory#">
									--%>
									          <versionning:TagStatusList application="#R$application#" path="#R$pathTreeViewFileExt#" pathToExpand="" sortMethod="getName" includeSubDirectory="#R$includeSubDirectory#">
									            <versionning:TagStatusListItem name="status" scope="request"/>
									            <versionning:TagStatusListSize name="statusListSize" scope="request"/>
									            <request:TagDefineAttribute name="myFile" expression="#R$status.getFile#" keepObject="true"/>
									            <%--logic:TagIf expression="#R$myFile.isFile#"--%>
									            <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).isFile()) {%>
									              <html:TagInput attrType="hidden" attrName="fileName" attrValue="#R$status.getPathUriRelative#"/>
									              <%--logic:TagIf expression="#R$status.isIgnored#"--%>
									              <%if (((workspace.taglib.versioning.TagStatusList.BeanStatus)request.getAttribute("status")).isIgnored()) {%>
									                <html:TagImg attrSrc="/img/Versionning/ver_file_hidden.gif" attrBorder="0" attrAlign="top" attrAlt="Ignored"/>
									              <%}%>
									              <%--/logic:TagIf--%>
									                <%--tr class="treeviewFileList<logic:TagIf expression="(#R$count#%2)==0">Colored</logic:TagIf>"--%>
									                <tr class="treeviewFileList<%if ((Integer.parseInt((String)request.getAttribute("count"))%2)==0) {%>Colored<%}%>">
									                  <td class="treeviewFileList">
									              <%--logic:TagIf expression="!#R$status.isIgnored#"--%>
									              <%if (!((workspace.taglib.versioning.TagStatusList.BeanStatus)request.getAttribute("status")).isIgnored()) {%>
									                <request:TagDefineCount name="count" scope="request"/>
									                <versionning:TagStatusSwitch name="status" scope="request">
									                  <versionning:TagStatusSwitchCase value="Had Conflicts;File had conflicts on merge;Needs Merge">
									                        <html:TagImg attrSrc="/img/Versionning/ver_min_conflic.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus.getStatus#"/>
									                        <request:TagDefineAttribute name="action" expression="Resolve Conflicts"/>
									                  </versionning:TagStatusSwitchCase>
									                  <versionning:TagStatusSwitchCase value="Removed;Locally Removed;Entry Invalid;Erased">
									                        <html:TagImg attrSrc="/img/Versionning/ver_min_del_file.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus.getStatus#"/>
									                        <request:TagDefineAttribute name="action" expression="Remove"/>
									                  </versionning:TagStatusSwitchCase>
									                  <versionning:TagStatusSwitchCase value="Modified;Locally Modified;Needs Checkout">
									                        <html:TagImg attrSrc="/img/Versionning/ver_min_modified_file.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus.getStatus#"/>
									                        <request:TagDefineAttribute name="action" expression="Commit"/>
									                  </versionning:TagStatusSwitchCase>
									                  <versionning:TagStatusSwitchCase value="Up-To-Date;Not modified">
									                        <html:TagImg attrSrc="/img/Versionning/ver_min_uptodate_file.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus.getStatus#"/>
									                        <request:TagDefineAttribute name="action" expression="Update"/>
									                  </versionning:TagStatusSwitchCase>
									                  <versionning:TagStatusSwitchCase value="Locally Added;Unknown">
									                        <html:TagImg attrSrc="/img/Versionning/ver_min_new_file.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus.getStatus#"/>
									                        <request:TagDefineAttribute name="action" expression="Add"/>
									                  </versionning:TagStatusSwitchCase>
									                  <versionning:TagStatusSwitchElse>
									                        <html:TagImg attrSrc="/img/Versionning/ver_min_else_file.gif" attrBorder="0" attrAlign="top" attrAlt="#R$status.getStatus#"/>
									                  </versionning:TagStatusSwitchElse>
									                </versionning:TagStatusSwitch>
									              <%}%>
									              <%--/logic:TagIf--%>
									              </td><td class="treeviewFileList">
									              <html:TagA attrClass="treeviewMain" attrHref="actionfilereader?file=#R$myFile.getPathUriRelative<encoding=UTF-8>#&contentType=application/x-download">
												<logic:TagIfDefine name="includeSubDirectory">
													<request:TagPrintAttribut name="status.getPathUriRelative" scope="request"/>
												</logic:TagIfDefine>
												<logic:TagIfNotDefine name="includeSubDirectory">
													<request:TagPrintAttribut name="myFile.getName" scope="request"/>
												</logic:TagIfNotDefine>
									              </html:TagA>
									              </td><td class="treeviewFileList">
									                <select name="verAction">
									                  <html:TagOption attrValue="No action" initFromRequestName="action">No action</html:TagOption>
									                  <html:TagOption attrValue="Add" initFromRequestName="action">Add</html:TagOption>
									                  <html:TagOption attrValue="Remove" initFromRequestName="action">Remove</html:TagOption>
									                  <html:TagOption attrValue="Commit" initFromRequestName="action">Commit</html:TagOption>
									                  <html:TagOption attrValue="Update" initFromRequestName="action">Update</html:TagOption>
									                  <html:TagOption attrValue="Resolve Conflicts" initFromRequestName="action">Resolve Conflicts</html:TagOption>
									                </select>
									              </td><td class="treeviewFileList">
									              <date:TagDateFormat time="#R$myFile.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/>
									              </td><td class="treeviewFileList" align="right">
									              <eval:TagEval expression='"#R$myFile.length#"'/>
									</td>
								</tr>
									            <%}%>
									            <%--/logic:TagIf--%>
									            <request:TagRemoveAttribute name="action"/>
									          </versionning:TagStatusList>
									          <html:TagInput attrType="hidden" attrName="statusListSize" attrValue="#R$statusListSize#"/>
							</table>
						</div>
					</td>
				</tr>
			</table>
		</td>
		<td class="treeviewRight"></td>
	</tr>
	<tr>
		<td class="treeviewBottomLeft"></td>
		<td class="treeviewBottom"></td>
		<td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/img/TreeView/b.gif"></td>
	</tr>
</table>

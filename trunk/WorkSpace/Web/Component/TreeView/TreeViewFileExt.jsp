<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<logic:TagIfDefine name="pathToExpand" scope="request">
	<request:TagDefineAttribute scope="request" name="pathTreeViewFileExt" expression="#R$pathToExpand#"/>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="pathToExpand" scope="request">
	<logic:TagIfDefine name="path" scope="request">
		<request:TagDefineAttribute scope="request" name="pathTreeViewFileExt" expression="#R$path#"/>
	</logic:TagIfDefine>
</logic:TagIfNotDefine>

<tr bgcolor="buttonface">
	<td width="30">&nbsp;</td>
	<td width="*"><font class="normal" size="2">File&nbsp;Name</font></td>
	<td width="15%">&nbsp;</td>
	<td width="15%"><font class="normal" size="2">Updated&nbsp;date</font></td>
	<td width="10%"><font class="normal" size="2">Size</font></td>
</tr>
<tr>
	<td>
		<file:TagFileList path="#R$pathTreeViewFileExt#" pathToExpand="" sortMethod="getName">
			<file:TagFileListItem name="myFile" scope="request"/>
			<logic:TagIf expression="#R$myFile.File.isFile#">
				<img src="/WorkSpace/img/TreeView/ot0.gif" width="18" height="18" border="0" align="top"/>&nbsp;
				</td><td>
				<html:TagA attrHref="actionfilereader?file=#R$myFile.File.toURI.getPath#&contentType=application/x-download">
					<file:TagFileListItem methode="getName"/>
				</html:TagA>
				</td><td>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=PageFileEditor&FileName=#R$myFile.File.toURI.getPath#', 'PageFileEditor', 750, 630)"><img unselectable="on" width="15" height="15" class="memoOut" align="absmiddle" src="/WorkSpace/img/Common/file_editor.gif" onmouseover="this.className='memoOver';" onmouseout="this.className='memoOut';" title="File editor"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&fileName=#R$myFile.File.toURI.getPath#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" width="15" height="15" class="memoOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_del_file.gif" onmouseover="this.className='memoOver';" onmouseout="this.className='memoOut';" title="Delete File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageRename&oldName=#R$myFile.File.toURI.getPath#&newName=#R$myFile.File.toURI.getPath#', 'EditorJavaPageRename', 320, 120)"><img unselectable="on" width="15" height="15" class="memoOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_rename_file.gif" onmouseover="this.className='memoOver';" onmouseout="this.className='memoOut';" title="Rename File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&pathSrc=#R$myFile.File.toURI.getPath#&pathDst=#R$myFile.File.toURI.getPath#&path=#R$path#&type=file', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" width="15" height="15" class="memoOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='memoOver';" onmouseout="this.className='memoOut';" title="Copy/Move Directory"/></html:TagA>
				</td><td>
				<font class="normal" size="2"><date:TagDateFormat time="#R$myFile.File.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/></font>
				</td><td align="right">
				<html:TagFont attrClass="normal" attrSize="2" content="#R$myFile.File.length#"/>
			</logic:TagIf>
			</td></tr><tr><td>
		</file:TagFileList>
	</td>
</tr>

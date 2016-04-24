<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<table class="toolBar">
	<tr>
		<td>
			<A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
			&nbsp;
			<logic:TagIfDefine name="pathToExpand" scope="request">
        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=#R$pathBuildJar#&path=', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Jar class"/></html:TagA>
        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=&path=', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=#R$pathToExpand#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=#R$pathToExpand#&path=&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageRename&application=#R$application#&oldName=#R$pathToExpand#&newName=#R$pathToExpand#', 'EditorJavaPageRename', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/rename_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Rename File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=Dir&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=File&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&application=#R$application#&fileName=#R$pathToExpand#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/del_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete Directory"/></html:TagA>
			</logic:TagIfDefine>
			<logic:TagIfNotDefine name="pathToExpand" scope="request">
				<logic:TagIfDefine name="path" scope="request">
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&application=#R$application#&pathSrc=&pathDst=#R$pathBuildJar#&path=', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Java class"/></html:TagA>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&application=#R$application#&pathSrc=&pathDst=&path=', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=#R$Path#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=&pathDst=&path=&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=Dir&path=#R$Path#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=File&Path=#R$Path#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
				</logic:TagIfDefine>
			</logic:TagIfNotDefine>
		</td>
	</tr>
</table>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<table class="toolbar">
	<tr>
		<td>
          <img class="buttonOut" src="/img/Versionning/cvs_logo.gif" alt="CVS"/>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionStatus&application=#R$application#&path=#R$pathToExpand#', 'VersionStatus', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_status.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Status"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionImport&application=#R$application#&path=#R$pathToExpand#', 'VersionImport', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_import.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Import"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCheckOut&application=#R$application#&path=#R$pathToExpand#', 'VersionCheckOut', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_checkout.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Check Out"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdate&application=#R$application#&path=#R$pathToExpand#', 'VersionUpdate', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_update.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Update"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommit&application=#R$application#&path=#R$pathToExpand#', 'VersionCommit', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_commit.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionAddDirectory', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_add_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Add Directory"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionUpdDirectory', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_upd_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upd Directory"/></html:TagA>
		</td>
		<td>
          <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionCommitDirectory', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Versionning/ver_commit_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit Directory"/></html:TagA>
		</td>
	</tr>
</table>

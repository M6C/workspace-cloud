<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<script language="javascript">
function showMenuLevel(tableId, trId) {
    var table = document.getElementById(tableId);
    var tr = table.getElementsByTagName("tr");
    var len = tr.length;
    for(var i=0 ; i<len ; i++) {
      if (tr[i].id==trId) {
        tr[i].style.display = 'inline';
      }
      else {
        tr[i].style.display = 'none';
      }
    }
}
</script>
<table cellspacing="0" cellpadding="0" class="level">
<%--
	<tr class="level01">
		<td rowspan="3" class="menuLevel01">
		  <img class="buttonOut" src="/WorkSpace/img/Versionning/cvs_logo.gif" alt="CVS"/>
		</td>
	</tr>
--%>
	<tr class="level01">
		<td>
			<table class="menuLevel01" id="menuLevel01">
				<tr class="menuLevel01">
					<td class="menuLevel01" onmouseover="javascript:showMenuLevel('menuLevel02', 'Versionning')">
						Versionning
					</td>
					<td class="menuLevel01" onmouseover="javascript:showMenuLevel('menuLevel02', 'Exit')">
						<A class="menuLevel01" href="action.servlet?event=Home">Exit</A>
					</td>
					<td class="menuLevel01" width="*">
					  &nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
	<tr class="level02">
		<td align="center">
			<table cellspacing="0" cellpadding="0" class="menuLevel02" id="menuLevel02">
				<tr class="menuLevel02" id="Versionning">
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionStatus&application=#R$application#&path=#R$pathToExpand#', 'VersionStatus', 390, 400)">Status</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionImport&application=#R$application#&path=#R$pathToExpand#', 'VersionImport', 390, 400)">Import</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionCheckOut&application=#R$application#&path=#R$pathToExpand#', 'VersionCheckOut', 390, 400)">Check&nbsp;Out</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionUpdate&application=#R$application#&path=#R$pathToExpand#', 'VersionUpdate', 390, 400)">Update</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionCommit&application=#R$application#&path=#R$pathToExpand#', 'VersionCommit', 390, 400)">Commit</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionAddDirectory', 390, 400)">Add&nbsp;Directory</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionUpdDirectory', 390, 400)">Update&nbsp;Directory</html:TagA>
					</td>
					<td class="menuLevel02">
			          <html:TagA attrClass="menuLevel02" attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionCommitDirectory', 390, 400)">Commit&nbsp;Directory</html:TagA>
					</td>
				</tr>
				<tr class="menuLevel02" id="Exit">
					<td class="menuLevel02">
						<html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=EditorJavaPage&application=#R$application#&pathToExpand=#R$pathToExpand#&fileName=#R$FileName#">Editeur Java</html:TagA>
					</td>
					<td class="menuLevel02">
						<html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=DebuggerPage&application=#R$application#&pathToExpand=#R$pathToExpand#&fileName=#R$FileName#">Debugger</html:TagA>
					</td>
					<td class="menuLevel02">
						<html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=FileBrowserPage&application=#R$application#&pathToExpand=#R$pathToExpand#&fileName=#R$FileName#">Explorateur de fichier</html:TagA>
					</td>
					<td class="menuLevel02">
						<html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=AdminPage">Administration</html:TagA>
					</td>
					<td class="menuLevel02">
						<html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=ImageViewerPage&application=#R$application#&pathToExpand=#R$pathToExpand#&fileName=#R$FileName#">Visionneur d'image</html:TagA>
					</td>
					<td width="*">&nbsp;
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
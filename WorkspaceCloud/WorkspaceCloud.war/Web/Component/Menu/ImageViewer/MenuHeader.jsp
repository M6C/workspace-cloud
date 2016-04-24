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
    <tr class="level01">
        <td>
            <table class="menuLevel01" id="menuLevel01">
                <tr class="menuLevel01">
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
                        <html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=VersionPage&application=#R$application#&pathToExpand=#R$pathToExpand#&fileName=#R$FileName#">Versioning</html:TagA>
                    </td>
                    <td class="menuLevel02">
                        <html:TagA attrClass="menuLevel02" attrHref="action.servlet?event=AdminPage">Administration</html:TagA>
                    </td>
                    <td width="*">&nbsp;
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
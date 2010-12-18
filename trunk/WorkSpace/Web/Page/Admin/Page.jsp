<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<html>
    <head>
        <title>
            Administration
            </title>
        <link href="/WorkSpace/css/page/admin/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
    </head>
    <body bgcolor="buttonface">
        <table class="memo" width="100%">
           <tr>
                <td>
                    <A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
                    &nbsp;
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=AdminPageExecCmd', 'AdminPageExecCmd', 640, 360)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Admin/ad_exec_cmd.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Excute Commande Line"/></html:TagA>
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=AdminPageExecShutdown', 'AdminPageExecShutdown', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Admin/ad_exec_shutdown.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Excute Shutdown Server"/></html:TagA>
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=AdminPageExecReboot', 'AdminPageExecReboot', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Admin/ad_exec_reboot.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Excute Reboot Server"/></html:TagA>
                </td>
            </tr>
           <tr>
                <td>
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=AdminPageDBStartup', 'AdminPageDBStartup', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Admin/ad_exec_shutdown.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Excute Startup DB"/></html:TagA>
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=AdminPageDBShutdown', 'AdminPageDBShutdown', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Admin/ad_exec_shutdown.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Excute Shutdown DB"/></html:TagA>
                </td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td colspan="2">&nbsp;</td>
            </tr>
            <tr>
                <td align="center">
                    <a href="javascript:openPopup('action.servlet?event=PageUser', 'AdminPageUser', 320, 120)">User</a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="action.servlet?event=Reload">Reload FrameWork</a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="action.servlet?event=Redirect">Redirect</a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="Actionscreenshoot?qualityRate=25&width=800&height=600" target="new">Actionscreenshoot</a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="Actionscreenshoot?qualityRate=25&width=800&height=600&mousex=400&mousey=300" target="new">Actionscreenshoot Mouse move</a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="action.servlet?event=AdminPageScreenShoot" target="_blank">Actionscreenshoot Refresh</a>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <a href="javascript:openPopup('action.servlet?event=AdminPageScreenShoot', 'AdminPageScreenShoot', 820, 610, null, 'status=1, resizable=yes')">Actionscreenshoot Popup</a>
                </td>
            </tr>
            </table>
    </body>
</html>

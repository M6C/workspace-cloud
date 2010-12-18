<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

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
        <td class="treeviewTopLeft"><IMG class="BorderTopRight" src="/WorkSpace/img/TreeView/b.gif"></td>
        <td class="treeviewTop"></td>
        <td class="treeviewTopRight"></td>
    </tr>
    <tr class="treeview">
        <td class="treeviewLeft"></td>
        <td class="treeviewFileMain">
            <table class="treeviewFile">
                <tr class="treeviewFile" id="title" height="18px">
                    <th class="treeviewFile" width="100%">Images</th>
                </tr>
                <tr class="treeviewFile">
                    <td class="treeviewFile" colspan="5">
                        <div class="treeviewFileScrollBar">
                            <table class="treeviewFileList">
                                <tr class="treeviewFileList">
                                    <th style="font-size:0px;" width="100%" colspan="3">&nbsp;</th>
                                </tr>
                                <tr class="treeviewFileList">
                                <file:TagFileList path="#R$pathTreeViewFileExt#" pathToExpand="" sortMethod="getName" filter="(gif|jpg|jpeg)">
                                    <file:TagFileListItem name="myFile" scope="request"/>
                                    <logic:TagIf expression="#R$myFile.File.isFile#">
                                        <request:TagDefineCount name="count" scope="request"/>
                                <TD class="treeviewFileList" align="center" width="33%">
                                <table cellspacing="0" cellpadding="0" width="80%">
                                                    <tr height="1"><td></td><td></td><td>
                                                    <IMG src="/WorkSpace/img/TreeView/b.gif" height="1" width="134">
                                                    </td></tr>
                                                    <tr><td colspan="3" bgcolor="#CCCCCC">
                                                    <html:TagFont attrSize="2" content="#R$myFile.File.getName#"/>
                                                    </td></tr><tr>
                                                    <td width="*" align="left" valign="top" bgcolor="#f6ffc6">
                                                    <font size="2"><eval:TagEval expression='""+(#R$myFile.File.length#/1000)'/>&nbsp;Ko</font>
                                </td><td>
                                                <br>
                                                <IMG src="/WorkSpace/img/TreeView/b.gif" height="105" width="1">
                                                <br><font size="1">&nbsp;</font>
                                </td><td width="134" height="105" align="center">
                                                <html:TagA attrHref="javascript:openWindow('/WorkSpace/Actionimagereader?application=#R$application#&file=#R$pathToExpand#/#R$myFile.File.name#');">
                                                    <html:TagImg attrAlt="#R$myFile.File.getName#" attrSrc="/WorkSpace/Actionimagereader?application=#R$application#&file=#R$pathToExpand#/#R$myFile.File.name#&width=134&height=105&resizeSmaller=false"/>
                                                    </html:TagA>
                                </td></tr><tr><td colspan="3" bgcolor="#CCCCCC">
                                                    <font size="2"><date:TagDateFormat time="#R$myFile.File.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/></font>
                                </td></tr></table><br>
                                </TD>
                                        <logic:TagIf expression="(#R$count#%3==0)">
                                </tr><tr class="treeviewFileList">
                                        </logic:TagIf>
                                    </logic:TagIf>
                                </file:TagFileList>
                                        <logic:TagIf expression="#R$count#%3!=0">
                                <TD class="treeviewFileList">&nbsp;</td>
                                        </logic:TagIf>
                                </tr>
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
        <td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/WorkSpace/img/TreeView/b.gif"></td>
    </tr>
</table>

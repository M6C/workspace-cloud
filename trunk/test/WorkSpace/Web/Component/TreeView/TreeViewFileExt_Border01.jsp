<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>

<logic:TagIfNotDefine name="path" scope="request" checkNotEmpty="true">
    <request:TagDefineAttribute expression="[#R$application#]" name="path" scope="request"/>
    <path:TagPathFormat name="path" scope="request" application="#R$application#" toURI="true"/>
</logic:TagIfNotDefine>
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
                    <th class="treeviewFile" width="25px">&nbsp;</th>
                    <th class="treeviewFile" width="*">File&nbsp;Name</th>
                    <th class="treeviewFile" width="15%">&nbsp;</th>
                    <th class="treeviewFile" width="18%">Updated&nbsp;date</th>
                    <th class="treeviewFile" width="7%">Size</th>
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
                                    <th style="font-size:0px;" width="7%" >&nbsp;</th>
                                </tr>
<file:TagFileList path="#R$pathTreeViewFileExt#" pathToExpand="" sortMethod="getName">
    <file:TagFileListItem name="myFile" scope="request"/>
    <logic:TagIf expression="#R$myFile.File.isFile#">
    <request:TagDefineCount name="count" scope="request"/>
                                <tr class="treeviewFileList<logic:TagIf expression="(#R$count#%2)==0">Colored</logic:TagIf>">
                                    <td class="treeviewFileList">
                                            <html:TagInput attrType="hidden" attrName="chk#R$myFile.Index#"/>
                                            <img src="/WorkSpace/img/TreeView/ot0.gif" width="18" height="18" border="0" align="top"/>
                                    </td>
                                    <td class="treeviewFileList">
                                        <html:TagA attrClass="treeviewMain" attrHref="actionfilereader?application=#R$application<encoding=UTF-8>#&path=#R$pathToExpand<encoding=UTF-8>#&file=#R$myFile.File.Name<encoding=UTF-8>#&contentType=application/x-download">
                                            <file:TagFileListItem methode="getName"/>
                                        </html:TagA>
                                    </td>
                                    <td class="treeviewFileList">
                                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=PageFileEditor&application=#R$application#&pathToExpand=#R$pathToExpand#&FileName=#R$myFile.getPathUriRelative<encoding=UTF-8>#', 'PageFileEditor', 750, 630)"><img unselectable="on" width="15" height="15" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Common/file_editor.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="File editor"/></html:TagA>
                                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&application=#R$application#&fileName=#R$pathToExpand##R$myFile.getPathUriRelative<encoding=UTF-8>#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" width="15" height="15" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_del_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete File"/></html:TagA>
                                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageRename&application=#R$application#&oldName=#R$pathToExpand##R$myFile.getPathUriRelative<encoding=UTF-8>#&newName=#R$pathToExpand##R$myFile.getPathUriRelative<encoding=UTF-8>#', 'EditorJavaPageRename', 320, 120)"><img unselectable="on" width="15" height="15" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_rename_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Rename File"/></html:TagA>
                                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=#R$pathToExpand##R$myFile.getPathUriRelative<encoding=UTF-8>#&pathDst=#R$pathToExpand##R$myFile.getPathUriRelative<encoding=UTF-8>#&path=&type=file', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" width="15" height="15" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
                                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=AdminStreaming&application=#R$application#&path=#R$pathToExpand#&filename=#R$myFile.getPathUriRelative<encoding=UTF-8>#', 'AdminStreaming', 390, 150)"><img unselectable="on" width="15" height="15" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Streaming"/></html:TagA>
                                    </td>

                                    <td class="treeviewFileList">
                                        <date:TagDateFormat time="#R$myFile.File.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/>
                                    </td>
                                    <td class="treeviewFileList" align="right">
                                        <request:TagPrintAttribut name="myFile.File.length" scope="request"/>
                                    </td>
                                </tr>
<%--
                                <tr class="treeviewFileList" <logic:TagIf expression="(#R$myFile.Index.toString#%2)==0">id="RowFileColored"</logic:TagIf>>
                                <tr class="treeviewFileList">
                                    <td class="treeviewFileList">
                                    </td>
                                </tr>
--%>
        </logic:TagIf>
</file:TagFileList>
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

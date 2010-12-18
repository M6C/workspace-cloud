<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>

<logic:TagIfNotDefine name="path" scope="request" checkNotEmpty="true">
    <request:TagDefineAttribute expression="[#R$application#]" name="path" scope="request"/>
    <path:TagPathFormat name="path" scope="request" application="#R$application#" toURI="true"/>
</logic:TagIfNotDefine>
<logic:TagIfDefine name="pathToExpand" scope="request">
    <request:TagDefineAttribute scope="request" name="pathTreeViewFile" expression="#R$path##R$pathToExpand#"/>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="pathToExpand" scope="request">
    <logic:TagIfDefine name="path" scope="request">
        <request:TagDefineAttribute scope="request" name="pathTreeViewFile" expression="#R$path#"/>
    </logic:TagIfDefine>
</logic:TagIfNotDefine>

<table class="treeview">
    <tr>
        <td class="treeviewTopLeft"><IMG class="BorderTopRight" src="/WorkSpace/img/TreeView/b.gif"></td>
        <td class="treeviewTop"></td>
        <td class="treeviewTopRight"></td>
    </tr>
    <tr>
        <td class="treeviewLeft"></td>
        <th class="treeviewHeader">
            <html:TagA attrClass="treeviewHeader" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&pathToExpand=#R$pathToExpand##R$paramOther#">
                <logic:TagIfDefine name="pathToExpand" scope="request" checkNotEmpty="true">
                    <eval:TagEval expression='new java.io.File("#R$pathTreeViewFile#").getName()'/>
                </logic:TagIfDefine>
                <logic:TagIfNotDefine name="pathToExpand" scope="request" checkNotEmpty="true">
                    <request:TagPrintAttribut name="application" scope="request"/>
                </logic:TagIfNotDefine>
            </html:TagA>&nbsp;
        </th>
        <td class="treeviewRight"></td>
    </tr>
    <tr>
        <td class="treeviewLeft"></td>
        <td class="treeviewMain">
            <div class="treeviewScrollBar">
                <table width="200%">
                    <file:TagFileList path="#R$pathTreeViewFile#" pathToExpand="" sortMethod="getName">
                        <file:TagFileListItem name="myFile" scope="request"/>
                        <logic:TagIf expression='"#R$myFile.Index#".equals("0")'>
                            <request:TagDefineCount name="cnt" scope="request"/>
                        </logic:TagIf>
                        <logic:TagIf expression="#R$myFile.isFile#">
                            <tr><td class="treeviewMain">
                            <html:TagA attrName="anchor#R$cnt##R$myFile.Index#" attrClass="treeviewMain" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$myFile.getPathUriRelative<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#\#anchor#R$cnt##R$myFile.Index#">
                                <img src="/WorkSpace/img/TreeView/ot0.gif" border="0" align="top"/>
                            </html:TagA>
                            <html:TagA attrName="anchor#R$cnt##R$myFile.Index#" attrClass="treeviewHeader" attrHref="javascript:onClickTvFile('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&FileName=#R$myFile.getPathUriRelative<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>#&navIndex=1&navNbRow=50#R$paramOther#', '#R$myFile.getName<encoding=UTF-8>#')">
                                <file:TagFileListItem methode="getName"/>
                            </html:TagA>
                            </td><td class="treeviewMain">
                            <date:TagDateFormat time="#R$myFile.File.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/>
                            </td><td class="treeviewMain" align="right">
                            <html:TagFont attrSize="2" content="#R$myFile.File.length#"/>
                            </td></tr>
                        </logic:TagIf>
                    </file:TagFileList>
                </table>
            </div>
        </td>
        <td class="treeviewRight"></td>
    </tr>
    <tr>
        <td class="treeviewBottomLeft"></td>
        <td class="treeviewBottom"></td>
        <td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/WorkSpace/img/TreeView/b.gif"></td>
    </tr>
</table>
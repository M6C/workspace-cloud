<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>

<table class="treeview">
    <tr>
        <td class="treeviewTopLeft"><IMG class="BorderTopLeft" src="/img/TreeView/b.gif"></td>
        <td class="treeviewTop"></td>
        <td class="treeviewTopRight"></td>
    </tr>
        <tr>
            <td class="treeviewLeft"></td>
            <th class="treeviewHeader">
                    <jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true"/>
                    &nbsp;
                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=#R$formNameToSubmit#&formName=#R$formName#&fieldName=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">
                      <img src="/img/Style/Classic/Header/Header_01_down.gif" height="14px">
                    </html:TagA>
            </th>
            <td class="treeviewRight"></td>
        </tr>
    <tr>
        <td class="treeviewLeft"></td>
        <td class="treeviewMain">
            <div class="treeviewScrollBar">
                <table width="200%"><tr><td class="treeviewMain">
                <file:TagFileList path="#R$path#" pathToExpand="#R$pathToExpand#" name="#R$fileListName#" scope="#R$fileListScope#" sortMethod="isFile;getName" filter="#R$fileListFilter#" withDirectory="true">
                    <file:TagFileListItem name="myFile" scope="request"/>
                        <%--logic:TagIf expression='"#R$myFile.Index#".equals("0")'--%>
                        <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).getIndex()==0) {%>
                            <request:TagDefineCount name="cnt" scope="request"/>
                        <%}%>
                        <%--/logic:TagIf--%>
                        &nbsp;
                        <logic:TagFor to="#R$myFile.Index#">
                            &nbsp;
                        </logic:TagFor>
                        <%--logic:TagIf expression="#R$myFile.File.isDirectory#"--%>
                        <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).isDirectory()) {%>
                            <html:TagA attrName="anchor#R$cnt##R$myFile.Index#" attrClass="treeviewMain" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&pathToExpand=#R$myFile.getPathUriRelative<encoding=UTF-8>##R$paramOther#\#anchor#R$cnt##R$myFile.Index#">
                                <img src="/img/TreeView/ot1.gif" border="0" align="top"/>
                                <file:TagFileListItem methode="getName"/>
                            </html:TagA>
                        <%}%>
                        <%--/logic:TagIf--%>
                        <%--logic:TagIf expression="#R$myFile.File.isFile#"--%>
                        <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).isFile()) {%>
                            <html:TagA attrName="anchor#R$cnt##R$myFile.Index#" attrClass="treeviewMain" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&fileName=#R$myFile.getPathUriRelative<encoding=UTF-8>#&pathToExpand=#R$pathToExpand<encoding=UTF-8>##R$paramOther#\#anchor#R$cnt##R$myFile.Index#">
                                <img src="/img/TreeView/ot0.gif" border="0" align="top"/>
                                <file:TagFileListItem methode="getName"/>
                            </html:TagA>
                        <%}%>
                        <%--/logic:TagIf--%>
                        <br>
                </file:TagFileList>
                </td></tr></table>
            </div>
        </td>
        <td class="treeviewRight"></td>
    </tr>
    <tr>
        <td class="treeviewBottomLeft"></td>
        <td class="treeviewBottom"></td>
        <td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/img/TreeView/b.gif"></td>
    </tr>
</table>
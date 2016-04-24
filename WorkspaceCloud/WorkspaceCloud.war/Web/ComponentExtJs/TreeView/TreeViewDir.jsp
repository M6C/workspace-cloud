<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>

<logic:TagIfNotDefine name="path" scope="request" checkNotEmpty="true">
	<logic:TagIfDefine name="application" scope="request" checkNotEmpty="true">
  	  <request:TagDefineAttribute expression="[#R$application#]" name="path" scope="request"/>
  	  <path:TagPathFormat name="path" scope="request" application="#R$application#" toURI="true"/>
	</logic:TagIfDefine>
</logic:TagIfNotDefine>

    <table class="treeview">
    <tr>
        <td class="treeviewTopLeft"><IMG class="BorderTopLeft" src="/img/TreeView/b.gif"></td>
        <td class="treeviewTop"></td>
        <td class="treeviewTopRight"></td>
    </tr>
        <tr>
            <td class="treeviewLeft"></td>
            <th class="treeviewHeader">
              <html:TagA attrClass="treeviewHeader" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#">
                 <img width="15px" height="14px" src="/img/Common/home_small.gif"/>
              </html:TagA>
              &nbsp;
              <jsp:include page="/Web/ComponentExtJs/ComboBox/ComboBoxProjetXml.jsp" flush="true"/>
              &nbsp;
              <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=#R$formNameToSubmit#&formName=#R$formName#&fieldName=pathToExpand&fieldNameApplication=application&application=#R$application#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">
                 <img src="/img/Style/Classic/Header/Header_01_down.gif" height="14px">
              </html:TagA>
            </th>
            <td class="treeviewRight"></td>
        </tr>
    <tr>
        <td class="treeviewLeft"></td>
        <td class="treeviewMain">
            <div class="treeviewScrollBar" id="treeviewDir">
                <table width="200%"><tr><td class="treeviewMain">
                <file:TagFileList path="#R$path#" pathToExpand="#R$pathToExpand#" name="#R$fileListName#" scope="#R$fileListScope#" sortMethod="getName">
                    <file:TagFileListItem name="myFile" scope="request"/>
                    <%--logic:TagIf expression='"#R$myFile.Index#".equals("0")'--%>
                    <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).getIndex()==0) {%>
                        <request:TagDefineCount name="cnt" scope="request"/>
                    <%}%>
                    <%--/logic:TagIf--%>
                    <%--logic:TagIf expression="#R$myFile.isDirectory#"--%>
                    <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).isDirectory()) {%>
                        &nbsp;
                        <logic:TagFor to="#R$myFile.Index#">
                            &nbsp;
                        </logic:TagFor>
                        <html:TagA attrName="anchor#R$cnt##R$myFile.Index#" attrClass="treeviewMain" attrHref="action.servlet?event=#R$eventDst#&application=#R$application<encoding=UTF-8>#&pathToExpand=#R$myFile.getPathUriRelative<encoding=ISO-8859-1>##R$paramOther#\#anchor#R$cnt##R$myFile.Index#">
                            <img src="/img/TreeView/ot1.gif" border="0" align="top"/>
                        </html:TagA>
                        <html:TagA attrName="anchor#R$cnt##R$myFile.Index#" attrClass="treeviewHeader" attrHref="javascript:onClickTvDir('eventDst=#R$eventDst#&application=#R$application<encoding=UTF-8>#&pathToExpand=#R$myFile.getPathUriRelative<encoding=ISO-8859-1>##R$paramOther#', 'anchor#R$cnt##R$myFile.Index#')">
                            <file:TagFileListItem methode="getName"/>
                        </html:TagA>
                        <br>
                    <%}%>
                    <%--/logic:TagIf--%>
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
<%--
<script type="text/javascript">
document.getElementById("divTreeviewDir").focus();
</script>
--%>
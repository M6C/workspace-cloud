<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<file:TagFileList path="C:/Tmp" pathToExpand="#R$pathToExpand#" sortMethod="getName">
  <file:TagFileListItem name="myFile" scope="request"/>
  <logic:TagFor to="#R$myFile.Index#">
    &nbsp;
  </logic:TagFor>
  <%--logic:TagIf expression="#R$myFile.File.isFile#"--%>
  <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).isFile()) {%>
    <html:TagA attrHref="#R$myFile.File.toURL#">
      <img src="/img/TreeView/ot0.gif" border="0" align="top"/>
      <file:TagFileListItem methode="getName"/>
    </html:TagA>
  <%}%>
  <%--/logic:TagIf--%>
  <%--logic:TagIf expression="#R$myFile.File.isDirectory#"--%>
  <%if (((framework.taglib.file.bean.BeanFile)request.getAttribute("myFile")).isDirectory()) {%>
    <html:TagA attrHref="/action.servlet?event=index&pathToExpand=#R$myFile.File.toString#">
      <img src="/img/TreeView/ot1.gif" border="0" align="top"/>
      <file:TagFileListItem methode="getName"/>
    </html:TagA>
  <%}%>
  <%--/logic:TagIf--%>
  <br>
</file:TagFileList>

<%--
<%@ page contentType="text/html;charset=ISO-8859-1"%>
<%@ page pageEncoding="ISO-8859-1"%>
--%>
<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<html>
    <head>
<%--
    <meta http-equiv="content-type" content="text/html;charset=ISO-8859-1">
--%>
        <title>
            Hibernate Generator JSP
            <logic:TagIfDefine name="FileName" scope="request">
                - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/>
            </logic:TagIfDefine>
            - User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
        </title>
      <link href="/WorkSpace/css/page/hibernate/page.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/WorkSpace/js/page/common/function.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/hibernate/page.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
    </head>
    <body>
        <table cellspacing="0" cellpadding="0" width="100%" height="100%">
        <tr height="10%" valign="top" align="center">
            <td colspan="2" valign="top">
                <div id="reloadmenu">
                    <jsp:include page="/Web/Component/Menu/Hibernate/MenuHeader.jsp" flush="true"/>
                </div>
            </td>
        </tr>
            <tr height="*" valign="top">
                <td class="MainRight" id="rData1">
					<form name="formTableList" action="action.servlet" method="post">
						<input type="hidden" name="event" value="HbnGeneratorJspTableValider"/>
						<html:TagInput attrType="hidden" attrName="schema" attrValue="#R$schema#"/>
	                    <table class="treeview">
                             <tr>
                                 <td class="treeviewTopLeft"><IMG class="BorderTopLeft" src="/WorkSpace/img/TreeView/b.gif"></td>
                                 <td class="treeviewTop"></td>
                                 <td class="treeviewTopRight"></td>
                             </tr>
                             <tr>
	                             <td class="treeviewLeft"></td>
	                             <td class="treeviewMain" valign="top" align="center">
	                                   <jsp:include page="/Web/Page/Hibernate/Generator/Schema.jsp" flush="true"/>
	                             </td>
	                             <td class="treeviewRight"></td>
                             </tr>
                             <tr>
	                             <td class="treeviewLeft"></td>
	                             <td class="treeviewMain" valign="top" align="center">
	                                  <jsp:include page="/Web/Page/Hibernate/Generator/Parameter.jsp" flush="true"/>
	                             </td>
	                             <td class="treeviewRight"></td>
                             </tr>
                             <tr>
	                             <td class="treeviewLeft"></td>
	                             <td class="treeviewMain" valign="top" align="center">
	                                  <jsp:include page="/Web/Page/Hibernate/Generator/Table.jsp" flush="true"/>
	                             </td>
	                             <td class="treeviewRight"></td>
                             </tr>
                             <tr>
	                             <td class="treeviewLeft"></td>
	                             <td class="treeviewMain" valign="top" align="center">
									<input type="submit" value="Valider"/>
	                             </td>
	                             <td class="treeviewRight"></td>
                             </tr>
                             <tr>
                                 <td class="treeviewBottomLeft"></td>
                                 <td class="treeviewBottom"></td>
                                 <td class="treeviewBottomRight"><IMG class="BorderBottomRight" src="/WorkSpace/img/TreeView/b.gif"></td>
                             </tr>
	                    </table>
					</form>
               </td>
        </tr>
       </table>
    </body>
</html>
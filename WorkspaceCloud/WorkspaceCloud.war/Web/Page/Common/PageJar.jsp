<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="xml" %>
<%String paramOther = java.net.URLEncoder.encode("&pathSrc="+request.getParameter("pathSrc"));%>

<html>
    <head>
        <title>
            Make Jar
        </title>
    <link href="/css/page/common/pagejar.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/js/page/common/pagejar.js" type="text/javascript"></script>
        <script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
    </head>
    <body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
    <form name="EditorJavaWar" action="action.servlet" onSubmit="javaScript:form_submit(this);">
            <html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageJarValider"/>
            <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
            <html:TagInput attrType="hidden" attrName="package" attrValue="#R$package#"/>
            <html:TagInput attrType="hidden" attrName="type" attrValue="#R$type#"/>
            <table width="100%" height="100%"><tr><td align="center" valign="center">
                        <font class="input_title_inverse">Package&nbsp;:</font>
                        &nbsp;
                        <jsp:include page="/Web/Component/ComboBox/ComboBoxPackageXml.jsp" flush="true">
                            <jsp:param name="eventDst" value="EditorJavaPageJar"/>
                            <jsp:param name="type" value="Jar"/>
                        </jsp:include>
                        &nbsp;
                        <input type="submit" value="Create Jar"/>
            </td></tr></table>
       </form>
    </body>
</html>
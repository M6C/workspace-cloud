<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
        <title>
            File Upload Test Page
        </title>
            <link href="/WorkSpace/css/page/common/pageupload.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/WorkSpace/js/page/common/pageupload.js" type="text/javascript"></script>
    </head>
    <body onUnLoad="javascript:form_unload()">
        Select the file to upload.
        <form action="actionfileupload" enctype="multipart/form-data" method="post" onSubmit="javaScript:form_submit(this)">
            <html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageUploadValider"/>
            <html:TagInput attrType="hidden" attrName="path" attrValue="#R$path#"/>
            <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
            <input type="hidden" name="size" value="5">
            <table align=center>
                <tr>
                    <td>
                        <font class="input_title_inverse">File Path :</font>
                    </td>
                    <td>
                        <input type="file" name="file" value="" size="40" maxlength="200">
                    </td>
                </tr>
                <tr>
                    <td colspan=2 align=center>
                        <input type="submit" name="uploadservlet" value="Upload">
                    </td>
                </tr>
            </table>
        </form>
<%--
        <jsp:include page="/Web/Component/Extand/Upload.jsp" flush="true">
            <jsp:param name="eventDst" value="EditorJavaPageUploadValider"/>
        </jsp:include>
--%>
        <hr>
        <!-- hhmts start -->
        Last modified: Sat Feb 23 21:39:06 2002
        <!-- hhmts end -->
    </body>
</html>

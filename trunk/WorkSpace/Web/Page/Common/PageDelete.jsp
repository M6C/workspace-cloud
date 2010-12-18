<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<html>
    <head>
        <title>
            Delete
        </title>
            <link href="/WorkSpace/css/page/common/pagedelete.css" rel="stylesheet" type="text/css"/>
        <script language="javascript" src="/WorkSpace/js/page/common/pagedelete.js" type="text/javascript"></script>
    </head>
    <body bgcolor="buttonface" onUnLoad="javascript:form_unload()">
        <form name="EditorJavaDelete" action="action.servlet" onSubmit="javascript:form_submit(this)">
            <html:TagInput attrType="hidden" attrName="event" attrValue="EditorJavaPageDeleteValider"/>
            <html:TagInput attrType="hidden" attrName="fileName" attrValue="#R$fileName#"/>
            <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
            <table width="100%" height="100%">
                <tr>
                    <td width="100%" height="100%" align="center" valign="center">
                        <input name="button" id="button" type="submit"/>
                    </td>
                </tr>
            </table>
        </form>
<script type="javascript">
document.EditorJavaDelete.button.focus();
</script>
    </body>
</html>

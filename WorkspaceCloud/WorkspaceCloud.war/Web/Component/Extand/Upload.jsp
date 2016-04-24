<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%--
<form action="action.servlet" enctype="multipart/form-data" method="post">
<form action="action.servlet" method="post">
--%>
<form action="actionfileupload" enctype="multipart/form-data" method="post">
    <html:TagInput attrType="hidden" attrName="event" attrValue="#R$eventDst#"/>
    <html:TagInput attrType="hidden" attrName="path" attrValue="#R$path#"/>
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

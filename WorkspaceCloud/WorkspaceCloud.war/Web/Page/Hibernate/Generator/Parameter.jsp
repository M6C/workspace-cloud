<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>

<table width="50%">
    <hr>
        <td colspan="3" align="center">Parametres</td>
    </hr>
    <tr>
        <td>Model</td>
        <td>
            <input type="hidden" name="modelCount" value="2"/>
            <%--
            <html:TagInput attrType="text" attrName="model1" attrValue="#R$model1#" attrSize="100"/>
            <br>
            <html:TagInput attrType="text" attrName="model2" attrValue="#R$model2#" attrSize="100"/>
            --%>
            &nbsp;
            <table>
            <tr>
                <td class="parameter" align="center">Jsp model</td>
                <td class="parameter"></td>
                <td class="parameter" align="center">Jsp destination name</td>
                <td class="parameter"></td>
                <td class="parameter" align="center">Service name</td>
                <td class="parameter" align="center" colspan="5">Event</td>
            </tr>
            <tr>
                <td class="parameter"><input type="text" name="model0" value="[Catalogue]/model/model.jsp" size="50"/></td>
                <td class="parameter">=></td>
                <td class="parameter"><input type="text" name="destName0" value="{TABLE_NAME}.jsp" size="25"/></td>
                <td class="parameter">-</td>
                <td class="parameter"><input type="text" name="servName0" value="{SCHEMA}{TABLE_NAME}{EVENT}" size="25"/></td>
                <td class="parameter">Ins<br><input type="checkbox" name="modelIns0" alt="Insert" checked="checked"/></td>
                <td class="parameter">Upd<br><input type="checkbox" name="modelUpd0" alt="Update" checked="checked"/></td>
                <td class="parameter">Lst<br><input type="checkbox" name="modelLst0" alt="List"   checked="checked"/></td>
                <td class="parameter">Sel<br><input type="checkbox" name="modelSel0" alt="Select" checked="checked"/></td>
                <td class="parameter">Del<br><input type="checkbox" name="modelDel0" alt="Delete" checked="checked"/></td>
            </tr>
            <tr>
                <td class="parameter"><input type="text" name="model1" value="[Catalogue]/model/modelSel.jsp" size="50"/></td>
                <td class="parameter">=></td>
                <td class="parameter"><input type="text" name="destName1" value="{TABLE_NAME}_Sel.jsp" size="25"/></td>
                <td class="parameter">-</td>
                <td class="parameter"><input type="text" name="servName1" value="{SCHEMA}{TABLE_NAME}{EVENT}Fk" size="25"/></td>
                <td class="parameter">Ins<br><input type="checkbox" name="modelIns1" alt="Insert"/></td>
                <td class="parameter">Upd<br><input type="checkbox" name="modelUpd1" alt="Update"/></td>
                <td class="parameter">Lst<br><input type="checkbox" name="modelLst1" alt="List"   checked="checked"/></td>
                <td class="parameter">Sel<br><input type="checkbox" name="modelSel1" alt="Select" checked="checked"/></td>
                <td class="parameter">Del<br><input type="checkbox" name="modelDel1" alt="Delete"/></td>
            </tr>
            </table>
        </td>
        <td>
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=formTableList&fieldNameFile=model&fileListFilter=(jsp)', 'EditorJavaPageSelectDirFile', 340, 350)">...</html:TagA>
        </td>
    </tr>
    <tr>
        <td>Destination</td>
        <td>
            <%--html:TagInput attrType="text" attrName="destination" attrValue="#R$destination#" attrSize="100"/--%>
            <input type="text" name="destination" value="[Catalogue]/Catalogue/Web/Page/Catalogue" size="100"/>
            <%--
            <br><span style="font-size:smaller;">[Catalogue]/Catalogue/Web/Page/Catalogue</span>
            --%>
        </td>
        <td>
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formName=formTableList&fieldName=destination', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
        </td>
    </tr>
    <tr>
        <td colspan="2">&nbsp;</td>
    </tr>
    <tr>
        <td>XML Path Target</td>
        <td>
            <%--html:TagInput attrType="text" attrName="xmlpathtarget" attrValue="#R$xmlpathtarget#" attrSize="100"/--%>
            <input type="text" name="xmlpathtarget" value="/Web/Page/Catalogue" size="100"/>
            <%--
            <br><span style="font-size:smaller;">/Catalogue</span>
            <br><span style="font-size:smaller;">/Web/Page/Catalogue</span>
            --%>
        </td>
        <td>
            &nbsp;
        </td>
    </tr>
    <tr>
        <td>XML Destination</td>
        <td>
            <%--html:TagInput attrType="text" attrName="xmldestination" attrValue="#R$xmldestination#" attrSize="100"/--%>
            <input type="text" name="xmldestination" value="[Catalogue]/xml" size="100"/>
            <%--
            <br><span style="font-size:smaller;">[Catalogue]/Catalogue/xml</span>
            --%>
        </td>
        <td>
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=formTableList&fieldNameFile=xml&fileListFilter=(xml)', 'EditorJavaPageSelectDirFile', 340, 350)">...</html:TagA>
        </td>
    </tr>
    <tr>
        <td>XML Model</td>
        <td>
            <%--html:TagInput attrType="text" attrName="xml" attrValue="#R$xml#" attrSize="100"/--%>
            <input type="text" name="xml" value="[Catalogue]/model/Catalogue_Servlet.xml" size="100"/>
            <%--
            <br><span style="font-size:smaller;">[Catalogue]/model/Catalogue_Servlet.xml</span>
            --%>
        </td>
        <td>
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=formTableList&fieldNameFile=xml&fileListFilter=(xml)', 'EditorJavaPageSelectDirFile', 340, 350)">...</html:TagA>
        </td>
    </tr>
    <tr>
        <td>HBN Path</td>
        <td>
            <%--html:TagInput attrType="text" attrName="hbnpath" attrValue="#R$hbnpath#" attrSize="100"/--%>
            <input type="text" name="hbnpath" value="[Catalogue]/hbm/*.hbm" size="100"/>
            <%--
            <br><span style="font-size:smaller;">[Catalogue]/Catalogue/WEB-INF/classes</span>
            --%>
        </td>
        <td>
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDirFile&formName=formTableList&fieldNameFile=hbnpath&fileListFilter=(hbn)', 'EditorJavaPageSelectDirFile', 340, 350)">...</html:TagA>
        </td>
    </tr>
</table>

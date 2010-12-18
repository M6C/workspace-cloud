<%--
Paramètres à definir pour utiliser ce composant
  -- Obligatoires:
    * myID  : Login de l'utilisateur connectamp;eacute;
    * myPWD : Password de l'utilisateur connectamp;eacute;
  -- Optionnels
    * paramOther : Autres paramètres à mettre dans les 'value' des options dans le changement de projets
--%>
<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="Xml" %>
<select name="EditorProjet" onchange='javascript:document.location="action.servlet?event=<request:TagPrintAttribut name="eventDst" scope="request"/>&application="+this.options[this.selectedIndex].value+"<request:TagPrintAttribut name="paramOther" scope="request"/>";'>
    <option value="#"></option>
    <Xml:TagXml name="resultDom" scope="session" path="/ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION">
        <Xml:TagXmlValue path="@Name" name="xmlApp" scope="request"/>
        <html:TagOption attrValue="#R$xmlApp#" initFromRequestName="application">
            <Xml:TagXmlValue path="@Name"/>
        </html:TagOption>
    </Xml:TagXml>
</select>
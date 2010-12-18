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
<script>
   function go(val) {
      document.forms[0].event.value = '<request:TagPrintAttribut name="eventDst" scope="request"/>';
      document.forms[0].package.value = val;
      document.forms[0].submit();
   }
</script>
<%--
<html:TagSelect attrName="EditorPackage" attrOnchange="javascript:document.location='action.servlet?event=#R$eventDst#&application=#R$application#&type=#R$type#&package='+this.options[this.selectedIndex].value#R$paramOther#">
--%>
<html:TagSelect attrName="EditorPackage" attrOnchange="javascript:go(this.options[this.selectedIndex].value)">
    <option value="#"></option>
    <Xml:TagXml name="resultDom" scope="session" path="/ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name='#R$application#']/PACKAGING/PACKAGE[@Type='#R$type#']">
        <Xml:TagXmlValue path="@Name" name="xmlPkg" scope="request"/>
        <html:TagOption attrValue="#R$xmlPkg#" initFromRequestName="package">
            <Xml:TagXmlValue path="@Name"/>
        </html:TagOption>
    </Xml:TagXml>
</html:TagSelect>

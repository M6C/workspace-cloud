<%--
Paramètres à definir pour utiliser ce composant
  -- Obligatoires:
    * eventDst : Evenement pour reafficher la page lorsque l'utilisateur selection un chemin
    * formName : Nom du formulaire dans lequel les champs doivent être mise à jour
    * fieldNameDir : Nom du champ qui doit être modifie avec le repertoire selectionne
    * fieldNamePrj : Nom du champ qui doit être modifie avec le projet selectionne
    * fieldNameFile : Nom du champ qui doit être modifie avec le fichier selectionne
  -- Optionnels
    * formNameToSubmit : Nom du formulaire à  valider (Submit) lorsque le bouton 'Submit' est presse
--%>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>

<%
	String paramOther = "&formName="+request.getParameter("formName");
	if(request.getParameter("formNameToSubmit")!=null)
		paramOther+="&formNameToSubmit="+request.getParameter("formNameToSubmit");
	if(request.getParameter("fieldNamePrj")!=null)
		paramOther+="&fieldNamePrj="+request.getParameter("fieldNamePrj");
	if(request.getParameter("fieldNameDir")!=null)
		paramOther+="&fieldNameDir="+request.getParameter("fieldNameDir");
	if(request.getParameter("fileListFilter")!=null)
		paramOther+="&fileListFilter="+request.getParameter("fileListFilter");
	paramOther+="&fieldNameFile="+request.getParameter("fieldNameFile");
%>
<form onSubmit="javascript:form_submit()">
	<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
	<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
	<html:TagInput attrType="hidden" attrName="fileName" attrValue="#R$fileName#"/>
	<table align="center">
		<tr>
			<td>
				<jsp:include page="/Web/Component/TreeView/TreeViewDirFile_Border01.jsp" flush="true">
					<jsp:param name="paramOther" value="<%=paramOther%>"/>
				</jsp:include>
			</td>
	    	</tr>
		<tr>
    			<td align="center">
				<input type="submit" value="Go"/>
		    	</td>
		</tr>
	</table>
</form>

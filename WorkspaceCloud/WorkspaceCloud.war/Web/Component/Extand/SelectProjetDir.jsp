<%--
Paramètres à definir pour utiliser ce composant
  -- Obligatoires:
    * eventDst : Evenement pour reafficher la page lorsque l'utilisateur selection un chemin
    * formName : Nom du formulaire dans lequel les champs doivent être mise à jour
    * fieldNameDir : Nom du champ qui doit être modifie avec le repertoire selectionne
    * fieldNamePrj : Nom du champ qui doit être modifie avec le projet selectionne
  -- Optionnels
    * formNameToSubmit : Nom du formulaire à  valider (Submit) lorsque le bouton 'Submit' est presse
--%>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>

<%
  String paramOther = "&formName="+request.getParameter("formName");
  paramOther+="&fieldNameDir="+request.getParameter("fieldNameDir");
  paramOther+="&fieldNamePrj="+request.getParameter("fieldNamePrj");
  if(request.getParameter("formNameToSubmit")!=null)
    paramOther+="&formNameToSubmit="+request.getParameter("formNameToSubmit");
/*
  if(request.getParameter("fieldNameJava")!=null)
    paramOther+="&fieldNameJava="+request.getParameter("fieldNameJava");
  if(request.getParameter("fieldNameJar")!=null)
    paramOther+="&fieldNameJar="+request.getParameter("fieldNameJar");
*/
//  paramOther = java.net.URLEncoder.encode(paramOther);
%>
<form onSubmit="javascript:form_submit()">
	<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
<%--
	<html:TagInput attrType="hidden" attrName="pathSrc" attrValue="#R$pathSrc#"/>
	<html:TagInput attrType="hidden" attrName="pathBuildJava" attrValue="#R$pathBuildJava#"/>
	<html:TagInput attrType="hidden" attrName="pathBuildJar" attrValue="#R$pathBuildJar#"/>
--%>
	<%-- pathPrj --%>
<%--
	<logic:TagIfDefine name="pathPrj" scope="request">
		<html:TagInput attrType="hidden" attrName="pathPrj" attrValue="#R$pathPrj#"/>
	</logic:TagIfDefine>
	<logic:TagIfNotDefine name="pathPrj" scope="request">
		<logic:TagIfDefine name="path" scope="request">
			<html:TagInput attrType="hidden" attrName="pathPrj" attrValue="#R$path#"/>
		</logic:TagIfDefine>
	</logic:TagIfNotDefine>
--%>
	<%-- pathDst --%>
<%--
	<logic:TagIfDefine name="pathToExpand" scope="request">
		<html:TagInput attrType="hidden" attrName="pathDst" attrValue="#R$pathToExpand#"/>
	</logic:TagIfDefine>
	<logic:TagIfNotDefine name="pathToExpand" scope="request">
		<logic:TagIfDefine name="pathPrj" scope="request">
			<html:TagInput attrType="hidden" attrName="pathDst" attrValue="#R$pathPrj#"/>
		</logic:TagIfDefine>
		<logic:TagIfNotDefine name="pathPrj" scope="request">
			<logic:TagIfDefine name="pathDst" scope="request">
				<html:TagInput attrType="hidden" attrName="pathDst" attrValue="#R$pathDst#"/>
			</logic:TagIfDefine>
			<logic:TagIfNotDefine name="pathDst" scope="request">
				<logic:TagIfDefine name="path" scope="request">
					<html:TagInput attrType="hidden" attrName="pathDst" attrValue="#R$path#"/>
				</logic:TagIfDefine>
			</logic:TagIfNotDefine>
		</logic:TagIfNotDefine>
	</logic:TagIfNotDefine>
--%>
	<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
	<table align="center">
		<tr>
			<td valign="top">
				<jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
					<jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
					<jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
					<jsp:param name="eventDst" value='<%=request.getParameter("event")%>'/>
					<jsp:param name="paramOther" value="<%=paramOther%>"/>
				</jsp:include>
			</td>
		</tr>
		<tr>
			<td>
				<jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
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

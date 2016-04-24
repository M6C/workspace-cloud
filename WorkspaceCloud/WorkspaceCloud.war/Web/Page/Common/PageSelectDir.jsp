<%--
Paramètres à definir pour utiliser ce composant
  -- Obligatoires:
    * eventDst : Evenement pour reafficher la page lorsque l'utilisateur selection un chemin
    * formName : Nom du formulaire dans lequel les champs doivent être mise à jour
    * fieldName : Nom du champ qui doit être modifie avec le repertoire selectionne
  -- Optionnels
    * formNameToSubmit : Nom du formulaire à  valider (Submit) lorsque le bouton 'Submit' est presse
--%>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%
  String paramOther = "&formName="+request.getParameter("formName");
  paramOther+="&fieldName="+request.getParameter("fieldName");
  if(request.getParameter("fieldNameApplication")!=null)
	  paramOther+="&fieldNameApplication="+request.getParameter("fieldNameApplication");
  if(request.getParameter("formNameToSubmit")!=null)
    paramOther+="&formNameToSubmit="+request.getParameter("formNameToSubmit");
//  paramOther = java.net.URLEncoder.encode(paramOther);
%>
<html>
    <head>
        <title>
            Directory Browser&nbsp;-&nbsp;
            <logic:TagIfDefine name="pathToExpand" scope="request">
                <%--eval:TagEval expression='new java.io.File("#R$pathToExpand#").getName()'/--%>
                <file:TagFileName path="#R$pathToExpand#"/>
            </logic:TagIfDefine>
            <logic:TagIfNotDefine name="pathToExpand" scope="request">
                <logic:TagIfDefine name="path" scope="request">
	                <%--eval:TagEval expression='new java.io.File("#R$path#").getName()'/--%>
    	            <file:TagFileName path="#R$path#"/>
                </logic:TagIfDefine>
            </logic:TagIfNotDefine>
        </title>
            <link href="/css/page/common/pageselectdir.css" rel="stylesheet" type="text/css"/>
        <SCRIPT language="JavaScript">
        <!--
            function form_submit(){
                <logic:TagIfDefine name="fieldNameApplication" scope="request" checkNotEmpty="true">
	            self.opener.document.<eval:TagEval expression="&quot;#R$formName#&quot;"/>.<eval:TagEval expression="&quot;#R$fieldNameApplication#&quot;"/>.value = self.document.all['application'].value;
                self.opener.document.<eval:TagEval expression="&quot;#R$formName#&quot;"/>.<eval:TagEval expression="&quot;#R$fieldName#&quot;"/>.value = self.document.all['pathDst'].value;
                </logic:TagIfDefine>
                <logic:TagIfNotDefine name="fieldNameApplication" scope="request" checkNotEmpty="true">
                var str = '[' + self.document.all['application'].value + ']' + self.document.all['pathDst'].value;
                self.opener.document.<eval:TagEval expression="&quot;#R$formName#&quot;"/>.<eval:TagEval expression="&quot;#R$fieldName#&quot;"/>.value = str;
                </logic:TagIfNotDefine>
                <logic:TagIfDefine name="formNameToSubmit" scope="request">
                    if ('<eval:TagEval expression="&quot;#R$formNameToSubmit#&quot;"/>'!='')
                        self.opener.document.<eval:TagEval expression="&quot;#R$formNameToSubmit#&quot;"/>.submit();
                </logic:TagIfDefine>
                window.close();
            }
        -->
        </SCRIPT>
    </head>
    <body bgcolor="buttonface">
<table width="100%" height="100%"><tr><td align="center" valign="middle">
            <form onSubmit="javascript:form_submit()">
            <logic:TagIfDefine name="application" scope="request">
                <html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
            </logic:TagIfDefine>
            <logic:TagIfDefine name="pathToExpand" scope="request">
                <html:TagInput attrType="hidden" attrName="pathDst" attrValue="#R$pathToExpand#"/>
            </logic:TagIfDefine>
            <logic:TagIfNotDefine name="pathToExpand" scope="request">
                <logic:TagIfDefine name="path" scope="request">
                    <html:TagInput attrType="hidden" attrName="pathDst" attrValue="#R$path#"/>
                </logic:TagIfDefine>
            </logic:TagIfNotDefine>
            <table width="300px">
                <tr>
                        <td align="center">
                                    <jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
                                                <jsp:param name="eventDst" value="EditorJavaPageSelectDir"/>
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
</td></tr></table>
    </body>
</html>
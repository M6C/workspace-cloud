<%--
Paramètres à definir pour utiliser ce composant
  -- Obligatoires:
    * formName : Nom du formulaire dans lequel les champs doivent être mise à jour
    * fieldNameDir : Nom du champ qui doit être modifiamp;eacute; avec le repertoire selectionnamp;eacute;
    * fieldNamePrj : Nom du champ qui doit être modifiamp;eacute; avec le projet selectionnamp;eacute;
    * fieldNameFile : Nom du champ qui doit être modifiamp;eacute; avec le fichier selectionnamp;eacute;
  -- Optionnels
    * formNameToSubmit : Nom du formulaire à  valider (Submit) lorsque le bouton 'Submit' est pressamp;eacute;
--%>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<html>
    <head>
        <title>
            Projet Browser
        </title>
            <link href="/WorkSpace/css/page/common/pageselectprojetdir.css" rel="stylesheet" type="text/css"/>
        <SCRIPT language="JavaScript">
        <!--
            function form_submit(){
            	var path;
                <logic:TagIfDefine name="fieldNamePrj" scope="request">
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNamePrj#"'/>.value = self.document.all['application'].value;
                </logic:TagIfDefine>
                <logic:TagIfNotDefine name="fieldNamePrj" scope="request">
                path = '[' + self.document.all['application'].value + ']';
                </logic:TagIfNotDefine>
                <logic:TagIfDefine name="fieldNameDir" scope="request">
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNameDir#"'/>.value = self.document.all['pathToExpand'].value;
                </logic:TagIfDefine>
                <%--
                <logic:TagIfNotDefine name="fieldNameDir" scope="request">
                if (self.document.all['pathToExpand'].value!='')
	                path += self.document.all['pathToExpand'].value + '/';
                </logic:TagIfNotDefine>
                --%>
                path += self.document.all['fileName'].value;
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNameFile#"'/>.value = path;
                <logic:TagIfDefine name="formNameToSubmit" scope="request">
                if ('<eval:TagEval expression='"#R$formNameToSubmit#"'/>'!='')
                    self.opener.document.<eval:TagEval expression='"#R$formNameToSubmit#"'/>.submit();
                </logic:TagIfDefine>
                window.close();
            }
        -->
        </SCRIPT>
    </head>
    <body bgcolor="buttonface">
<table width="100%" height="100%"><tr><td align="center" valign="middle">
        <jsp:include page="/Web/Component/Extand/SelectProjetDirFile.jsp" flush="true">
            <jsp:param name="eventDst" value="EditorJavaPageSelectProjetDirFile"/>
        </jsp:include>
</td></tr></table>
    </body>
</html>
<%--
Paramètres à definir pour utiliser ce composant
  -- Obligatoires:
    * formName : Nom du formulaire dans lequel les champs doivent être mise à jour
    * fieldNameDir : Nom du champ qui doit être modifiamp;eacute; avec le repertoire selectionnamp;eacute;
    * fieldNamePrj : Nom du champ qui doit être modifiamp;eacute; avec le projet selectionnamp;eacute;
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
<%--
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNameDir#"'/>.value = self.document.all['pathDst'].value;
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNamePrj#"'/>.value = self.document.all['pathPrj'].value;
                <logic:TagIfDefine name="fieldNameJava" scope="request">
                    self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNameJava#"'/>.value = self.document.all['pathBuildJava'].value;
                </logic:TagIfDefine>
                <logic:TagIfDefine name="fieldNameJar" scope="request">
                    self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNameJar#"'/>.value = self.document.all['pathBuildJar'].value;
                </logic:TagIfDefine>
--%>
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNameDir#"'/>.value = self.document.all['pathToExpand'].value;
                self.opener.document.<eval:TagEval expression='"#R$formName#"'/>.<eval:TagEval expression='"#R$fieldNamePrj#"'/>.value = self.document.all['application'].value;
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
        <jsp:include page="/Web/Component/Extand/SelectProjetDir.jsp" flush="true">
            <jsp:param name="eventDst" value="EditorJavaPageSelectProjetDir"/>
        </jsp:include>
</td></tr></table>
    </body>
</html>
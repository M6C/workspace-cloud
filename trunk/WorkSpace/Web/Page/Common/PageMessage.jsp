<%--
Paramètres à definir pour utiliser ce composant
    * msgTitle : Titre de la page
    * msgText  : Message à afficher
--%>

<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<html>
    <head>
        <title>
            <request:TagPrintAttribut name="msgTitle" scope="request"/>
        </title>
            <link href="/WorkSpace/css/page/common/pagemessage.css" rel="stylesheet" type="text/css"/>
    </head>
    <body bgcolor="buttonface">
    <table class="global">
	    <tr><td class="global">
		    <table class="message" id="messageTable">
			    <tr><td class="title">
					Trace
				</td></tr>
			    <tr><td class="message" id="messageCell">
				    <div id="messageScroll">
				      <html:TagFont attrClass="normal" content="#R$traceOut<encoding=HTML>#"/>
				<%--
				      <font class="normal">
				          <request:TagPrintAttribut name="msgText" scope="request"/>
				      </font>
				--%>
					</div>
				</td></tr>
		    </table>
		</td></tr>
    </table>
    </body>
</html>
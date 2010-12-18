<%
framework.ressource.FrmWrkConfig.setup();
framework.ressource.FrmWrkServlet.setup();
//framework.ressource.FrmWrkMenu.setup();
//Redirection vers la page par damp;eacute;fault
response.sendRedirect("action.servlet?event=Home");
%>

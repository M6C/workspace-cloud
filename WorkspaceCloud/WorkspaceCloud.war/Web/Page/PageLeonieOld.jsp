<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<html>
<head>
<title>Lamp;eacute;onie ROCA</title>
<META name="content-language" content="fr">
<META name="description" content="Photos de Lamp;eacute;onie ROCA">
<META name="keywords" content="Lamp;eacute;onie ROCA">
<META name="revisit-after" content="30 days">
<META name="robots" content="all">
<SCRIPT language="JavaScript">
function openWindow(url) {
  popupWin = window.open(url, 'zoom', 'scrollbars,resizable,dependent,width=840,height=650,top=1,left=1')
}
</SCRIPT>

</head>
<body bgcolor="#ffffff">
<h1>Lamp;eacute;onie ROCA</h1>
<br>
<b>Date de naissance</b>&nbsp;&nbsp;&nbsp;:&nbsp;13/08/2003&nbsp;à&nbsp;22h25<br>
<b>Lieu de naissance</b>&nbsp;&nbsp;&nbsp;:&nbsp;Champigny sur Marne<br>
<b>Poid de naissance</b>&nbsp;&nbsp;&nbsp;:&nbsp;3k270<br>
<b>Taille de naissance</b>&nbsp;:&nbsp;50cm<br>
<br>
<%
  String szPathImg = "/Photos/Leonie/";
  String szPath = "/Dev/Travaux/Java/JBuilder8/WorkSpace"+szPathImg;
//  String szPath = "/members/DIDRnjGI6yOUHilItsEF1DKfLtdFnyHE/"+szPathImg;
  File path = new File(szPath);
  if ( path.exists() && path.isDirectory() )
  {
%>
<TABLE>
<%
    int iCell = 1;
    String[] szListFile = path.list();
    Arrays.sort(szListFile , new Comparator()
    {
      public int compare(Object o1,Object o2)
      {
        return (((String)o1).compareTo((String)o2)) ;
      }
      public boolean equals(Object obj)
      {
        return false ;
      }
    });
    String szIndex = request.getParameter("index");
    int index = ((szIndex==null)||(szIndex.equals(""))) ? 0 : Integer.parseInt(szIndex);
    int start = index*10;
    int end = ((start+10)>szListFile.length) ? szListFile.length : start+10;
    for( int i=start ; i<end ; i++ )
    {
      String szFile = szListFile[i];
      if (iCell==1) out.print("<TR>");
%>    <TD><TABLE><TR><TD align="center">Photo&nbsp;N°<%=i+1%></TD></TR><TR><TD align="center"><A HREF="javascript:openWindow('<%=szPathImg+szFile%>');"><IMG width="60" height="50" src="<%=szPathImg+szFile%>"></A></TD></TR></TABLE></TD><%
      if (iCell==5) { out.print("</TR>"); iCell=0; }
      iCell++;
    }
%>
</TR><TR>
<%
    end = ((szListFile.length%10)==0) ? szListFile.length/10 : (szListFile.length/10)+1;
    if(end>0) {
        out.write("<td colspan=\"5\"><center><table><tr>");
        for( int i=0 ; i<end ; i++ )
        {
%>        <TD><%=((i==index) ? "<b>" : "")%><A HREF="action.servlet?event=PageLeonie&path=/Dev/Travaux/Java/JBuilder8/WorkSpace/Photos&index=<%=i%>"><%=i+1%><%=((i==index) ? "</b>" : "")%></A></TD><%
        }
        out.write("</tr></table></center></td>");
    }
%>
</TABLE>
<%
  }
%>
</body>
</html>

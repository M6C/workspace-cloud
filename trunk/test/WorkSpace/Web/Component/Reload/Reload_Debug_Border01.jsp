<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Workspace_Taglib_Path.tld" prefix="path" %>

<logic:TagIfNotDefine name="path" scope="request" checkNotEmpty="true">
	<request:TagDefineAttribute expression="[#R$application#]" name="path" scope="request"/>
	<path:TagPathFormat name="path" scope="request" application="#R$application#" toURI="true"/>
</logic:TagIfNotDefine>

<%-- Affichage du fichier ligne par ligne --%>
    var i=1;
    var str='<table class=\'file_content\'>';
    var application = '<request:TagPrintAttribut name="application" scope="request"/>';
    var path = '<request:TagPrintAttribut name="pathToExpand" scope="request"/>';
    var fileName = '<request:TagPrintAttribut name="FileName" scope="request"/>';
    var classjava = 'workspace.service.SrvEditorJavaNew';
    var classccs = '';
    var idname = '';
    <file:TagFileReader path="#R$path##R$pathToExpand##R$FileName#">
      classccs = (((i%2)==0) ? 'file_content': 'file_content_color')
      idname = (((i%2)==0) ? 'row_select': 'row_select_color')
      str += '<tr>';
      str += '<td class=\'file_content_rownum\' onclick=\'javascript:setBreakpoint("'+classjava+'", '+i+')\'><a name="line'+i+'"/>'+i+'</td>';
      str += '<td class=\''+classccs+'\' onmouseover=\'this.id="'+idname+'";window.status="--> '+application+', '+path+', '+classjava+', '+fileName+', '+i+'"\' onmouseout=\'this.id="";window.status=""\' onclick=\'javascript:setBreakpoint("'+application+'", "'+path+'", "'+classjava+'", "'+fileName+'", '+i+')\'>';
      str += '<file:TagFileReadLine encoding="HTML" endWithNewLine="false"/>';
      str += '</td>';
      str += '</tr>';
      i++;
    </file:TagFileReader>
  str += '</table>';
    document.getElementById('text').innerHTML=str;
<%-- Affiche les breakpoint dans le fichier --%>
<logic:TagIfDefine name="FileName" scope="request">
    var sourceName;
    var lineNumber;
<list:TagList name="beanDebug.virtualMachine.eventRequestManager.breakpointRequests" scope="session">
    <list:TagListItem name="breakpoint" scope="request"/>
  <logic:TagIf expression='new java.io.File("#R$FileName#").getName().equals("#R$breakpoint.location.sourceName#")'>
    sourceName = '<request:TagPrintAttribut name="breakpoint.location.sourceName" scope="request"/>';
    lineNumber =  <request:TagPrintAttribut name="breakpoint.location.lineNumber" scope="request"/>;
    showBreakpoint(lineNumber, 'added');
    </logic:TagIf>
</list:TagList>
</logic:TagIfDefine>
<%-- Colorization de la ligne où le breakpoint c'est arrete--%>
<logic:TagIfDefine name="line" scope="request">
      var line = <request:TagPrintAttribut name="line" scope="request"/>;
    var td = find_TD_at_Line(line, 1);
td.id = ((line%2)==0) ? 'row_brk': 'row_color_brk';
td.onmouseover = '';
td.onmouseout = '';
td.onclick = '';
</logic:TagIfDefine>
<%-- Declanche la verification des breakpoints --%>
<logic:TagIfNotDefine name="line" scope="request">
    Start_BreakpointCheck();
</logic:TagIfNotDefine>

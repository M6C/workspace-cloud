<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_List.tld" prefix="list" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>


<html>
    <head>
        <title>
            Debugger
            <logic:TagIfDefine name="FileName" scope="request">
            - <eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/>
            </logic:TagIfDefine>
            - User:<request:TagPrintAttribut name="BeanAuthentification:login" scope="session"/>
        </title>
      <link href="/WorkSpace/css/page/debugger/page.css" rel="stylesheet" type="text/css">
      <link href="/WorkSpace/css/page/debugger/styles.css" rel="stylesheet" type="text/css">
        <script language="javascript" src="/WorkSpace/js/page/common/iframe_completion03.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/EncodingUTF8.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/EncodingHTML.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/FunctionText.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/HTTPObject.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/debugger/page.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/debugger/Breakpoint.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/debugger/BreakpointAdd.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/debugger/BreakpointCheck.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/debugger/BreakpointStep.js" type="text/javascript"></script>
        <script language="javascript" src="/WorkSpace/js/page/debugger/BreakpointResume.js" type="text/javascript"></script>
    </head>
    <body>
        <table class="main">
                <tr>
                    <td colspan="2">
                    <table class="toolBar">
                        <tr>
                            <td>
                                <A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
                                &nbsp;
                                <A href="javascript:openPopup('action.servlet?event=DebuggerBreakpointVariable', 320, 640)">DebugBreakpointVariable</A>
                                <A href="javascript:BreakpointCheck()">BreakpointCheck</A>
                                <A href="javascript:BreakpointResume()">BreakpointResume</A>
                                <A href="javascript:BreakpointStep('Over')">BreakpointStep Over</A>
                                <A href="javascript:BreakpointStep('Into')">BreakpointStep Into</A>
                                <A href="javascript:BreakpointStep('Out')">BreakpointStep Out</A>
                                <A href="javascript:openPopup('action.servlet?event=DebuggerStart', 320, 120)">DebuggerStart</A>
                                <A href="javascript:openPopup('action.servlet?event=DebuggerStop', 320, 120)">DebuggerStop</A>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr class="main">
                <td class="main_left">
                    <table class="brwsr_dir">
                        <tr class="brwsr_dir_prg">
                            <th class="brwsr_dir">
					                    <jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
					                        <jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
					                        <jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
					                        <jsp:param name="eventDst" value="DebuggerPage"/>
					                    </jsp:include>
					                    <html:TagA attrHref="javascript:openPopup('action.servlet?event=DebuggerPageSelectProjetDir&formNameToSubmit=GoDebugger&formName=GoDebugger&fieldNameDir=pathToExpand&fieldNamePrj=application&application=#R$application#&pathToExpand=#R$pathToExpand#', 'DebuggerPageSelectProjetDir', 300, 370)">...</html:TagA>
                            </th>
                        </tr>
                        <tr class="brwsr_dir">
                            <td class="brwsr_dir">
					                    <jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
	                                <jsp:param name="eventDst" value="DebuggerPage"/>
	                            </jsp:include>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="main_right" rowspan="2">
	                <div class="main_right" id="text">
	                </div>
                </td>
										<%-- Affichage du fichier ligne par ligne --%>
										<script language="javascript">
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
										</script>
										<%-- Affiche les breakpoint dans le fichier --%>
										<logic:TagIfDefine name="FileName" scope="request">
										<script language="javascript">
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
										</script>
										</logic:TagIfDefine>
										<%-- Colorization de la ligne où le breakpoint c'est arrete--%>
										<logic:TagIfDefine name="line" scope="request">
										<script language="javascript">
											var line = <request:TagPrintAttribut name="line" scope="request"/>;
										  var td = find_TD_at_Line(line, 1);
						    		  td.id = ((line%2)==0) ? 'row_brk': 'row_color_brk';
						    		  td.onmouseover = '';
						    		  td.onmouseout = '';
						    		  td.onclick = '';
										</script>
										</logic:TagIfDefine>
										<%-- Declanche la verification des breakpoints --%>
										<logic:TagIfNotDefine name="line" scope="request">
										<script language="javascript">
											Start_BreakpointCheck();
										</script>
										</logic:TagIfNotDefine>
            </tr>
            <tr class="main">
                <td class="main_left">
                   <jsp:include page="/Web/Component/TreeView/TreeViewFile_Border01.jsp" flush="true">
                       <jsp:param name="eventDst" value="DebuggerPage"/>
                   </jsp:include>
                </td>
            </tr>
        </table>
        <table class="main_tab">
            <tr class="main_tab">
                <td class="main_tab_right">
                </td>
                <td class="main_tab_left">
                    <table class="tab">
                        <tr class="tab">
                            <td class="tab" onmouseover="this.id='tab_select'" onmouseout="this.id=''">
                                Debugger
                            </td>
                            <td class="tab" id="tab_selected">
                                Versionning
                            </td>
                            <td class="tab" onmouseover="this.id='tab_select'" onmouseout="this.id=''">
                                File Browser
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </body>
</html>
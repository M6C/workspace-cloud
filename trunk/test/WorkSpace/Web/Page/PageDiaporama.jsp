<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<html>
    <head>
        <title>
            Diaporama
        </title>
	        <link href="/WorkSpace/css/TreeView.css" rel="stylesheet" type="text/css">
	        <link href="/WorkSpace/css/Leonie.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/WorkSpace/js/page/editorjava/page.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/EncodingUTF8.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/EncodingHTML.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/FunctionText.js" type="text/javascript"></script>
		<SCRIPT type="text/javascript">
		<!--
		function openWindow(url) {
		  popupWin = window.open(url, 'zoom', 'scrollbars,resizable,dependent,width=840,height=650,top=1,left=1')
		}
                -->
		</SCRIPT>
	        <link href="/WorkSpace/css/page/pagephoto.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/WorkSpace/js/page/pagephoto.js" type="text/javascript"></script>
	</head>
	<body>
		<table>
	    		<tr valign="top">
			    	<td>
		    			<table>
					    	<tr>
						    	<td>
								<A href="action.servlet?event=Index">home</A>
	    						</td>
					    	</tr>
					    	<tr>
						    	<td>
							        <div class="Leonie_Dir_ScrollBar">
						        	    <table width="400px">
					        	        	<tr>
						                	    <td>
	                	        					<jsp:include page="/Web/Component/TreeView/TreeViewDir.jsp" flush="true">
											<jsp:param name="eventDst" value="PagePhoto"/>
											<jsp:param name="fileListScope" value="request"/>
										</jsp:include>
		                					    </td>
						        	        </tr>
							            </table>
							        </div>
					    		</td>
					    	</tr>
       					</table>
    				</td>
			    	<td>
					<TABLE>
<%int iCell = 1;%>
<file:TagFileList path="#R$pathToExpand#" pathToExpand=""  indexStart="#R$myFileListIndex#" indexEnd="4" indexStep="1" name="myFileList" scope="request">
	<file:TagFileListItem name="myFile" scope="request"/>
	<logic:TagIf expression="#R$myFile.File.isFile#">
<%if (iCell==1) out.print("<TR>");%>
<TD>
	<TABLE>
		<TR>
			<TD align="center">
				<html:TagA attrHref="javascript:openWindow('/WorkSpace/Actionimagereader?file=#R$myFile.File.toURI.getPath#&width=800&height=600');">
					<html:TagImg attrAlt="#R$myFile.File.getName#" attrSrc="/WorkSpace/Actionimagereader?file=#R$myFile.File.toURI.getPath#&width=270&height=210" attrWidth="270" attrHeight="210"/>
				</html:TagA>
			</TD>
		</TR>
		<TR>
			<TD align="center">
				<html:TagA attrHref="javascript:openWindow('/WorkSpace/Actionimagereader?file=#R$myFile.File.toURI.getPath#');">
					Real Size
				</html:TagA>
			</TD>
		</TR>
		<TR>
			<TD align="center">
				<font size="2"><date:TagDateFormat time="#R$myFile.File.lastModified#" pattern="dd/MM/yyyy HH:mm:ss"/></font>
			</TD>
		</TR>
	</TABLE>
</TD>
<%if (iCell==2) { out.print("</TR><TR>"); iCell=0; } iCell++;%>
	</logic:TagIf>
</file:TagFileList>
						<tr>
							<td align="center" colspan="2">
								<file:TagFileListNavigator indexName="myFileListIndex" size="#R$myFileList.size#" attrHref="action.servlet?event=PagePhoto&[index]&path=#R$path#&pathToExpand=#R$pathToExpand#" separator=" - " indexStep="4" indexQuantity="5" isShowPrevious="true" isShowNext="true" libellePrevious="<- Previous " libelleNext=" Next ->"/>
	    						</td>
					    	</tr>
					</TABLE>
	    			</td>
		    	</tr>
        	</table>
	</body>
</html>

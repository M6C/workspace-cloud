<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<html>
    <head>
        <title>
            Versionning
        </title>
	        <link href="/WorkSpace/css/page/versioning/page.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/WorkSpace/js/page/versioning/page.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
	</head>
	<body>
		<table class="memo">
	    		<tr valign="top">
                        	<td>
					<A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
				</td>
                        	<logic:TagIfDefine name="application" scope="request">
<%--
                        	<td>&nbsp;</td>
--%>
		    		<td align="right">
					<table class="toolbar">
						<tr>
                                                        <td>
                                                                <img class="buttonOut" src="/WorkSpace/img/Versionning/cvs_logo.gif" alt="CVS"/>
                                                        </td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionStatus&application=#R$application#&path=#R$pathToExpand#', 'VersionStatus', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_status.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Status"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionImport&application=#R$application#&path=#R$pathToExpand#', 'VersionImport', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_import.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Import"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCheckOut&application=#R$application#&path=#R$pathToExpand#', 'VersionCheckOut', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_checkout.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Check Out"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdate&application=#R$application#&path=#R$pathToExpand#', 'VersionUpdate', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_update.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Update"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommit&application=#R$application#&path=#R$pathToExpand#', 'VersionCommit', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_commit.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionAddDirectory', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_add_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Add Directory"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionUpdDirectory', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_upd_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upd Directory"/></html:TagA>
							</td>
							<td>
                               				        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectory&application=#R$application#&path=#R$pathToExpand#', 'VersionCommitDirectory', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_commit_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit Directory"/></html:TagA>
							</td>
						</tr>
					</table>
				</td>
				</logic:TagIfDefine>
			</tr>
<%--
                </table>
		<table class="memo">
--%>
                  <form name="GoVersionning" action="action.servlet" method="post">
			<input type="hidden" name="event" value="VersionPage"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
	    		<tr valign="top">
		    		<td>
					<jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
						<jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
						<jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="paramOther" value="&includeSubDirectory=#R$includeSubDirectory#"/>
</jsp:include>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDir&formNameToSubmit=GoVersionning&formName=GoVersionning&fieldNameDir=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#&includeSubDirectory=#R$includeSubDirectory#', 'VersionningPageSelectProjetDir', 300, 370)">...</html:TagA>
			    	</td>
				<td>
						<html:TagInput attrType="text" attrName="pathToExpand" attrValue="#R$pathToExpand#" attrSize="100"/>
						<input type="submit" value="Go"/>
        					<html:TagInput attrType="CHECKBOX" attrName="includeSubDirectory" attrValue="true" initFromRequestName="includeSubDirectory"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=GoVersionning&formName=GoVersionning&fieldName=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#&includeSubDirectory=#R$includeSubDirectory#', 'VersionPageSelectDir', 340, 350)">...</html:TagA>
				</td>
			</tr>
			</form>
	    		<tr valign="top">
			    	<td>
          	        		<jsp:include page="/Web/Component/TreeView/TreeViewDirVersioning.jsp" flush="true">
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
    				</td>
			    	<td>
					<jsp:include page="/Web/Component/TreeView/TreeViewFileVersioning.jsp" flush="true">
						<jsp:param name="eventDst" value="VersionPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
	    			</td>
		    	</tr>
		</table>
	</body>
</html>

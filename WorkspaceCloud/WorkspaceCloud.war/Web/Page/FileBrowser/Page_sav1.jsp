<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<%@ taglib uri="Framework_Taglib_Date.tld" prefix="date" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<html>
    <head>
        <title>
            FileBrowser
        </title>
    <link href="/css/page/filebrowser/page.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/js/page/filebrowser/page.js" type="text/javascript"></script>
		<script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
		<script language="javascript" src="/js/EncodingUTF8.js" type="text/javascript"></script>
		<script language="javascript" src="/js/EncodingHTML.js" type="text/javascript"></script>
		<script language="javascript" src="/js/FunctionText.js" type="text/javascript"></script>
	</head>
	<body>
		<table class="memo">
	    		<tr>
		    		<td colspan="2">
					<table class="toolbar">
						<tr>
							<td>
								<A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
								&nbsp;
								<logic:TagIfDefine name="pathToExpand" scope="request">
		                		                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=#R$pathBuildJar#&path=', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Jar class"/></html:TagA>
		                		                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=&path=', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=#R$pathToExpand#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=#R$pathToExpand#&path=&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageRename&application=#R$application#&oldName=#R$pathToExpand#&newName=#R$pathToExpand#', 'EditorJavaPageRename', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/rename_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Rename File"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=Dir&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=File&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&application=#R$application#&fileName=#R$pathToExpand#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/del_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete Directory"/></html:TagA>
								</logic:TagIfDefine>
								<logic:TagIfNotDefine name="pathToExpand" scope="request">
									<logic:TagIfDefine name="path" scope="request">
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&application=#R$application#&pathSrc=&pathDst=#R$pathBuildJar#&path=', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Java class"/></html:TagA>
			                		                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&application=#R$application#&pathSrc=&pathDst=&path=', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=#R$Path#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=&pathDst=&path=&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=Dir&path=#R$Path#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=File&Path=#R$Path#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/FileBrowser/new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
									</logic:TagIfDefine>
								</logic:TagIfNotDefine>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<form name="GoFileBrowser" action="action.servlet" method="post">
			<input type="hidden" name="event" value="FileBrowserPage"/>
			<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
<%--
			<html:TagInput attrType="hidden" attrName="path" attrValue="#R$path#"/>
			<html:TagInput attrType="hidden" attrName="pathBuildJava" attrValue="#R$pathBuildJava#"/>
			<html:TagInput attrType="hidden" attrName="pathBuildJar" attrValue="#R$pathBuildJar#"/>
--%>
	    		<tr valign="top">
		    		<td>
					<jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
						<jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
						<jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
						<jsp:param name="eventDst" value="FileBrowserPage"/>
					</jsp:include>
					<logic:TagIfDefine name="pathToExpand" scope="request">
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDir&formNameToSubmit=GoFileBrowser&formName=GoFileBrowser&fieldNameDir=pathToExpand&fieldNamePrj=path&fieldNameJava=pathBuildJava&fieldNameJar=pathBuildJar&path=&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectProjetDir', 300, 370)">...</html:TagA>
					</logic:TagIfDefine>
					<logic:TagIfNotDefine name="pathToExpand" scope="request">
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDir&formNameToSubmit=GoFileBrowser&formName=GoFileBrowser&fieldNameDir=pathToExpand&fieldNamePrj=path&path=&pathToExpand=', 'EditorJavaPageSelectProjetDir', 300, 370)">...</html:TagA>
					</logic:TagIfNotDefine>
			    	</td>
				<td>
<%--
					<logic:TagIfDefine name="path" scope="request">
						<logic:TagIfDefine name="pathToExpand" scope="request">
							<html:TagInput attrType="text" attrName="pathToExpand" attrValue="#R$pathToExpand#" attrSize="100"/>
						</logic:TagIfDefine>
						<logic:TagIfNotDefine name="pathToExpand" scope="request">
							<logic:TagIfDefine name="path" scope="request">
								<html:TagInput attrType="text" attrName="pathToExpand" attrValue="#R$path#" attrSize="100"/>
							</logic:TagIfDefine>
							<logic:TagIfNotDefine name="path" scope="request">
								<input type="text" name="pathToExpand" size="100"/>
							</logic:TagIfNotDefine>
						</logic:TagIfNotDefine>
						<input type="submit" value="Go"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=GoFileBrowser&formName=GoFileBrowser&fieldName=pathToExpand&path=&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
       					</logic:TagIfDefine>
					<logic:TagIfNotDefine name="path" scope="request">
						<input type="hidden" name="pathToExpand"/>
       					</logic:TagIfNotDefine>
--%>
					<logic:TagIfDefine name="path" scope="request">
						<html:TagInput attrType="text" attrName="pathToExpand" attrValue="#R$pathToExpand#" attrSize="100"/>
						<input type="submit" value="Go"/>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=GoFileBrowser&formName=GoFileBrowser&fieldName=pathToExpand&application=#R$application#&pathToExpand=#R$pathToExpand#', 'FileBrowserPageSelectDir', 340, 350)">...</html:TagA>
       					</logic:TagIfDefine>
				</td>
			</tr>
			</form>
	    		<tr valign="top">
			    	<td>
<%--
				        <div class="FileBrowser_Dir_ScrollBar">
			        	    <table width="400px">
		        	        	<tr>
			                	    <td>
            	        				<jsp:include page="/Web/Component/TreeView/TreeViewDir.jsp" flush="true">
								<jsp:param name="eventDst" value="FileBrowserPage"/>
								<jsp:param name="fileListScope" value="request"/>
							</jsp:include>
               					    </td>
			        	        </tr>
				            </table>
				        </div>
--%>
          	        		<jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
						<jsp:param name="eventDst" value="FileBrowserPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
    				</td>
			    	<td>
<%--
					<div class="FileBrowser_File_ScrollBar">
						<table width="100%" cellspacing="0" cellpadding="0">
							<jsp:include page="/Web/Component/TreeView/TreeViewFileExt.jsp" flush="true">
								<jsp:param name="eventDst" value="FileBrowserPage"/>
								<jsp:param name="fileListScope" value="request"/>
							</jsp:include>
						</table>
					</div>
--%>
					<jsp:include page="/Web/Component/TreeView/TreeViewFileExt_Border01.jsp" flush="true">
						<jsp:param name="eventDst" value="FileBrowserPage"/>
						<jsp:param name="fileListScope" value="request"/>
					</jsp:include>
	    			</td>
		    	</tr>
        	</table>
	</body>
</html>

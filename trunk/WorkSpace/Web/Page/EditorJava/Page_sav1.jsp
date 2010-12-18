<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval" %>
<html>
	<head>
		<title>
			FileEditor - <eval:TagEval expression='new java.io.File("#R$FileName#").getName()'/>
		</title>
	        <link href="/WorkSpace/css/page/editorjava/page.css" rel="stylesheet" type="text/css">
		<script language="javascript" src="/WorkSpace/js/page/editorjava/page.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/Popup.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/EncodingUTF8.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/EncodingHTML.js" type="text/javascript"></script>
		<script language="javascript" src="/WorkSpace/js/FunctionText.js" type="text/javascript"></script>
	</head>
	<body>
		<table>
	    		<tr>
		    		<td colspan="2">
					<table class="toolBar">
						<tr>
							<td>
								<A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
								&nbsp;
								<logic:TagIfDefine name="FileName" scope="request">
                               				        	<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCompile&pathSrc=#R$FileName#&pathDst=#R$path##R$pathBuildJava#&path=#R$path#', 'EditorJavaPageCompile', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Java class"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&path=#R$pathToExpand#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&pathSrc=#R$FileName#&pathDst=#R$pathToExpand#&path=#R$path#&type=file', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move File"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageRename&oldName=#R$FileName#&newName=#R$FileName#', 'EditorJavaPageRename', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_rename_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Rename File"/></html:TagA>
								</logic:TagIfDefine>
								<logic:TagIfNotDefine name="FileName" scope="request">
									<logic:TagIfDefine name="pathToExpand" scope="request">
			                		                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&pathSrc=#R$pathToExpand#&pathDst=#R$path##R$pathBuildJar#&path=#R$path#', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Jar class"/></html:TagA>
			                		                        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&pathSrc=#R$pathToExpand#&pathDst=#R$path#&path=#R$path#', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&path=#R$pathToExpand#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&pathSrc=#R$pathToExpand#&pathDst=#R$pathToExpand#&path=#R$path#&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
									</logic:TagIfDefine>
									<logic:TagIfNotDefine name="pathToExpand" scope="request">
										<logic:TagIfDefine name="path" scope="request">
               		        				        	        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&pathSrc=#R$path#&pathDst=#R$path##R$pathBuildJar#&path=#R$path#', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Jar class"/></html:TagA>
               		        				        	        <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&pathSrc=#R$path#&pathDst=#R$path#&path=#R$path#', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
											<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&path=#R$Path#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
											<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&pathSrc=#R$path#&pathDst=#R$path#&path=#R$path#&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
										</logic:TagIfDefine>
									</logic:TagIfNotDefine>
					        		</logic:TagIfNotDefine>
								<logic:TagIfDefine name="pathToExpand" scope="request">
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&Type=Dir&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&Type=File&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&fileName=#R$pathToExpand#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_del_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete Directory"/></html:TagA>
								</logic:TagIfDefine>
								<logic:TagIfNotDefine name="pathToExpand" scope="request">
									<logic:TagIfDefine name="path" scope="request">
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&Type=Dir&path=#R$Path#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
										<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&Type=File&Path=#R$Path#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
									</logic:TagIfDefine>
								</logic:TagIfNotDefine>
								<logic:TagIfDefine name="FileName" scope="request">
									<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&fileName=#R$FileName#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_del_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete File"/></html:TagA>
									</td><td width="30%" align="center">
									<eval:TagEval expression='new java.io.File("#R$FileName#").getName()'/>
								</logic:TagIfDefine>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<form name="GoEditorJava" action="action.servlet" method="post">
			<input type="hidden" name="event" value="EditorJavaPage"/>
			<html:TagInput attrType="hidden" attrName="path" attrValue="#R$path#"/>
			<html:TagInput attrType="hidden" attrName="pathBuildJava" attrValue="#R$pathBuildJava#"/>
			<html:TagInput attrType="hidden" attrName="pathBuildJar" attrValue="#R$pathBuildJar#"/>
	    		<tr valign="top">
		    		<td>
					<jsp:include page="/Web/Component/ComboBox/ComboBoxProjetXml.jsp" flush="true">
						<jsp:param name="myID" value="#S$BeanAuthentification:login#"/>
						<jsp:param name="myPWD" value="#S$BeanAuthentification:password#"/>
						<jsp:param name="eventDst" value="EditorJavaPage"/>
					</jsp:include>
					<logic:TagIfDefine name="pathToExpand" scope="request">
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDir&formNameToSubmit=GoEditorJava&formName=GoEditorJava&fieldNameDir=pathToExpand&fieldNamePrj=path&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectProjetDir', 300, 370)">...</html:TagA>
					</logic:TagIfDefine>
					<logic:TagIfNotDefine name="pathToExpand" scope="request">
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectProjetDir&formNameToSubmit=GoEditorJava&formName=GoEditorJava&fieldNameDir=pathToExpand&fieldNamePrj=path&path=#R$path#&pathToExpand=#R$path#', 'EditorJavaPageSelectProjetDir', 300, 370)">...</html:TagA>
					</logic:TagIfNotDefine>
			    	</td>
				<td>
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
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageSelectDir&formNameToSubmit=GoEditorJava&formName=GoEditorJava&fieldName=pathToExpand&path=#R$path#&pathToExpand=#R$pathToExpand#', 'EditorJavaPageSelectDir', 340, 350)">...</html:TagA>
       					</logic:TagIfDefine>
				</td>
			</tr>
			</form>
	    		<tr valign="top">
			    	<td>
		    			<table>
						<tr>
							<td valign="top">
                	        				<jsp:include page="/Web/Component/TreeView/TreeViewDir_Border01.jsp" flush="true">
									<jsp:param name="eventDst" value="EditorJavaPage"/>
								</jsp:include>
					    		</td>
					    	</tr>
					    	<tr>
						    	<td valign="top">
					                        <jsp:include page="/Web/Component/TreeView/TreeViewFile_Border01.jsp" flush="true">
									<jsp:param name="eventDst" value="EditorJavaPage"/>
								</jsp:include>
						    	</td>
				    		</tr>
       					</table>
    				</td>
			    	<td>
    					<table>
						<form name="ValiderEditorJava" action="action.servlet" method="post">
							<input type="hidden" name="event" value="EditorJavaPageSave"/>
							<html:TagInput attrType="hidden" attrName="path" attrValue="#R$path#"/>
							<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
							<html:TagInput attrType="hidden" attrName="FileName" attrValue="#R$FileName#"/>
							<html:TagInput attrType="hidden" attrName="pathBuildJava" attrValue="#R$pathBuildJava#"/>
							<html:TagInput attrType="hidden" attrName="pathBuildJar" attrValue="#R$pathBuildJar#"/>
							<tr>
							    	<td>
								        <textarea name="FileEditor" cols="85" rows="32" class="TextEditor" wrap="off"><file:TagFileReader path="#R$FileName#" encoding="HTMLENTITIES"/></textarea>
				    				</td>
    							</tr>
							<tr>
							    	<td align="center">
		    							<input type="submit" value="Save"/>
								</td>
							</tr>
						</form>
					</table>
	    			</td>
		    	</tr>
        	</table>
	</body>
</html>

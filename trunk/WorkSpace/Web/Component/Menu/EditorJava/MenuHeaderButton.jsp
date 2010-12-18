<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<table class="toolBar">
	<tr>
		<td>
			<A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
			&nbsp;
			<logic:TagIfDefine name="FileName" scope="request">
             <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCompile&application=#R$application#&pathSrc=#R$pathToExpand##R$FileName#&pathDst=#R$pathBuildJava#&path=', 'EditorJavaPageCompile', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Java class"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=#R$pathToExpand#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=#R$pathToExpand##R$FileName#&pathDst=#R$pathToExpand##R$FileName#&path=&type=file', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageRename&application=#R$application#&oldName=#R$pathToExpand##R$FileName#&newName=#R$pathToExpand##R$FileName#', 'EditorJavaPageRename', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_rename_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Rename File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_del_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete File"/></html:TagA>
			  &nbsp;<eval:TagEval expression='"#R$pathToExpand#".replaceAll(java.io.File.separator, ".")+".#R$FileName#"'/>
			</logic:TagIfDefine>
			<logic:TagIfNotDefine name="FileName" scope="request">
				<logic:TagIfDefine name="pathToExpand" scope="request">
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=#R$pathBuildJar#&path=', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Jar class"/></html:TagA>
            <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=&path=', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=#R$pathToExpand#', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=#R$pathToExpand#&pathDst=#R$pathToExpand#&path=&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="pathToExpand" scope="request">
					<logic:TagIfDefine name="path" scope="request">
          		    <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageJar&application=#R$application#&pathSrc=&pathDst=#R$pathBuildJar#&path=', 'EditorJavaPageJar', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_jar.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Jar class"/></html:TagA>
          		    <html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageZip&application=#R$application#&pathSrc=&pathDst=&path=', 'EditorJavaPageZip', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_compile_zip.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Compile Zip class"/></html:TagA>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageUpload&application=#R$application#&path=', 'EditorJavaPageUpload', 500, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_upload.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Upload"/></html:TagA>
						<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageCopyMove&application=#R$application#&pathSrc=&pathDst=&path=&type=dir', 'EditorJavaPageCopyMove', 390, 150)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_copy_move_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Copy/Move Directory"/></html:TagA>
					</logic:TagIfDefine>
				</logic:TagIfNotDefine>
      </logic:TagIfNotDefine>
			<logic:TagIfDefine name="pathToExpand" scope="request">
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=Dir&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=File&Path=#R$pathToExpand#', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
				<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageDelete&application=#R$application#&fileName=#R$pathToExpand#', 'EditorJavaPageDelete', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_del_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Delete Directory"/></html:TagA>
			</logic:TagIfDefine>
			<logic:TagIfNotDefine name="pathToExpand" scope="request">
				<logic:TagIfDefine name="path" scope="request">
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=Dir&path=', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_dir.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New Directory"/></html:TagA>
					<html:TagA attrHref="javascript:openPopup('action.servlet?event=EditorJavaPageNew&application=#R$application#&Type=File&Path=', 'EditorJavaPageNew', 320, 120)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Editor/ed_new_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="New File"/></html:TagA>
				</logic:TagIfDefine>
			</logic:TagIfNotDefine>
		</td>
		<td align="right">
			<logic:TagIfDefine name="FileName" scope="request">
				<logic:TagIfNotDefine name="cvsModuleName" scope="request" checkNotEmpty="true">
					<table>
					  <tr>
					    <td>
							  <img class="buttonOut" src="/WorkSpace/img/Versionning/cvs_logo.gif" alt="CVS"/>
					    </td>
					    <td>
						    <table cellspacing="0" cellpadding="1">
						      <tr>
						        <td>
                      <versionning:TagStatus application="#R$application#" path="#R$path#/#R$pathToExpand#/#R$FileName#" name="status" scope="request"/>
       	              <versionning:TagStatusSwitch name="status" scope="request">
                      	<versionning:TagStatusSwitchCase value="Locally Added;Unknown">
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddFileValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionAddFileValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_add_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Add File Valider"/></html:TagA><br/>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddFile&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionAddFile', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver02';" onmouseout="this.className='buttonOptionOut';" title="Add File"/></html:TagA>
						  			</td>
						  			<td>
   	              					</versionning:TagStatusSwitchCase>
           	      					<versionning:TagStatusSwitchElse>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdFileValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionUpdateFileValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_upd_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Update File Valider"/></html:TagA><br/>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdFile&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionUpdateFile', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver04';" onmouseout="this.className='buttonOptionOut';" title="Update File"/></html:TagA>
						      	</td>
						      	<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitFileValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionCommitFileValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_commit_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit File Valider"/></html:TagA><br/>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitFile&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionCommitFile', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver05';" onmouseout="this.className='buttonOptionOut';" title="Commit File"/></html:TagA>
						      	</td>
						      	<td>
                           		<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreAddValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionIgnoreAddValider', 390, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_ignore_file_add.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Ignore Add Valider"/></html:TagA><br/>
                           		<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreAdd&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionIgnoreAdd', 390, 200)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver06';" onmouseout="this.className='buttonOptionOut';" title="Ignore Add"/></html:TagA>
                         </td>
                         <td>
                           		<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreDelValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionIgnoreDelValider', 390, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_ignore_file_del.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Ignore Del Valider"/></html:TagA><br/>
                           		<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreDel&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionIgnoreDel', 390, 200)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver07';" onmouseout="this.className='buttonOptionOut';" title="Ignore Del"/></html:TagA>
                         </td>
                         <td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionRemoveFileValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionRemoveFileValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_remove_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Remove File Valider"/></html:TagA><br/>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionRemoveFile&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionRemoveFile', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver03';" onmouseout="this.className='buttonOptionOut';" title="Remove File"/></html:TagA>
						      	</td>
						      	<td>
                         			<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionStatusFileValider&application=#R$application#&fileName=#R$pathToExpand##R$FileName#', 'VersionStatusFileValider', 390, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_status_file.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Status File Valider"/></html:TagA>
                   	    		</versionning:TagStatusSwitchElse>
                         	</versionning:TagStatusSwitch>
                         </td>
                       </tr>
                     </table>
							</td>
						</tr>
					</table>
				</logic:TagIfNotDefine>
			</logic:TagIfDefine>
			<logic:TagIfNotDefine name="FileName" scope="request">
				<logic:TagIfDefine name="pathToExpand" scope="request">
					<logic:TagIfNotDefine name="cvsModuleName" scope="request" checkNotEmpty="true">
						<table>
							<tr>
								<td>
									<img class="buttonOut" src="/WorkSpace/img/Versionning/cvs_logo.gif" height="40px"  width="40px" alt="CVS"/>
								</td>
								<td>
									<table cellspacing="0" cellpadding="1">
										<tr>
											<td>
												<versionning:TagStatus application="#R$application#" path="#R$path#/#R$pathToExpand#" name="status" scope="request"/>
												<versionning:TagStatusSwitch name="status" scope="request">
													<versionning:TagStatusSwitchCase value="Locally Added;Unknown">
								    				<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectoryValider&application=#R$application#&fileName=#R$pathToExpand#', 'VersionAddDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_add_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Add Directory Valider"/></html:TagA><br/>
                                 <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectory&application=#R$application#&fileName=#R$pathToExpand#', 'VersionAddDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver02';" onmouseout="this.className='buttonOptionOut';" title="Add Directory"/></html:TagA>
							         </td>
							         <td>
                               </versionning:TagStatusSwitchCase>
                               <versionning:TagStatusSwitchElse>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectoryValider&application=#R$application#&fileName=#R$pathToExpand#', 'VersionUpdateDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_upd_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Update Directory Valider"/></html:TagA><br/>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectory&application=#R$application#&fileName=#R$pathToExpand#', 'VersionUpdateDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver04';" onmouseout="this.className='buttonOptionOut';" title="Update Directory"/></html:TagA>
											 </td>
											 <td>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectoryValider&application=#R$application#&fileName=#R$pathToExpand#', 'VersionCommitDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_commit_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit Directory Valider"/></html:TagA><br/>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectory&application=#R$application#&fileName=#R$pathToExpand#', 'VersionCommitDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver05';" onmouseout="this.className='buttonOptionOut';" title="Commit Directory"/></html:TagA>
											 </td>
											 <td>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreAddValider&application=#R$application#&fileName=#R$pathToExpand#', 'VersionIgnoreAddValider', 390, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_ignore_directory_add.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Ignore Add Valider"/></html:TagA><br/>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreAdd&application=#R$application#&fileName=#R$pathToExpand#', 'VersionIgnoreAdd', 390, 200)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver06';" onmouseout="this.className='buttonOptionOut';" title="Ignore Add"/></html:TagA>
											 </td>
											 <td>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreDelValider&application=#R$application#&fileName=#R$pathToExpand#', 'VersionIgnoreDelValider', 390, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_ignore_directory_del.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Ignore Del Valider"/></html:TagA><br/>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionIgnoreDel&application=#R$application#&fileName=#R$pathToExpand#', 'VersionIgnoreDel', 390, 200)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver07';" onmouseout="this.className='buttonOptionOut';" title="Ignore Del"/></html:TagA>
											 </td>
											 <td>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionRemoveDirectoryValider&application=#R$application#&fileName=#R$pathToExpand#', 'VersionRemoveDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_remove_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Remove Directory Valider"/></html:TagA><br/>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionRemoveFile&application=#R$application#&fileName=#R$pathToExpand#', 'VersionRemoveDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver03';" onmouseout="this.className='buttonOptionOut';" title="Remove Directory"/></html:TagA>
											 </td>
											 <td>
												    <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionStatusDirectory&application=#R$application#&fileName=#R$pathToExpand#', 'VersionStatusDirectory', 390, 200)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_status_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Status Directory Valider"/></html:TagA>
                   	          </versionning:TagStatusSwitchElse>
                           	</versionning:TagStatusSwitch>
											</td>
										</tr>
									</table>
								</td>
							</tr>
						</table>
					</logic:TagIfNotDefine>
				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="pathToExpand" scope="request">
					<logic:TagIfDefine name="path" scope="request">
						<logic:TagIfNotDefine name="cvsModuleName" scope="request" checkNotEmpty="true">
							<table>
								<tr>
									<td>
										<img class="buttonOut" src="/WorkSpace/img/Versionning/cvs_logo.gif" height="40px"  width="40px" alt="CVS"/>
									</td>
									<td>
										<table cellspacing="0" cellpadding="1">
											<tr>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCheckOutValider&application=#R$application#&fileName=', 'VersionCheckOutValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_checkout.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="CheckOut Valider"/></html:TagA>
												</td>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectoryValider&application=#R$application#&fileName=', 'VersionAddDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_add_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Add Directory Valider"/></html:TagA>
												</td>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectoryValider&application=#R$application#&fileName=', 'VersionUpdateDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_upd_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Update Directory Valider"/></html:TagA>
												</td>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectoryValider&application=#R$application#&fileName=', 'VersionCommitDirectoryValider', 390, 400)"><img unselectable="on" class="buttonOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_commit_directory.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Commit Directory Valider"/></html:TagA>
												</td>
											</tr>
											<tr>
												<td>
               		        <html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCheckOut&application=#R$application#&fileName=', 'VersionCheckOut', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver01';" onmouseout="this.className='buttonOptionOut';" title="CheckOut"/></html:TagA>
												</td>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionAddDirectory&application=#R$application#&fileName=', 'VersionAddDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver04';" onmouseout="this.className='buttonOptionOut';" title="Add Directory"/></html:TagA>
												</td>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionUpdDirectory&application=#R$application#&fileName=', 'VersionUpdateDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver04';" onmouseout="this.className='buttonOptionOut';" title="Update Directory"/></html:TagA>
												</td>
												<td>
													<html:TagA attrHref="javascript:openPopup('action.servlet?event=VersionCommitDirectory&application=#R$application#&fileName=', 'VersionCommitDirectory', 390, 400)"><img unselectable="on" class="buttonOptionOut" align="absmiddle" src="/WorkSpace/img/Versionning/ver_option.gif" onmouseover="this.className='buttonOptionOver05';" onmouseout="this.className='buttonOptionOut';" title="Commit Directory"/></html:TagA>
												</td>
											</tr>
										</table>
									</td>
								</tr>
							</table>
						</logic:TagIfNotDefine>
					</logic:TagIfDefine>
				</logic:TagIfNotDefine>
		  </logic:TagIfNotDefine>
		</td>
	</tr>
</table>

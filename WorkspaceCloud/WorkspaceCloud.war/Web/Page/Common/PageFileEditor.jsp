<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html"%>
<%@ taglib uri="Framework_Taglib_File.tld" prefix="file"%>
<%@ taglib uri="Framework_Taglib_Eval.tld" prefix="eval"%>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>

<logic:TagIfNotDefine name="path" scope="request" checkNotEmpty="true">
    <request:TagDefineAttribute expression="[#R$application#]" name="path" scope="request"/>
    <path:TagPathFormat name="path" scope="request" application="#R$application#" toURI="true"/>
</logic:TagIfNotDefine>

<logic:TagIfNotDefine name="navIndex" scope="request" checkNotEmpty="true">
    <request:TagDefineAttribute name="navIndex" scope="request" expression="1"/>
</logic:TagIfNotDefine>
<logic:TagIfNotDefine name="navNbRow" scope="request" checkNotEmpty="true">
	<request:TagDefineAttribute name="navNbRow" scope="request" expression="50"/>
</logic:TagIfNotDefine>

<html>
	<head>
		<title>
			<%--File Editor - <eval:TagEval expression='new java.io.File("#R$FileName#").getName()'/--%>
			File Editor - <file:TagFileName path="#R$FileName#"/>
		</title>
	        <link href="/css/page/common/pagefileeditor.css" rel="stylesheet" type="text/css">
<%--
		<script language="javascript" src="/js/page/common/iframe_completion02.js" type="text/javascript"></script>
--%>
        <script language="javascript" src="/js/page/common/iframe_completion03.js" type="text/javascript"></script>
		<script language="javascript" src="/js/page/common/pagefileeditor.js" type="text/javascript"></script>
		<script language="javascript" src="/js/Popup.js" type="text/javascript"></script>
		<script language="javascript" src="/js/EncodingUTF8.js" type="text/javascript"></script>
		<script language="javascript" src="/js/EncodingHTML.js" type="text/javascript"></script>
		<script language="javascript" src="/js/FunctionText.js" type="text/javascript"></script>
	</head>
	<body bgcolor="buttonface" onload="javascript:init()">
		<table class="memo" align="center">
	    		<tr>
			    	<td align="center">
					    <%--font class="input_title_inverse"><eval:TagEval expression='new java.io.File("#R$path##R$FileName#").getName()'/></font--%>
					    <font class="input_title_inverse"><file:TagFileName path="#R$FileName#"/></font>
	    			</td>
		    	</tr>
	    		<tr valign="top">
			    	<td>
						<form name="ValiderFileEditor" action="action.servlet" method="post" onsubmit="javascript:onsumbitform()">
    					<table>
							<input type="hidden" name="event" value="PageFileEditorValider"/>
							<html:TagInput attrType="hidden" attrName="application" attrValue="#R$application#"/>
							<html:TagInput attrType="hidden" attrName="FileName" attrValue="#R$FileName#"/>
							<html:TagInput attrType="hidden" attrName="pathToExpand" attrValue="#R$pathToExpand#"/>
							<html:TagInput attrType="hidden" attrName="navIndex" attrValue="#R$navIndex#"/>
							<html:TagInput attrType="hidden" attrName="navNbRow" attrValue="#R$navNbRow#"/>
							<tr>
						    	<td>
									<div id="classNameDiv" style="position:absolute;left:0px;top:21px;visibility:hidden;border:solid green 2px;background-color:white;z-index:1"></div>
									<A id="classIdAncre" name="classNameAncre"></A>
									<textarea style="position:absolute;visibility:hidden;" name="FileEditor" wrap="off"></textarea>
									<iframe id="htmle" name="htmle" height="510" width="650"></iframe>
									<br/>
									<script language="javascript">
<%--
										initIframe('<file:TagFileReader path="#R$path##R$FileName#" encoding="HTML" startLine="#R$navIndex#" nbLine="50"/>');
--%>
										<%--logic:TagIf expression='"#R$FileName#".toLowerCase().endsWith(".java")'--%>
										<%if ((request.getAttribute("FileName")!=null)&&((String)request.getAttribute("FileName")).toLowerCase().endsWith(".java")) { %>
									        initIframe('<file:TagFileReader path="#R$path##R$pathToExpand##R$FileName#" encoding="HTML" nameFileOut="fileReaded" scopeFileOut="request" startLine="#R$navIndex#" nbLine="#R$navNbRow#"/>', true);
								        <%--/logic:TagIf--%>
								        <%--logic:TagIf expression='!"#R$FileName#".toLowerCase().endsWith(".java")'--%>
								        <%} else { %>
									        initIframe('<file:TagFileReader path="#R$path##R$pathToExpand##R$FileName#" encoding="HTML" nameFileOut="fileReaded" scopeFileOut="request" startLine="#R$navIndex#" nbLine="#R$navNbRow#"/>', false);
								        <%}%>
									        <%--/logic:TagIf--%>
									</script>
			    				</td>
   							</tr>
							<tr>
						    	<td align="center">
	                                <file:TagFileNavigator
                                          name="fileReaded"
                                          scope="request"
                                          attrHref="action.servlet?event=PageFileEditor&application=#R$application#&pathToExpand=#R$pathToExpand#&FileName=#R$FileName<encoding=UTF-8>#&navNbRow=#R$navNbRow#&[index]"
                                          indexName="navIndex"
                                          separator=" - "
                                          indexStart="0"
                                          indexStep="#R$navNbRow#"
                                          indexQuantity="5"
                                          isShowPrevious="true"
                                          isShowNext="true"
                                          libellePrevious="<- Previous "
                                          libelleNext=" Next ->"
	                                >
	                                </file:TagFileNavigator>
			    				</td>
   							</tr>
							<tr>
								<td align="center">
		    						<input type="submit" value="Save"/>
								</td>
							</tr>
						</table>
						</form>
	    			</td>
		    	</tr>
        	</table>
	</body>
</html>

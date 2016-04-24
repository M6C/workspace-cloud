<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Xml.tld" prefix="Xml" %>

<logic:TagIfDefine name="eventOrigine" scope="request">
        <html:TagInput attrType="hidden" attrName="eventOrigine" attrValue="#R$eventOrigine#"/>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="eventOrigine" scope="request">
        <html:TagInput attrType="hidden" attrName="eventOrigine" attrValue="#R$event#"/>
</logic:TagIfNotDefine>

<Xml:TagXml name="resultDom" scope="session" path="/ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name='#R$application#']/VERSIONNING">
	<logic:TagIfNotDefine name="extand" scope="request">
		<tr>
			<td colspan="2">
				<logic:TagIfDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$eventOrigine#&application=#R$application#&extand=1&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#" content="<+> Extand Advanced Options"/>
				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$event#&application=#R$application#&extand=1&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#" content="<+> Extand Advanced Options"/>
				</logic:TagIfNotDefine>
			</td>
		</tr>
	</logic:TagIfNotDefine>
	<logic:TagIfDefine name="extand" scope="request">
		<html:TagInput attrType="hidden" attrName="extand" attrValue="#R$extand#"/>
		<tr>
			<td colspan="2">
				<logic:TagIfDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$eventOrigine#&application=#R$application#&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#" content="<-> Collapse Advanced Options"/>
				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$event#&application=#R$application#&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#" content="<-> Collapse Advanced Options"/>
				</logic:TagIfNotDefine>
			</td>
		</tr>
		<tr valign="top">
                        <td>
                                <font class="input_title_inverse">Local Directory</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="localDirectory" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrName="localDirectory" attrValue="#R$localDirectory#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="localDirectory" scope="request" checkNotEmpty="true">
                                        <input name="localDirectory" value='<Xml:TagXmlValue path="LOCAL_DIRECTORY"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
		<tr valign="top">
                        <td>
                                <font class="input_title_inverse">Repository</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="repository" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrName="repository" attrValue="#R$repository#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="repository" scope="request" checkNotEmpty="true">
                                        <input name="repository" value='<Xml:TagXmlValue path="MODULE_NAME"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
                <tr valign="top">
                        <td>
                                <font class="input_title_inverse">Root Directory</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="rootDirectory" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrName="rootDirectory" attrValue="#R$rootDirectory#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="rootDirectory" scope="request" checkNotEmpty="true">
                                        <input name="rootDirectory" value='<Xml:TagXmlValue path="SERVER_REPOSITORY"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
                <tr valign="top">
                        <td>
                                <font class="input_title_inverse">Hostname</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="hostname" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrName="hostname" attrValue="#R$hostname#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="hostname" scope="request" checkNotEmpty="true">
                                        <input name="hostname" value='<Xml:TagXmlValue path="SERVER_HOSTNAME"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
                <tr valign="top">
                        <td>
                                <font class="input_title_inverse">Port</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="port" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrName="port" attrValue="#R$port#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="port" scope="request" checkNotEmpty="true">
                                        <input name="port" value='<Xml:TagXmlValue path="SERVER_PORT"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
                <tr valign="top">
                        <td>
                                <font class="input_title_inverse">User Name</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="userName" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrName="userName" attrValue="#R$userName#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="userName" scope="request" checkNotEmpty="true">
                                        <input name="userName" value='<Xml:TagXmlValue path="USER"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
                <tr valign="top">
                        <td>
                                <font class="input_title_inverse">Password</font>
                        </td>
                        <td>
                                <logic:TagIfDefine name="passWord" scope="request" checkNotEmpty="true">
                                        <html:TagInput attrType="password" attrName="passWord" attrValue="#R$passWord#"/>
                                </logic:TagIfDefine>
                                <logic:TagIfNotDefine name="passWord" scope="request" checkNotEmpty="true">
                                        <input type="password" name="passWord" value='<Xml:TagXmlValue path="PASSWORD"/>'/>
                                </logic:TagIfNotDefine>
                        </td>
                </tr>
	</logic:TagIfDefine>
</Xml:TagXml>

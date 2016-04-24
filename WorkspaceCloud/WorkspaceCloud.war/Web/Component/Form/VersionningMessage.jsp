<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Framework_Taglib_Request.tld" prefix="request" %>

<logic:TagIfDefine name="eventOrigine" scope="request">
        <html:TagInput attrType="hidden" attrName="eventOrigine" attrValue="#R$eventOrigine#"/>
</logic:TagIfDefine>
<logic:TagIfNotDefine name="eventOrigine" scope="request">
        <html:TagInput attrType="hidden" attrName="eventOrigine" attrValue="#R$event#"/>
</logic:TagIfNotDefine>

<logic:TagIfDefine name="jcvsErrorMessage" scope="request">
	<table>
	<logic:TagIfNotDefine name="extandMsg" scope="request" checkNotEmpty="true">
		<tr>
			<td colspan="2">
				<logic:TagIfDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$eventOrigine#&application=#R$application#&extandMsg=1&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#&jcvsErrorMessage=#R$jcvsErrorMessage#" content="<+> Show Message"/>
				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$event#&application=#R$application#&extandMsg=1&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#&jcvsErrorMessage=#R$jcvsErrorMessage#" content="<+> Show Message"/>
				</logic:TagIfNotDefine>
			</td>
		</tr>
	</logic:TagIfNotDefine>
	<logic:TagIfDefine name="extandMsg" scope="request" checkNotEmpty="true">
		<html:TagInput attrType="hidden" attrName="extandMsg" attrValue="#R$extandMsg#"/>
		<tr>
			<td>
				<logic:TagIfDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$eventOrigine#&application=#R$application#&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#" content="<-> Hide Message"/>
				</logic:TagIfDefine>
				<logic:TagIfNotDefine name="eventOrigine" scope="request">
					<html:TagA attrHref="action.servlet?event=#R$event#&application=#R$application#&vendorTag=#R$vendorTag#&releaseTag=#R$releaseTag#&messageStr=#R$messageStr#" content="<-> Hide Message"/>
				</logic:TagIfNotDefine>
			</td>
		</tr>
                <tr valign="top">
                        <td>
                                <request:TagPrintAttribut name="jcvsErrorMessage" scope="request"/>
                        </td>
                </tr>
	</logic:TagIfDefine>
        </table>
</logic:TagIfDefine>

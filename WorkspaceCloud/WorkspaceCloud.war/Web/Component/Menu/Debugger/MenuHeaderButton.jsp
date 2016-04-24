<%@ taglib uri="Framework_Taglib_Html.tld" prefix="html" %>
<%@ taglib uri="Framework_Taglib_Logic.tld" prefix="logic" %>
<%@ taglib uri="Workspace_Taglib_Versionning.tld" prefix="versionning" %>

<table class="toolBar">
	<tr>
		<td>
	    <A href="action.servlet?event=Home"><img unselectable="on" class="buttonOut" align="absmiddle" src="/img/Editor/ed_home.gif" onmouseover="this.className='buttonOver';" onmouseout="this.className='buttonOut';" title="Home"/></A>
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

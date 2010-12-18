package workspace.service.debug;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.bean.debug.BeanDebug;

import com.sun.jdi.LocalVariable;
import com.sun.jdi.StackFrame;
import com.sun.jdi.ThreadReference;
import com.sun.jdi.Value;
import com.sun.jdi.event.Event;
import com.sun.jdi.event.LocatableEvent;

import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugBreakpointVariable extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    	  HttpSession session = request.getSession();
    	  StringBuffer sb = new StringBuffer("<table border=1 cellspacing=0 cellpadding=0><tr><td>");
    	  try {
	    	  BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
	    	  if (beanDebug!=null) {
	    		  Event currentEvent = beanDebug.getCurrentEvent();
	    		  if ((currentEvent!=null)&&(currentEvent instanceof LocatableEvent)) {
	    			  LocatableEvent event = (LocatableEvent)currentEvent;
		    		  ThreadReference thread = event.thread();
		    		  List frames = thread.frames();
		    		  if ((frames!=null)&&(!frames.isEmpty())) {
		    			  StackFrame frame = null;
		    			  Iterator it = frames.iterator();
		    			  while(it.hasNext()) {
		    				  frame = (StackFrame)it.next();
		    				  try {
			    				  sb.append("&nbsp;</td><td><table><tr><td colspan='3' nowrap><b>");
			    				  sb.append(frame.location().sourcePath());
			    				  sb.append("\\");
			    				  sb.append(frame.location().sourceName());
			    				  sb.append("</b><br><u>");
			    				  sb.append(frame.location().method().name());
			    				  sb.append("</u>&nbsp;");
			    				  sb.append(frame.location().method().signature());
			    				  sb.append("</td></tr><tr><td>");
		    				  }
		    				  catch(Exception ex) {}
		    				  try {
			    				  List visibleVariables = frame.visibleVariables();
					    		  if ((visibleVariables!=null)&&(!visibleVariables.isEmpty())) {
					    			  LocalVariable variable = null;
					    			  Value value = null;
					    			  Iterator itV = visibleVariables.iterator();
					    			  while(itV.hasNext()) {
					    				  variable = (LocalVariable)itV.next();
					    				  sb.append(variable.typeName());
					    				  sb.append("</td><td>");
					    				  sb.append(variable.name());
					    				  sb.append("</td><td>");
					    				  value = frame.getValue(variable);
					    				  sb.append((value!=null) ? value.toString() : null);
					    				  sb.append("</td></tr><tr><td>");
					    			  }
					    		  }
		    				  }
		    				  catch(Exception ex) {}
		    				  sb.append("</td></tr></table>");
		    				  sb.append("</td></tr><tr><td>");
		    			  }
		    		  }
	    		  }
	    	  }
			  sb.append("</td></tr></table>");
    		  PrintWriter out = response.getWriter();
              out.print(sb.toString());
    	  }
    	  catch(Exception ex) {
    		  StringWriter sw = new StringWriter();
    		  ex.printStackTrace(new PrintWriter(sw));
    		  request.setAttribute("msgText", sw.toString());
    		  throw ex;
    	  }
    }
}

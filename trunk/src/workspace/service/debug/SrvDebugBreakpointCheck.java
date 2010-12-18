package workspace.service.debug;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.bean.debug.BeanDebug;

import com.sun.jdi.event.BreakpointEvent;
import com.sun.jdi.event.Event;
import com.sun.jdi.request.BreakpointRequest;

import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugBreakpointCheck extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    	  HttpSession session = request.getSession();
    	  try {
	    	  BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
	    	  if (beanDebug!=null) {
	    		  Event currentEvent = beanDebug.getCurrentEvent();
	    		  if ((currentEvent!=null)&&(currentEvent instanceof BreakpointEvent)) {
	    			  BreakpointEvent brkE = (BreakpointEvent)currentEvent;
	    			  BreakpointRequest brkR = (BreakpointRequest)brkE.request();
					  // Recupere le nom de l'application du point d'arret
		    		  String application = URLEncoder.encode((String)brkR.getProperty("application"), "UTF-8");
					  // Recupere le chemin des sources de la class du point d'arret
		    		  String path = URLEncoder.encode((String)brkR.getProperty("path"), "UTF-8");
		    		  String sourceName = URLEncoder.encode(brkR.location().sourceName(), "UTF-8");
		    		  int lineNumber = brkE.location().lineNumber();
		    		  PrintWriter out = response.getWriter();
		              out.print(application+":"+path+":"+sourceName+":"+lineNumber);
	    		  }
	    	  }
    	  }
    	  catch(Exception ex) {
    		  StringWriter sw = new StringWriter();
    		  ex.printStackTrace(new PrintWriter(sw));
    		  request.setAttribute("msgText", sw.toString());
    		  throw ex;
    	  }
    }
}

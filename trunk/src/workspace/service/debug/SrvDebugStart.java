package workspace.service.debug;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.bean.debug.BeanDebug;
import workspace.thread.debug.ThrdDebugEventQueue;

import com.sun.jdi.VirtualMachine;

import framework.beandata.BeanGenerique;
import framework.ressource.util.jdi.UtilJDI;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugStart extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    	  HttpSession session = request.getSession();
          PrintWriter out = response.getWriter();
    	  VirtualMachine virtualMachine = null;
    	  try {
			  BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
			  if (beanDebug==null) {
				  String hostName = "localhost";
				  Integer port = new Integer(4082);
				  virtualMachine = UtilJDI.createVirtualMachine(hostName, port);
				  beanDebug = new BeanDebug(virtualMachine);

				  ThrdDebugEventQueue thread = new ThrdDebugEventQueue(beanDebug, virtualMachine.eventQueue());
				  thread.setOut(System.out);
				  thread.setErr(System.err);
				  thread.setErrTrace(System.err);
				  thread.start();
				  
				  beanDebug.setThrdDebugEventQueue(thread);

				  session.setAttribute("beanDebug", beanDebug);
			  }
			  else {
				  virtualMachine = beanDebug.getVirtualMachine();
			  }
			  out.print("Started");
    	  }
    	  catch(Exception ex) {
    		  StringWriter sw = new StringWriter();
    		  ex.printStackTrace(new PrintWriter(sw));
    		  request.setAttribute("msgText", sw.toString());
    		  throw ex;
    	  }
    	  finally {
    		  if (virtualMachine!=null)
    			  virtualMachine.resume();
    	  }
    }
}

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
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugStop extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    	  HttpSession session = request.getSession();
          PrintWriter out = response.getWriter();
    	  VirtualMachine virtualMachine = null;
    	  ThrdDebugEventQueue thrdDebugEventQueue = null;
    	  try {
			  BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
			  if (beanDebug!=null) {

				  virtualMachine = beanDebug.getVirtualMachine();

				  thrdDebugEventQueue = beanDebug.getThrdDebugEventQueue();

    			  beanDebug.setCurrentEvent(null);
    			  beanDebug.setCurrentStep(null);
    			  beanDebug.setThrdDebugEventQueue(null);

				  session.removeAttribute("beanDebug");
			  }
			  out.print("Stopped");
    	  }
    	  catch(Exception ex) {
    		  StringWriter sw = new StringWriter();
    		  ex.printStackTrace(new PrintWriter(sw));
    		  request.setAttribute("msgText", sw.toString());
    		  throw ex;
    	  }
    	  finally {
    		  if (virtualMachine!=null) {
    			  virtualMachine.dispose();
    		  }
			  if (thrdDebugEventQueue!=null) {
				  thrdDebugEventQueue.stopRunning();
			  }
    	  }
    }
}

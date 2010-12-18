package workspace.service.debug;

import java.io.PrintWriter;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.bean.debug.BeanDebug;

import com.sun.jdi.VirtualMachine;
import com.sun.jdi.event.Event;
import com.sun.jdi.event.LocatableEvent;
import com.sun.jdi.request.StepRequest;

import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugBreakpointResume extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
  	  HttpSession session = request.getSession();
	  try {
    	  BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
    	  if (beanDebug!=null) {
    		  Event currentEvent = beanDebug.getCurrentEvent();
    		  if ((currentEvent!=null)&&(currentEvent instanceof LocatableEvent)) {
    			  VirtualMachine virtualMachine = beanDebug.getVirtualMachine();
    			  LocatableEvent brkE = (LocatableEvent)currentEvent;
    			  StepRequest currentStep = beanDebug.getCurrentStep();

    			  // Supprime tous les points d'arret
//    			  EventRequestManager eventRequestManager = virtualMachine.eventRequestManager();
//    			  eventRequestManager.deleteAllBreakpoints();

    			  if (currentStep!=null)
    				  currentStep.thread().resume();
				  brkE.thread().resume();
    			  virtualMachine.resume();
    			  
//    			  ThrdDebugEventQueue thrdDebugEventQueue = beanDebug.getThrdDebugEventQueue();
//    			  if (thrdDebugEventQueue!=null) {
//    				  thrdDebugEventQueue.stopRunning();
//    			  }

    			  beanDebug.setCurrentEvent(null);
    			  beanDebug.setCurrentStep(null);
    			  beanDebug.setThrdDebugEventQueue(null);

    			  // Recréé la totalitée des points d'arret
//    			  Hashtable tableBreakpoint = beanDebug.getTableBreakpoint();
//    			  if (tableBreakpoint!=null) {
//    				  BreakpointRequest brkR1 = null, brkR2 = null;
//    				  Object key = null;
//    				  Enumeration enumKeys = tableBreakpoint.keys();
//    				  while(enumKeys.hasMoreElements()) {
//    					  key = enumKeys.nextElement();
//    					  brkR1 = (BreakpointRequest)tableBreakpoint.get(key);
//    					  // Suppression du point d'arret
//    					  eventRequestManager.deleteEventRequest(brkR1);
//    					  brkR2 = eventRequestManager.createBreakpointRequest(brkR1.location());
//    					  if (brkR2!=null) {
//    						  // Stock le nom de l'application dans le point d'arret
//    						  brkR2.putProperty("application", brkR1.getProperty("application"));
//    						  // Stock le chemin des sources de la class dans le point d'arret
//    						  brkR2.putProperty("path", brkR1.getProperty("path"));
//    						  // Stock le nom de la class dans le point d'arret
//    						  brkR2.putProperty("className", brkR1.getProperty("className"));
//    						  // Stock le nom du fichier dans le point d'arret
//    						  brkR2.putProperty("fileName", brkR1.getProperty("fileName"));
//    						  brkR2.enable();
//    					  }
//						  tableBreakpoint.put(key, brkR2);
//    				  }
//    			  }

    			  PrintWriter out = response.getWriter();
    			  out.print("resume");
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

package workspace.service.debug;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.bean.debug.BeanDebug;

import com.sun.jdi.ThreadReference;
import com.sun.jdi.VirtualMachine;
import com.sun.jdi.event.Event;
import com.sun.jdi.event.LocatableEvent;
import com.sun.jdi.request.EventRequest;
import com.sun.jdi.request.EventRequestManager;
import com.sun.jdi.request.StepRequest;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugBreakpointStep extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
  	  HttpSession session = request.getSession();
  	  String step = (String)bean.getParameterDataByName("step");
  	  VirtualMachine virtualMachine = null;
	  try {
    	  BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
    	  if (beanDebug!=null) {
    		  Event currentEvent = beanDebug.getCurrentEvent();
    		  if ((currentEvent!=null)&&(currentEvent instanceof LocatableEvent)) {
	              PrintWriter out = response.getWriter();
    			  virtualMachine = beanDebug.getVirtualMachine();
    			  LocatableEvent brkE = (LocatableEvent)currentEvent;
    			  EventRequest brkR = brkE.request();
    			  ThreadReference thread=brkE.thread();

    			  // it should exist
    			  if (thread == null) {
    				  throw new Exception("Invalid thread ID or the thread is dead");
    			  }
    			  
    			  // we need to be suspended.
    			  // also see ThreadCommands.getThreadStringRep for some info
    			  if (thread.suspendCount() == 0) {
    				  throw new  Exception("The specified thread is not suspended");
    			  }

	    		  int lineNumber = brkE.location().lineNumber();
	    		  // Avance d'une ligne car difference entre le BreakpointEvent et le StepEvent
	    		  lineNumber++;
				  // Recupere le nom de l'application du point d'arret
	    		  String application = URLEncoder.encode((String)brkR.getProperty("application"), "UTF-8");
				  // Recupere le chemin des sources de la class du point d'arret
	    		  String path = (String)brkR.getProperty("path");//URLEncoder.encode((String)brkR.getProperty("path"), "UTF-8");
				  // Recupere le nom de la class du point d'arret
	    		  String className = URLEncoder.encode((String)brkR.getProperty("className"), "UTF-8");
				  // Recupere le nom du fichier source
	    		  String sourceName = URLEncoder.encode(brkE.location().sourceName(), "UTF-8");
	    		  String fileName = URLEncoder.encode((String)brkR.getProperty("fileName"), "UTF-8");

	    		  if (fileName.equals(sourceName)) {
		    		  EventRequestManager eventRequestManager = virtualMachine.eventRequestManager();
	
	    			  // clear any previous steps on this thread
	    			  clearPreviousStep(eventRequestManager, thread);
	
	    			  int depth = StepRequest.STEP_INTO;
	    			  boolean into_all = false;
	    			  if (UtilString.isEqualsIgnoreCase(step, "OVER"))
	    				  depth = StepRequest.STEP_OVER;
	    			  else if (UtilString.isEqualsIgnoreCase(step, "OUT"))
	    				  depth = StepRequest.STEP_OUT;
		    		  else if (UtilString.isEqualsIgnoreCase(step, "INTO-ALL"))
		    			  into_all = true;
	
	    			  StepRequest stepRequest = eventRequestManager.createStepRequest(thread, StepRequest.STEP_LINE, depth);
	
	    			  if (depth == StepRequest.STEP_INTO) 
	    				  if (into_all) {
	    				  } else {
	    					  stepRequest.addClassExclusionFilter("java.*");
	    					  stepRequest.addClassExclusionFilter("javax.*");     
	    					  stepRequest.addClassExclusionFilter("sun.*"); 
	    				  }
	
					  // Stock le nom de l'application dans le point d'arret
	    			  stepRequest.putProperty("application", application);
					  // Stock le chemin des sources de la class dans le point d'arret
	    			  stepRequest.putProperty("path", path);
					  // Stock le nom de la class dans le point d'arret
	    			  stepRequest.putProperty("className", className);
					  // Stock le nom du fichier dans le point d'arret
	    			  stepRequest.putProperty("fileName", fileName);
	
					  stepRequest.addCountFilter(1);  // next step only
	    			  stepRequest.enable();
	    			  stepRequest.putProperty("line", new Integer(lineNumber));
	    			  beanDebug.setCurrentStep(stepRequest);
	
		              out.print(application+":"+path+":"+sourceName+":"+lineNumber);
	    		  }
	    		  else {
		              out.print("resume");
	    		  }
    		  }
    	  }
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

    /**
     * Clear a previous step request on this thread: only one is allowed
     * per thread
     */
    private void clearPreviousStep(EventRequestManager eventRequestManager, ThreadReference thread) {
    	List requests = eventRequestManager.stepRequests();
    	Iterator iter = requests.iterator();
    	while (iter.hasNext()) {
    		StepRequest request = (StepRequest)iter.next();
    		ThreadReference requestThread =  request.thread();
    		if (requestThread.equals(thread)) {
    			eventRequestManager.deleteEventRequest(request);
    			break;
    		}
    	}
    }
}

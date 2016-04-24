package workspace.bean.debug;

import com.sun.jdi.IncompatibleThreadStateException;
import com.sun.jdi.StackFrame;
import com.sun.jdi.ThreadReference;
import com.sun.jdi.VirtualMachine;
import com.sun.jdi.event.Event;
import com.sun.jdi.event.LocatableEvent;
import com.sun.jdi.request.EventRequestManager;
import com.sun.jdi.request.StepRequest;
import java.util.Hashtable;
import java.util.List;
import workspace.thread.debug.ThrdDebugEventQueue;

/**
 * @author  HP_Administrateur
 */
public class BeanDebug {

	private VirtualMachine virtualMachine;
	private Event currentEvent;
	private StepRequest currentStep;
	private Hashtable tableBreakpoint;
	private ThrdDebugEventQueue thrdDebugEventQueue;

	public BeanDebug() {
		this.tableBreakpoint = new Hashtable();
	}

	public BeanDebug(VirtualMachine pVirtualMachine) {
		this.tableBreakpoint = new Hashtable();
		this.virtualMachine = pVirtualMachine;
	}

	public EventRequestManager getEventRequestManager() {
		EventRequestManager ret = null;
		if (virtualMachine!=null) {
			ret = virtualMachine.eventRequestManager();
		}
		return ret;
	}

	public List getBreakpointRequests() {
		List ret = null;
		EventRequestManager eventRequestManager = getEventRequestManager();
		if (eventRequestManager!=null) {
			ret = eventRequestManager.breakpointRequests();
		}
		return ret;
	}
	
	public LocatableEvent getEvent() {
		LocatableEvent ret = null;
		Event currentEvent = getCurrentEvent();
		if ((currentEvent!=null)&&(currentEvent instanceof LocatableEvent)) {
			ret = (LocatableEvent)currentEvent;
		}
		return ret;
	}

	public ThreadReference getThread() {
		ThreadReference ret = null;
		LocatableEvent event = getEvent();
		if (event !=null) {
			ret = event.thread();
		}
		return ret;
	}

	public List getFrames() throws IncompatibleThreadStateException {
		List ret = null;
		ThreadReference thread = getThread();
		if (thread !=null) {
			ret = thread.frames();
		}
		return ret;
	}

	public Integer getFrameCount() throws IncompatibleThreadStateException {
		Integer ret = null;
		ThreadReference thread = getThread();
		if (thread !=null) {
			ret = new Integer(thread.frameCount());
		}
		return ret;
	}

	public StackFrame getFrame(String index) throws IncompatibleThreadStateException {
		return (index==null) ? null : getFrame(new Integer(index));
	}

	public StackFrame getFrame(Integer index) throws IncompatibleThreadStateException {
		StackFrame ret = null;
		ThreadReference thread = getThread();
		if (thread !=null) {
			ret = thread.frame(index.intValue());
		}
		return ret;
	}

	/**
	 * @return  the tableBreakpoint
	 * @uml.property  name="tableBreakpoint"
	 */
	public Hashtable getTableBreakpoint() {
		return tableBreakpoint;
	}

	/**
	 * @param tableBreakpoint  the tableBreakpoint to set
	 * @uml.property  name="tableBreakpoint"
	 */
	public void setTableBreakpoint(Hashtable tableBreakpoint) {
		this.tableBreakpoint = tableBreakpoint;
	}

	/**
	 * @return  the virtualMachine
	 * @uml.property  name="virtualMachine"
	 */
	public VirtualMachine getVirtualMachine() {
		return virtualMachine;
	}

	/**
	 * @param virtualMachine  the virtualMachine to set
	 * @uml.property  name="virtualMachine"
	 */
	public void setVirtualMachine(VirtualMachine virtualMachine) {
		this.virtualMachine = virtualMachine;
	}

	/**
	 * @return  the thrdDebugEventQueue
	 * @uml.property  name="thrdDebugEventQueue"
	 */
	public ThrdDebugEventQueue getThrdDebugEventQueue() {
		return thrdDebugEventQueue;
	}

	/**
	 * @param thrdDebugEventQueue  the thrdDebugEventQueue to set
	 * @uml.property  name="thrdDebugEventQueue"
	 */
	public void setThrdDebugEventQueue(ThrdDebugEventQueue thrdDebugEventQueue) {
		this.thrdDebugEventQueue = thrdDebugEventQueue;
	}

	/**
	 * @return  the currentEvent
	 * @uml.property  name="currentEvent"
	 */
	public Event getCurrentEvent() {
		return currentEvent;
	}

	/**
	 * @param currentEvent  the currentEvent to set
	 * @uml.property  name="currentEvent"
	 */
	public void setCurrentEvent(Event currentEvent) {
		this.currentEvent = currentEvent;
	}

	/**
	 * @return  the currentStep
	 * @uml.property  name="currentStep"
	 */
	public StepRequest getCurrentStep() {
		return currentStep;
	}

	/**
	 * @param currentStep  the currentStep to set
	 * @uml.property  name="currentStep"
	 */
	public void setCurrentStep(StepRequest currentStep) {
		this.currentStep = currentStep;
	}
}

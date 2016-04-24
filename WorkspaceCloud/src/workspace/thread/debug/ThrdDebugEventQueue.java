package workspace.thread.debug;

import com.sun.jdi.VMDisconnectedException;
import com.sun.jdi.event.Event;
import com.sun.jdi.event.EventIterator;
import com.sun.jdi.event.EventQueue;
import com.sun.jdi.event.EventSet;
import com.sun.jdi.event.LocatableEvent;

import framework.trace.Trace;

import java.io.PrintStream;
import java.io.Serializable;
import workspace.bean.debug.BeanDebug;

/**
 * a servlet handles upload request.<br> refer to http://www.ietf.org/rfc/rfc1867.txt
 */

public class ThrdDebugEventQueue extends Thread implements Serializable {

	private BeanDebug beanDebug; 
	private EventQueue eventQ;
	private transient PrintStream out;
	private transient PrintStream outTrace;
	private transient PrintStream err;
	private transient PrintStream errTrace;
	private boolean running = true;

	public ThrdDebugEventQueue(BeanDebug beanDebug, EventQueue eventQ) {
		setBeanDebug(beanDebug);
		setEventQ(eventQ);
	}

    public void run() {
		if (eventQ!=null) {
			try {
				while (running) {
					EventSet eventSet=null;
					try {
						eventSet = eventQ.remove();
						EventIterator eventIterator = eventSet.eventIterator();
						while (eventIterator.hasNext()) {
							Event event = eventIterator.nextEvent();
							if (event instanceof LocatableEvent) {
								beanDebug.setCurrentEvent(event);
								// eventQ.virtualMachine().resume();
								// running = false;
								break;
							}
						}
					} catch (VMDisconnectedException e) {
						Trace.ERROR(this, e);
						running = false;
						break;
					} catch (Exception e) {
						Trace.ERROR(this, e);
					}
				}
			} catch (Exception e) {
				onException(e);
			}
			finally {
				//try { eventQ.virtualMachine().dispose(); } catch (Exception ex) {onException(ex);}
			}
		}
    }

    public void stopRunning() {
    	running = false;
    }
    
    protected void onException(Exception e) {
	  if (errTrace!=null)
		  e.printStackTrace(errTrace);
	  if (err!=null)
		  err.println(e.getMessage());
    }

	/**
	 * @return  the eventQ
	 * @uml.property  name="eventQ"
	 */
	public EventQueue getEventQ() {
		return eventQ;
	}

	/**
	 * @param eventQ  the eventQ to set
	 * @uml.property  name="eventQ"
	 */
	public void setEventQ(EventQueue eventQ) {
		this.eventQ = eventQ;
	}

	/**
	 * @return  the beanDebug
	 * @uml.property  name="beanDebug"
	 */
	public BeanDebug getBeanDebug() {
		return beanDebug;
	}

	/**
	 * @param beanDebug  the beanDebug to set
	 * @uml.property  name="beanDebug"
	 */
	public void setBeanDebug(BeanDebug beanDebug) {
		this.beanDebug = beanDebug;
	}

	/**
	 * @return  the err
	 * @uml.property  name="err"
	 */
	public PrintStream getErr() {
		return err;
	}

	/**
	 * @param err  the err to set
	 * @uml.property  name="err"
	 */
	public void setErr(PrintStream err) {
		this.err = err;
	}

	/**
	 * @return  the errTrace
	 * @uml.property  name="errTrace"
	 */
	public PrintStream getErrTrace() {
		return errTrace;
	}

	/**
	 * @param errTrace  the errTrace to set
	 * @uml.property  name="errTrace"
	 */
	public void setErrTrace(PrintStream errTrace) {
		this.errTrace = errTrace;
	}

	/**
	 * @return  the out
	 * @uml.property  name="out"
	 */
	public PrintStream getOut() {
		return out;
	}

	/**
	 * @param out  the out to set
	 * @uml.property  name="out"
	 */
	public void setOut(PrintStream out) {
		this.out = out;
	}

	/**
	 * @return  the outTrace
	 * @uml.property  name="outTrace"
	 */
	public PrintStream getOutTrace() {
		return outTrace;
	}

	/**
	 * @param outTrace  the outTrace to set
	 * @uml.property  name="outTrace"
	 */
	public void setOutTrace(PrintStream outTrace) {
		this.outTrace = outTrace;
	}
}

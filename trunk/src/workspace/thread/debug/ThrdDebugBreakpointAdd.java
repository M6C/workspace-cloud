package workspace.thread.debug;

import com.sun.jdi.AbsentInformationException;
import com.sun.jdi.ClassType;
import com.sun.jdi.Location;
import com.sun.jdi.VirtualMachine;
import com.sun.jdi.event.BreakpointEvent;
import com.sun.jdi.event.Event;
import com.sun.jdi.event.EventIterator;
import com.sun.jdi.event.EventQueue;
import com.sun.jdi.event.EventSet;
import com.sun.jdi.request.BreakpointRequest;
import com.sun.jdi.request.EventRequestManager;
import java.io.PrintStream;
import java.io.Serializable;
import java.util.List;
import workspace.bean.debug.BeanDebug;

/**
 * a servlet handles upload request.<br> refer to http://www.ietf.org/rfc/rfc1867.txt
 */

public class ThrdDebugBreakpointAdd extends Thread implements Serializable {

	private BeanDebug beanDebug;
	private String className;
	private Integer rowNum;
	private transient PrintStream out;
	private transient PrintStream outTrace;
	private transient PrintStream err;
	private transient PrintStream errTrace;

	public ThrdDebugBreakpointAdd(BeanDebug beanDebug, String className, Integer rowNum) {
		setClassName(className);
		setRowNum(rowNum);
		setBeanDebug(beanDebug);
	}

    public void run() {
    	VirtualMachine virtualMachine = beanDebug.getVirtualMachine();
		if (virtualMachine!=null) {
			try {
				// restrict Method-EntryRequest by adding a class filter
				// to display interactions between application objects 
				EventRequestManager em = virtualMachine.eventRequestManager();
				List listClass = virtualMachine.classesByName(className);
				if ((listClass!=null)&&(listClass.size()>0)) {
					ClassType ct = (ClassType)listClass.get(0);
					List listLocation = ct.locationsOfLine(rowNum.intValue());
					if ((listLocation!=null)&&(listLocation.size()>0)) {
						Location loc = (Location)listLocation.get(0);
						BreakpointRequest brkR =em.createBreakpointRequest(loc);
						brkR.enable();
						boolean running = true;
						EventQueue eventQ=virtualMachine.eventQueue();
						while (running) {
							EventSet eventSet=null;
							try { eventSet=eventQ.remove(); }
							catch (Exception e) {e.printStackTrace();}
							EventIterator eventIterator=eventSet.eventIterator();
							while (eventIterator.hasNext()) {
								Event event=eventIterator.nextEvent();
								if (event instanceof BreakpointEvent) {
									beanDebug.setCurrentEvent(event);
									virtualMachine.resume();
								}
							}
						}
					}
				}
			} catch (AbsentInformationException e) {
				onException(e);
			} catch (Exception e) {
				onException(e);
			}
			finally {
				try { virtualMachine.dispose(); } catch (Exception ex) {onException(ex);}
			}
		}
    }
    
    protected void onException(Exception e) {
	  if (errTrace!=null)
		  e.printStackTrace(errTrace);
	  if (err!=null)
		  err.println(e.getMessage());
    }

	/**
	 * @return  the className
	 * @uml.property  name="className"
	 */
	public String getClassName() {
		return className;
	}

	/**
	 * @param className  the className to set
	 * @uml.property  name="className"
	 */
	public void setClassName(String className) {
		this.className = className;
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
	 * @return  the rowNum
	 * @uml.property  name="rowNum"
	 */
	public Integer getRowNum() {
		return rowNum;
	}

	/**
	 * @param rowNum  the rowNum to set
	 * @uml.property  name="rowNum"
	 */
	public void setRowNum(Integer rowNum) {
		this.rowNum = rowNum;
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
}

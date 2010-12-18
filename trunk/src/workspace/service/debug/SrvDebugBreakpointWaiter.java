package workspace.service.debug;

import java.util.StringTokenizer;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NameNotFoundException;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import workspace.thread.debug.ThrdDebugEventQueue;
import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugBreakpointWaiter extends SrvGenerique {

	public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
	  // get the initial context, refer to your app server docs for this
	  Context ctx = new InitialContext();
	  ThrdDebugEventQueue thread = (ThrdDebugEventQueue)getJNDIObject(ctx, "/workspace/debug/breakpoint", request.getSession().getId());
	  if ((thread!=null)&&(thread.getBeanDebug()!=null)) {
		  request.setAttribute("breakpoint", thread.getBeanDebug().getCurrentEvent());
	  }
    }

    protected Object getJNDIObject(Context ctx, String path, String name) throws NamingException {
    	Object o = ctx.lookup(path);
		if (o instanceof Context) {
			ctx = (Context)o;
			o = ctx.lookup(name);
		}
		else
			o = null;
		return o;
    }
    
    protected Context createContext(Context ctx, String path) throws NamingException {
    	Object o = null;
    	String name = null;
    	StringTokenizer st = new StringTokenizer(path, "/");
		while(st.hasMoreTokens()) {
			name = st.nextToken();
			try {
				o = ctx.lookup(name);
				if (o instanceof Context)
					ctx = (Context)o;
				else
					break;
			} catch(NameNotFoundException ex) {
				ctx = ctx.createSubcontext(name);
			}
		}
		return ctx;
    }
}

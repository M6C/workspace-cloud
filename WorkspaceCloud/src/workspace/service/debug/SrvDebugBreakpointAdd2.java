package workspace.service.debug;

import java.io.PrintWriter;
import java.io.Serializable;
import java.io.StringWriter;
import java.util.Hashtable;
import java.util.StringTokenizer;

import javax.jms.JMSException;
import javax.jms.Message;
import javax.jms.Queue;
import javax.jms.QueueConnection;
import javax.jms.QueueConnectionFactory;
import javax.jms.QueueSender;
import javax.jms.QueueSession;
import javax.jms.Session;
import javax.naming.Context;
import javax.naming.NameAlreadyBoundException;
import javax.naming.NameNotFoundException;
import javax.naming.NamingException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import workspace.bean.debug.BeanDebug;
import workspace.thread.debug.ThrdDebugBreakpointAdd;

import com.sun.jdi.VirtualMachine;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.ressource.util.jdi.UtilJDI;
import framework.service.SrvGenerique;

/**
 *
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 * 
 */

public class SrvDebugBreakpointAdd2 extends SrvGenerique {

    public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
      String szClass = (String)bean.getParameterDataByName("breakpointClass");
      String szLigne = (String)bean.getParameterDataByName("breakpointLine");
      if (UtilString.isNotEmpty(szClass) &&
          UtilString.isNotEmpty(szLigne)){
          HttpSession session = request.getSession();
          try {
          String hostName = "localhost";
          Integer port = new Integer(8380);

          String className = szClass;
          Integer rowNum = new Integer(szLigne);
/*
          List listEvent = (List)request.getSession().getAttribute("listEvent");
          if (listEvent==null) {
              listEvent = new LinkedList();
              session.setAttribute("listEvent", listEvent);
          }

          VirtualMachine vm = (VirtualMachine)request.getSession().getAttribute("virtualMachine");
          if (listEvent==null) {
              vm = UtilJDI.createVirtualMachine(hostName, port);
              session.setAttribute("virtualMachine", vm);
          }

          Hashtable tableBreakpoint = (Hashtable)request.getSession().getAttribute("tableBreakpoint");
          if (tableBreakpoint==null) {
              tableBreakpoint = new Hashtable();
              session.setAttribute("tableBreakpoint", tableBreakpoint);
          }
*/
          VirtualMachine vm = UtilJDI.createVirtualMachine(hostName, port);
          BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
          if (beanDebug==null) {
              beanDebug = new BeanDebug(vm);
              session.setAttribute("beanDebug", beanDebug);
          }
          else
              beanDebug.setVirtualMachine(vm);
          Hashtable tableBreakpoint = beanDebug.getTableBreakpoint();

          ThrdDebugBreakpointAdd thread = new ThrdDebugBreakpointAdd(beanDebug, className, rowNum);
          thread.setOut(System.out);
          thread.setErr(System.err);
          thread.setErrTrace(System.err);
          thread.start();

          tableBreakpoint.put(szClass+":"+szLigne, thread);
/*
          // get the initial context, refer to your app server docs for this
          Context ctx = new InitialContext();
          addToJNDI(ctx, "/workspace/debug/breakpoint", request.getSession().getId(), thread);
//          addToQueue(ctx, "/queue", request.getSession().getId(), thread);
*/
          System.out.println(szClass+":"+szLigne+":added");
          }
          catch(Exception ex) {
              StringWriter sw = new StringWriter();
              ex.printStackTrace(new PrintWriter(sw));
              request.setAttribute("msgText", sw.toString());
              throw ex;
          }
      }
    }
    
    protected void addToJNDI(Context ctx, String path, String name, Serializable object) throws NamingException {
        ctx = createContext(ctx, path);
        try {
            ctx.bind(name, object);
        }
        catch(NameAlreadyBoundException ex) {
            ctx.rebind(name, object);
        }
    }
    protected void addToQueue(Context ctx, String path, String name, Serializable object) throws NamingException, JMSException {
      QueueConnection queueCon = null;
      try {
          // get the connection factory, and open a connection
          QueueConnectionFactory qcf = (QueueConnectionFactory) ctx.lookup("ConnectionFactory");
          queueCon = qcf.createQueueConnection();
          // create queue session off the connection
          QueueSession queueSession = queueCon.createQueueSession(false, Session.AUTO_ACKNOWLEDGE );
          // get handle on queue, create a sender and send the message
          Queue queue = null;
//          String queueName = "jms/workspace/debug/breakpoint/" + request.getSession().getId();
          ctx = createContext(ctx, path);
          queue = queueSession.createQueue(name);//(Queue)ctx.lookup("jms/queue/devilman");
          if (queue!=null) {
            QueueSender sender = queueSession.createSender(queue);
//            Message msg = queueSession.createTextMessage( "hello..." );
//            sender.send( msg );
            Message msg = queueSession.createObjectMessage(object);
            sender.send(msg);              
            System.out.println( "sent the message" );
          }
      }
      finally {
          // close the queue connection
          if( queueCon != null ) {
              queueCon.close();
          }
      }
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

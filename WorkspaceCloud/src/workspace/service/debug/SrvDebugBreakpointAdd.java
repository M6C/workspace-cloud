package workspace.service.debug;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.PrintWriter;
import java.io.Serializable;
import java.io.StringWriter;
import java.net.URLEncoder;
import java.util.Hashtable;
import java.util.List;
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

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import workspace.bean.debug.BeanDebug;
import workspace.thread.debug.ThrdDebugEventQueue;

import com.sun.jdi.Location;
import com.sun.jdi.VirtualMachine;
import com.sun.jdi.request.BreakpointRequest;
import com.sun.jdi.request.EventRequest;
import com.sun.jdi.request.EventRequestManager;

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

public class SrvDebugBreakpointAdd extends SrvGenerique {

    public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
      String szLigne = (String)bean.getParameterDataByName("breakpointLine");
      String application = (String)bean.getParameterDataByName("application");
      String path = (String)bean.getParameterDataByName("pathToExpand");
      String fileName = (String)bean.getParameterDataByName("FileName");
      if (UtilString.isNotEmpty(szLigne) &&
              UtilString.isNotEmpty(application) &&
              UtilString.isNotEmpty(fileName)){
          HttpSession session = request.getSession();
          VirtualMachine virtualMachine = null;
          try {
              String hostName = "localhost";
              Integer port = new Integer(8380);
              String text = "";
    
              Document domXml = (Document)session.getAttribute("resultDom");
              String filePathMain = AdpXmlApplication.getPathMain(domXml, application);
              File filePath = new File(filePathMain, path);
              File file = new File(filePath, fileName);
              String className = "";//szClass;
              FileReader fileReader = new FileReader(file);
              BufferedReader fileInput = new BufferedReader(fileReader);
              String lineFile = fileInput.readLine();
              while (lineFile!=null) {
                  lineFile = lineFile.trim();
                  if (lineFile.toUpperCase().startsWith("PACKAGE ")&&
                      lineFile.endsWith(";")) {
                      className = lineFile.substring(8, lineFile.length()-1);
                      break;
                  }
                  lineFile = fileInput.readLine();
              }

              className += fileName.substring(0, fileName.lastIndexOf('.'));
              className = className.replace('\\', '.').replace('/', '.');
              Integer rowNum = new Integer(szLigne);

//              BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
//              if (beanDebug==null) {
//                  beanDebug = new BeanDebug();
//                  session.setAttribute("beanDebug", beanDebug);
//              }
//              VirtualMachine virtualMachine = beanDebug.getVirtualMachine();
//              if (virtualMachine==null) {
//                  virtualMachine = UtilJDI.createVirtualMachine(hostName, port);
//                  beanDebug.setVirtualMachine(virtualMachine);
//              }
//              ThrdDebugEventQueue thread = beanDebug.getThrdDebugEventQueue();
//              if (thread==null) {
//                  thread = new ThrdDebugEventQueue(beanDebug, virtualMachine.eventQueue());
//                  thread.setOut(System.out);
//                  thread.setErr(System.err);
//                  thread.setErrTrace(System.err);
//                  thread.start();
//                  
//                  beanDebug.setThrdDebugEventQueue(thread);
//              }
              

              BeanDebug beanDebug = (BeanDebug)session.getAttribute("beanDebug");
              if (beanDebug==null) {
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

              Hashtable tableBreakpoint = beanDebug.getTableBreakpoint();
              EventRequest eventRequest = null;
              BreakpointRequest brkR = null;
              Location location = null;
              EventRequestManager eventRequestManager = virtualMachine.eventRequestManager();
              List breakpointRequests = eventRequestManager.breakpointRequests();
              int size = breakpointRequests.size();
              for(int i=0 ; i<size ; i++) {
                  eventRequest = (EventRequest)breakpointRequests.get(i);
                  if (eventRequest instanceof BreakpointRequest) {
                      brkR = (BreakpointRequest)eventRequest;
                      location = brkR.location();
                      if (className.equals(brkR.getProperty("className")) &&
                              (location.lineNumber()==rowNum.intValue())) {
                          break;
                      }
                      else
                          brkR = null;
                  }
              }
              if (brkR==null) {
                  brkR = UtilJDI.createBreakpointRequest(virtualMachine, className, rowNum);
                  if (brkR!=null) {
                      // Stock le nom de l'application dans le point d'arret
                      brkR.putProperty("application", application);
                      // Stock le chemin des sources de la class dans le point d'arret
                      brkR.putProperty("path", path);
                      // Stock le nom de la class dans le point d'arret
                      brkR.putProperty("className", className);
                      // Stock le nom du fichier dans le point d'arret
                      brkR.putProperty("fileName", file.getName());
                      
                      tableBreakpoint.put(className+":"+szLigne, brkR);
                      
                      text = "added";
                  }
                  else {
                      text = URLEncoder.encode("Can't create breakpoint", "UTF-8");
                  }
              } else {
                  eventRequestManager.deleteEventRequest(brkR);
                  tableBreakpoint.remove(className+":"+szLigne);
                  text = "deleted";
              }
              
/*
// get the initial context, refer to your app server docs for this
Context ctx = new InitialContext();
addToJNDI(ctx, "/workspace/debug/breakpoint", request.getSession().getId(), thread);
//          addToQueue(ctx, "/queue", request.getSession().getId(), thread);
*/
              PrintWriter out = response.getWriter();
              out.print(className+":"+szLigne+":"+text);
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

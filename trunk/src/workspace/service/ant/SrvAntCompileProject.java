 package workspace.service.ant;


import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintStream;
import java.io.PrintWriter;
import java.io.StringBufferInputStream;
import java.io.StringWriter;
import java.util.Hashtable;
import java.util.LinkedList;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.tools.ant.BuildEvent;
import org.apache.tools.ant.BuildListener;
import org.apache.tools.ant.BuildLogger;
import org.apache.tools.ant.DefaultLogger;
import org.apache.tools.ant.NoBannerLogger;
import org.apache.tools.ant.Project;
import org.apache.tools.ant.ProjectHelper;
import org.apache.tools.ant.Target;
import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;


// import org.apache.log4j.Category; // if you use Log4j

/**
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 *
 * @version  Revision: 1.1
 * @author   Yoon Kyung Koo
 */

public class SrvAntCompileProject extends SrvGenerique {

    public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
      HttpSession session = request.getSession();
      ServletContext context = session.getServletContext();
      String target= (String)bean.getParameterDataByName("target");
      if (UtilString.isNotEmpty(target)){
    	  ByteArrayOutputStream streamLog = new ByteArrayOutputStream();
          PrintStream psLog = new PrintStream(streamLog);
          PrintStream out = System.out;
          PrintStream err = System.err;
          try {
            String application = (String)bean.getParameterDataByName("application");
            Document domXml = (Document)session.getAttribute("resultDom");
            //Recuperation du chemin principal de l'application
            String szPathMain = AdpXmlApplication.getPathByName(context, domXml, application, "Main");
            //Recuperation du chemin des sources
            String szPathSource = AdpXmlApplication.getPathByName(context, domXml, application, "Source");
            //Recuperation du chemin de destination des classes
            String szPathClass = AdpXmlApplication.getPathByName(context, domXml, application, "Class");
            //Recuperation des classpath de l'application
            String szClasspath = AdpXmlApplication.getClassPathAll(context, domXml, application);
            //Recuperation de la home du jdk
            //String szJdkpath = AdpXmlApplication.getJdkPathByName(context, domXml, application, "Home");
            //Recuperation du repertoire home de la jre
            //String szJreHome = AdpXmlApplication.getPathByName(context, domXml, application, "Home");
            //Recuperation du repertoire lib de la jre
            //String szJreLib = AdpXmlApplication.getPathByName(context, domXml, application, "Lib");

            // Chemin source des classes
            szPathSource = new File(szPathMain, szPathSource).getCanonicalPath();
            
            String szClassName = (String)bean.getParameterDataByName("className");
            if (UtilString.isNotEmpty(szClassName)) {
                szPathSource = new File(szPathMain, szClassName).getCanonicalPath();
            }

            // Chemin destination des classe 
            szPathClass = new File(szPathMain, szPathClass).getCanonicalPath();
            Project p = new Project();
            File buildXml = new File(context.getRealPath("/Xml/Ant/Task/CompileProject.xml"));
            p.setUserProperty("ant.file", buildXml.getAbsolutePath());
            p.setProperty("java.src", szPathSource);
            p.setProperty("java.cls", szPathClass);
            p.setProperty("class.path", szClasspath);

            ProjectHelper ph = ProjectHelper.getProjectHelper();
            p.addReference("ant.projectHelper", ph);

            System.setErr(psLog);
            System.setOut(psLog);

            BuildLogger buildLogger = new NoBannerLogger();
            buildLogger.setMessageOutputLevel(Project.MSG_INFO);
            buildLogger.setOutputPrintStream(System.out);
            buildLogger.setErrorPrintStream(System.err);
            p.addBuildListener(buildLogger);

            p.init();

            ph.parse(p, buildXml);

            Hashtable hTarget = p.getTargets();
            if (hTarget!=null) {
              Object aTarget = hTarget.get(target);
              if (target!=null) {
                  if (aTarget instanceof Target) {
                      ((Target)aTarget).execute();
                  }
                  else if (aTarget instanceof String) {
                      p.executeTarget((String)aTarget);
                  }
              }
            }
          } catch (Exception ex) {
              //StringWriter sw = new StringWriter();
              //ex.printStackTrace(sw);
              //request.setAttribute("msgText", sw);
              ex.printStackTrace(psLog);
          }
          finally {
        	  System.setErr(err);
        	  System.setOut(out);
        	  //streamLog.write(new byte[]{'t', 'e', 's', 't'});
			request.setAttribute("msgText", streamLog.toString());
          }
      }
    }
}
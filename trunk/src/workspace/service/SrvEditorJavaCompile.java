/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringWriter;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.transform.Source;
import javax.xml.transform.URIResolver;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilBuildJavac;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilPackage;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilVector;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaCompile extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvGenerique#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    String pathSrc = (String)bean.getParameterDataByName("pathSrc");
    String pathDst = (String)bean.getParameterDataByName("pathDst");
    if (UtilString.isNotEmpty(pathSrc)) {
      Document domXml = (Document)session.getAttribute("resultDom");
      String application = (String)bean.getParameterDataByName("application");
      //Recuperation du chemin principal de l'application
      String szPathMain = AdpXmlApplication.getPathByName(context, domXml, application, "Main");
      //Recuperation du chemin des sources
      //String szPathSource = AdpXmlApplication.getPathByName(context, domXml, login, password, application, "Source");
      //Recuperation du chemin de destination des classes
      if (UtilString.isEmpty(pathDst)) {
          pathDst = AdpXmlApplication.getPathByName(context, domXml, application, "Class");
      }
      //Recuperation des classpath de l'application
      String szClasspath = AdpXmlApplication.getClassPathAll(context, domXml, application);
      //Recuperation de la home du jdk
      String szJdkpath = AdpXmlApplication.getJdkPathByName(context, domXml, application, "Home");
      //Recuperation du repertoire home de la jre
      String szJreHome = AdpXmlApplication.getJdkJrePathByName(context, domXml, application, "Home");
      //Recuperation du repertoire lib de la jre
      String szJreLib = AdpXmlApplication.getJdkJrePathByName(context, domXml, application, "Lib");

      // Chemin source des classes
      String szPathSrc = new File(szPathMain, pathSrc).getCanonicalPath();

      StringBuffer pathClass = new StringBuffer(UtilPackage.getPackageClassPath());
      // Ajout des Jar du repertoire Web-Inf
      addJarToClassPath(context.getRealPath("WEB-INF"), pathClass);
      // Ajout des Jar du repertoire Lib de la Jre
      if (UtilString.isNotEmpty(szJdkpath)) {
          File jdkPath = new File(szJdkpath);
          if (jdkPath.exists()) {
              File jreHome = null;
              File jreLib = null;
              if (UtilString.isNotEmpty(szJreHome))
                  jreHome = (szJreHome.indexOf(':')>0) ?  new File(szJreHome) : new File(jdkPath, szJreHome);
              if (UtilString.isNotEmpty(szJreLib)) {
                  File home = ((jreHome!=null)&&(jreHome.exists())) ? jreHome : jdkPath;
                  jreLib = (szJreLib.indexOf(':')>0) ? new File(szJreLib) : new File(home, szJreLib);
                  if (jreLib.exists()) {
                      addJarToClassPath(jreLib.getCanonicalPath(), pathClass);
                  }
              }
          }
      }
      //pathClass += ";" + szPathSrc + ";" + szClasspath;
      pathClass.append(";").append(szClasspath);
      ByteArrayOutputStream baosOut = new ByteArrayOutputStream();
      if (UtilString.isNotEmpty(pathDst)) {
          String[] listPathDst = UtilString.split(pathDst, ';');
          if (listPathDst!=null) {
            //pathClass.insert(0, pathDst + ";");
            int max = listPathDst.length;
            for(int i=0 ; i<max ; i++) {
            listPathDst[i] = new File(szPathMain, listPathDst[i]).getCanonicalPath();
              UtilBuildJavac.build(baosOut, szPathSrc, listPathDst[i], listPathDst[i] + ";" + pathClass.toString());
            }
          }
      }
      else {
          // Chemin destination des classes
          String szPathClass = new File(szPathMain, pathDst).getCanonicalPath();
          //String szPathClass = szPathMain;
          UtilBuildJavac.build(baosOut, szPathSrc, szPathClass, pathClass.toString());
      }
      String msg = baosOut.toString();
      if (msg.equals("")) {
    	  msg = "Build Completed";
      }
      // Trace pour la page de compilation
      request.setAttribute("traceOut", msg);
      // Trace pour la page de message
      request.setAttribute("msgText", msg);
    }
  }
  
  private void addJarToClassPath(String path, StringBuffer classpath) throws IOException {
      // Liste des jar du repertoire Web-Inf
      Vector listJar = UtilFile.dir(path, true, ".jar");
      int max = UtilVector.safeSize(listJar);
      for( int i=0 ; i<max ; i++) {
          classpath.append(";").append((String)UtilVector.safeGetElementAt(listJar, i));
      }
  }
}
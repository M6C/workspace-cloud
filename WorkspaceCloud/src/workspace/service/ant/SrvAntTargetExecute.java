package workspace.service.ant;


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

import org.apache.tools.ant.Project;
import org.apache.tools.ant.ProjectHelper;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilBuildJavac;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilPackage;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilVector;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;

import org.w3c.dom.Document;


// import org.apache.log4j.Category; // if you use Log4j

/**
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 *
 * @version  Revision: 1.1
 * @author   Yoon Kyung Koo
 */

public class SrvAntTargetExecute extends SrvGenerique {
    public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
      HttpSession session = request.getSession();
      ServletContext context = session.getServletContext();
      String target= (String)bean.getParameterDataByName("target");
      if (UtilString.isNotEmpty(target)){

        Dictionary param = new Hashtable();
        param.put("pApplication", request.getParameter("application"));
        Document domXml = (Document)session.getAttribute("resultDom");
        InputStream inputXsl = context.getResourceAsStream("Xsl/User/Application/Paths/Path/FindByName.xsl");
        StringWriter wPath = null;

        /**
         * Recuperation du chemin principal de l'application
        */
        wPath = new StringWriter();
        inputXsl.reset();
        param.put("pPath", "Main");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szPathMain = wPath.toString();
        wPath.close();

        inputXsl.close();

        /**
         * Recuperation du chemin des sources
         */
        wPath = new StringWriter();
        inputXsl.reset();
        param.put("pPath", "Source");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szPathSource = wPath.toString();
        wPath.close();

        inputXsl.close();

        /**
         * Recuperation du chemin de destination des classes
         */
        wPath = new StringWriter();
        inputXsl.reset();
        param.put("pPath", "Class");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szPathClass = wPath.toString();
        wPath.close();

        inputXsl.close();

        /**
         * Recuperation des classpath de l'application
         */
        wPath = new StringWriter();
        inputXsl = context.getResourceAsStream("Xsl/User/Application/Build/Classpath/All.xsl");
        param.remove("pPath");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szClasspath = wPath.toString();
        wPath.close();

        inputXsl.close();

        /**
         * Recuperation de la home du jdk
         */
        wPath = new StringWriter();
        inputXsl = context.getResourceAsStream("Xsl/User/Application/Jdk/Path/FindByName.xsl");
        param.put("pPath", "Home");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szJdkpath = wPath.toString();
        wPath.close();

        inputXsl.close();

        /**
         * Recuperation du repertoire home de la jre
         */
        wPath = new StringWriter();
        inputXsl = context.getResourceAsStream("Xsl/User/Application/Jdk/Jre/Path/FindByName.xsl");
        param.put("pPath", "Home");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szJreHome = wPath.toString();
        wPath.close();

        inputXsl.close();

        /**
         * Recuperation du repertoire lib de la jre
         */
        wPath = new StringWriter();
        inputXsl.reset();
        param.put("pPath", "Lib");
        UtilXML.tranformeXmlWithXsl(domXml, inputXsl, wPath, param);
        String szJreLib = wPath.toString();
        wPath.close();

        inputXsl.close();

        // Chemin source des classes
        szPathSource = new File(szPathMain, szPathSource).getCanonicalPath();
        // Chemin destination des classe 
        szPathClass = new File(szPathMain, szPathClass).getCanonicalPath();

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
                    jreLib = (szJreLib.indexOf(':')>0) ? new File(home, szJreLib) : new File(szJreLib);
                    if (jreLib.exists()) {
                        addJarToClassPath(jreLib.getCanonicalPath(), pathClass);
                    }
                }
            }
        }

        ProjectHelper ph = ProjectHelper.getProjectHelper();
        Project p = new Project();     
        File buildXml = new File(context.getResource("Xml/Ant/Task/CompileProject.xml").getPath());
        ph.parse(p, buildXml);

        p.setProperty("java.src", szPathSource);
        p.setProperty("java.cls", szPathClass);

        Hashtable hTarget = p.getTargets();
          if (hTarget!=null) {
              target = (String)hTarget.get(target);
              if (target!=null)
                  p.executeTarget((String)target);
          }
          System.out.println(p.getBaseDir());
          System.out.println(p.getDefaultTarget());
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
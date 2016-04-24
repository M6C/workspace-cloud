/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaPackageClean extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    String application = (String)bean.getParameterDataByName("application");
    String pack= (String)bean.getParameterDataByName("package");
    String type= (String)bean.getParameterDataByName("type");
    if (UtilString.isNotEmpty(application) &&
        UtilString.isNotEmpty(pack) &&
        UtilString.isNotEmpty(type)) {
      try {
        Document dom = (Document) request.getSession().getAttribute("resultDom");
        Document xml = AdpXmlApplication.getPackageXmlByName(context, dom, application, type, pack);
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
        if (filePathMain!=null && !filePathMain.equals("")) {
        	if (filePathMain.toUpperCase().startsWith("FTP://")) {
	            // @TODO FTP - Faire le clean du WAR
        	}
        	else {
	        	File fileMain = new File(filePathMain);
		        String exploded = UtilXML.getXPathStringValue(xml, "/PACKAGE/@Exploded");
		        String pathDst = UtilXML.getXPathStringValue(xml, "/PACKAGE/@Filename");
		        File file = null;
		        if (!new File(pathDst).isAbsolute()) {
		          file = new File(filePathMain, pathDst);
		        }  else {
		          file = new File(pathDst);
		        }
		        if (!file.getCanonicalPath().equals(fileMain.getCanonicalPath())) {
		        	if (file.isFile()) {
		        		file.delete();
		        	}
		        	else {
		                File[] listFile = file.listFiles();
		            	if (listFile!=null) {
		            		File f = null;
			        		int size = listFile.length;
			        		for(int i=0 ; i<size ; i++) {
			        			f = listFile[i];
			        			if (f.isFile())
			        				f.delete();
			        			else
			        				UtilFile.delete(f);
			        		}
			        		file.delete();
		            	}
		        	}
		        }
        	}
        }
      } catch(Exception ex) {System.out.println(ex.getMessage());}
    }
  }
}

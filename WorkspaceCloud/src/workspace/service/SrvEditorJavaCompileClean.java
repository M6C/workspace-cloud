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
public class SrvEditorJavaCompileClean extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    String application = (String)bean.getParameterDataByName("application");
    if (UtilString.isNotEmpty(application)) {
      try {
        Document dom = (Document) request.getSession().getAttribute("resultDom");
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
        String pathDst = AdpXmlApplication.getPathByName(context, dom, application, "Class");
        File file = new File(filePathMain, pathDst);
        File[] listFile = file.listFiles();
    	if (listFile!=null) {
    		int size = listFile.length;
    		for(int i=0 ; i<size ; i++) {
    			file = listFile[i];
    			if (file.isFile())
    				file.delete();
    			else
    				UtilFile.delete(file);
    		}
    	}
      } catch(Exception ex) {System.out.println(ex.getMessage());}
    }
  }
}

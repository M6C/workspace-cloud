/*
 * Créé le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
package workspace.service.common;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;
import framework.trace.Trace;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
public class SrvSelectProjetDirFilePage extends SrvGenerique {

	/* (non-Javadoc)
	 * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
	 */
	public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception{
		String application = (String)bean.getParameterDataByName("application");
    if (UtilString.isNotEmpty(application)) {
      try {
        if (UtilString.isNotEmpty(application)) {
          Document dom = (Document) request.getSession().getAttribute("resultDom");
          String filePathMain = AdpXmlApplication.getPathMain(dom, application);
          if (filePathMain!=null && !filePathMain.equals("")) {
          	if (filePathMain.toUpperCase().startsWith("FTP://")) {
	            // Initialise les paramètres de la requète
	            request.setAttribute("path", filePathMain);
        	}
        	else {
        	  File fileMain = new File(filePathMain);
	          // Initialise les paramètres de la requète
	          request.setAttribute("path", fileMain.toURI().getPath());
        	}
          }
        }
      }
      // If an Exception occurs, write the error to the page.
      catch (Exception ex) {
        Trace.ERROR(this, ex);
      }
    }
	}
}

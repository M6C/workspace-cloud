/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilBuildJar;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaZip
    extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvGenerique#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    String application = (String)bean.getParameterDataByName("application");
    String pathSrc= (String)bean.getParameterDataByName("pathSrc");
    String pathDst= (String)bean.getParameterDataByName("pathDst");
    String fileName= (String)bean.getParameterDataByName("fileName");
    if (UtilString.isNotEmpty(application) &&
        UtilString.isNotEmpty(fileName)) {
      try {
        Document dom = (Document) request.getSession().getAttribute("resultDom");
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
        if (filePathMain!=null && !filePathMain.equals("")) {
        	if (filePathMain.toUpperCase().startsWith("FTP://")) {
	            // @TODO FTP - Faire la création du ZIP
        	}
        	else {
	        	File fileMain = new File(filePathMain);
		        String pathMain = fileMain.toURI().getPath();
		        if (UtilString.isEmpty(pathSrc))
		          pathSrc = ".";
		        if (pathDst!=null)
		        	fileMain = new File(filePathMain, pathDst);
		        pathDst = fileMain.toURI().getPath();
		        String[] listPathSrc = UtilString.split(pathSrc, ';');
		        String[] listPathTo = new String[listPathSrc.length];
		        for(int i=0 ; i<listPathSrc.length ; listPathTo[i++]="");
		        pathDst = UtilFile.formatPath(pathDst, fileName);
		        UtilBuildJar.build(pathMain, listPathSrc, listPathTo, pathDst);
        	}
        }
      }
      catch(Exception ex){}
    }
  }
}

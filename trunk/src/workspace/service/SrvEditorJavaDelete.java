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
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;
import framework.taglib.file.bean.BeanFTP;
import framework.taglib.file.bean.BeanFTPAddress;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaDelete extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    String application = (String)bean.getParameterDataByName("application");
    String fileName= (String)bean.getParameterDataByName("fileName");
    String pathToExpand = (String)bean.getParameterDataByName("pathToExpand");
    if (UtilString.isNotEmpty(fileName)) {
      try {
        Document dom = (Document) request.getSession().getAttribute("resultDom");
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
        if (filePathMain!=null && !filePathMain.equals("")) {
        	if (filePathMain.toUpperCase().startsWith("FTP://")) {
	            //@TODO FTP - Faire la suppression
        		BeanFTPAddress address = new BeanFTPAddress(filePathMain);
        		fileName = ((pathToExpand==null) ? "" : pathToExpand)+fileName;
        		BeanFTP ftp = new BeanFTP(address, fileName);
        		ftp.delete();
        	}
        	else {
		        File fileMain = new File(filePathMain);
		        File file = new File(filePathMain, fileName);
		        if (!file.getCanonicalPath().equals(fileMain.getCanonicalPath()))
		          UtilFile.delete(file);
        	}
        }
      } catch(Exception ex) {System.out.println(ex.getMessage());}
    }
  }
}

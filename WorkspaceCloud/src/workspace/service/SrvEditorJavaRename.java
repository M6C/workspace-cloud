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
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaRename extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    String application = (String)bean.getParameterDataByName("application");
    String oldName= (String)bean.getParameterDataByName("oldName");
    String newName= (String)bean.getParameterDataByName("newName");
    if (UtilString.isNotEmpty(oldName)&&
        UtilString.isNotEmpty(newName)) {
      try {
        Document dom = (Document) request.getSession().getAttribute("resultDom");
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
    	new File(filePathMain, oldName).renameTo(new File(filePathMain, newName));
      } catch(Exception ex) {System.out.println(ex.getMessage());}
    }
  }
}

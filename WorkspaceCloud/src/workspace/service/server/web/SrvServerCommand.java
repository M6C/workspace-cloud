/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service.server.web;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import workspace.adaptateur.application.AdpXmlServer;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvServerCommand extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvGenerique#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    BeanGenerique beanAuthentification = (BeanGenerique)session.getAttribute("BeanAuthentification");
    //String login = (String)beanAuthentification.getParameterDataByName("login");
    //String password = (String)beanAuthentification.getParameterDataByName("password");
    String application = (String)bean.getParameterDataByName("application");
    String command = (String)bean.getParameterDataByName("command");
    String packagename = (String)bean.getParameterDataByName("package");
    Document domXml = (Document)session.getAttribute("resultDom");
    if (UtilString.isNotEmpty(application)&&
        UtilString.isNotEmpty(command)&&
        UtilString.isNotEmpty(packagename)&&
        (domXml!=null)) {
      try {
        String msgText = null;
        // Chemin principal de l'application selectionnamp;eacute;
        String filePathMain = AdpXmlApplication.getPathMain(domXml, application);
        String szCommand = AdpXmlServer.getCommandByName(context, domXml, application, command);
        String szServerDeploy = AdpXmlServer.getPathByName(context, domXml, application, "Root Deploy");
        String szFilename = AdpXmlApplication.getPackageFileNameByName(context, domXml, application, "War", packagename);
        //String szWebApp = new File(filePathMain, szFilename).getName();
        String szWebApp = new File(szServerDeploy, szFilename).toURL().toString();
//        szCommand += new File(new File(szServerDeploy),szWebApp).toURL().toString();
///        szCommand += URLEncoder.encode(new File(filePathMain, szFilename).toURL().toString());
        szCommand += URLEncoder.encode(szWebApp);
System.out.println(szCommand);
        if (UtilString.isNotEmpty(szCommand)) {
          msgText = sendHttpRequest(szCommand);
        }
        request.setAttribute("msgText", msgText);
      }
      catch(Exception ex){}
    }
  }

    private String sendHttpRequest(String request) throws IOException {
    StringBuffer response = new StringBuffer();

    URL url = new URL(request);
    HttpURLConnection connection = (HttpURLConnection)url.openConnection();
    connection.connect();
    BufferedReader reader = new BufferedReader(new InputStreamReader(connection.getInputStream()));
    String line;
    while ((line = reader.readLine()) != null) {
      response.append(line);
      response.append("\n");//$NON-NLS-1$
    }
    int code = connection.getResponseCode();
    connection.disconnect();

    return code+ "\n" + response.toString();//$NON-NLS-1$
  }
}

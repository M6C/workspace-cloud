/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.StringBufferInputStream;
import java.io.StringReader;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.beandata.BeanGenerique;
import framework.ressource.ftp.FTPClient;
import framework.ressource.ftp.FTPException;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;
import framework.taglib.file.bean.BeanFTP;
import framework.taglib.file.bean.BeanFTPAddress;
import framework.taglib.file.bean.BeanFile;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaValider extends SrvGenerique {

    /* (non-Javadoc)
     * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
     */
    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception{
          String application = (String)bean.getParameterDataByName("application");
          String fileEditor = (String)bean.getParameterDataByName("FileEditor");
          String fileName = (String)bean.getParameterDataByName("FileName");
          String pathToExpand = (String)bean.getParameterDataByName("pathToExpand");
          String navIndex = (String)bean.getParameterDataByName("navIndex");
          String navNbRow = (String)bean.getParameterDataByName("navNbRow");
          if (UtilString.isNotEmpty(application) &&
              UtilString.isNotEmpty(fileEditor) &&
              UtilString.isNotEmpty(fileName)) {
            Document dom = (Document)request.getSession().getAttribute("resultDom");
            String filePathMain = AdpXmlApplication.getPathMain(dom, application);
            if (filePathMain!=null && !filePathMain.equals("")) {
                if (filePathMain.toUpperCase().startsWith("FTP://")) {
                    BeanFTPAddress address = new BeanFTPAddress(filePathMain);
                    pathToExpand = (UtilString.isNotEmpty(pathToExpand) ? pathToExpand : "");
                    BeanFTP ftp = new BeanFTP(address, pathToExpand+fileName);
                    if (UtilString.isNotEmpty(navIndex) && UtilString.isNotEmpty(navNbRow)) {
                        fileEditor = replaceText(ftp.read(), fileEditor, Integer.parseInt(navIndex), Integer.parseInt(navNbRow));
                    }
                    ftp.write(fileEditor);
                    // Initialise les paramètres de la requète
                    request.setAttribute("path", filePathMain);
                }
                else {
                    String szPath = (UtilString.isNotEmpty(pathToExpand) ? new File(filePathMain, pathToExpand).getCanonicalPath() : new File(filePathMain).getCanonicalPath()); 
                    BeanFile filePathToExpand = new BeanFile(szPath);
                    BeanFile outputFile = new BeanFile(filePathToExpand, fileName);
                    if (outputFile.exists() && outputFile.isFile()) {
                      if (UtilString.isNotEmpty(navIndex) && UtilString.isNotEmpty(navNbRow)) {
                        fileEditor = replaceText(outputFile.read(), fileEditor, Integer.parseInt(navIndex), Integer.parseInt(navNbRow));
                      }
                      FileWriter out = new FileWriter(outputFile);
                      out.write(fileEditor.replace( (char) 0xA0, ' '));
                      out.close();
                    }
                    // Initialise les paramètres de la requète
                    File fileMain = new File(filePathMain);
                    request.setAttribute("path", fileMain.toURI().getPath());
                }
            }
            // Supprime les donnamp;eacute;es en session et request
/*
            request.removeAttribute("navIndex");
            request.removeAttribute("navNbRow");
            request.getSession().removeAttribute("fileReaded");
*/
          }
    }
    
    private String replaceText(String content, String text, int startIndex, int nbRow) throws IOException {
        StringBuffer ret = new StringBuffer();
        String line;
        StringReader sr = new StringReader(content);
        BufferedReader in = new BufferedReader(sr);

        if (!in.ready())
            throw new IOException();

        try {
            // Ramp;eacute;cupère le damp;eacute;but du fichier
            for (int i=1 ; i<startIndex && ((line = in.readLine()) != null); i++) {
                ret.append(line).append("\r\n");
            }
            // Ajout le nouveau text
            ret.append(text).append("\r\n");
            // Avance dans le fichier du nombre de ligne qui doit être remplacamp;eacute;
            for (int i=1 ; i<=nbRow && ((line = in.readLine()) != null); i++);
            // Lit la fin du fichier
            while ((line = in.readLine()) != null) {
                ret.append(line).append("\r\n");
            }
        } finally {
            in.close();
        }
        return ret.toString();
    }
}

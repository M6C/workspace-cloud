/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import workspace.util.UtilPath;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilBuildJar;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilRequest;
import framework.ressource.util.UtilSafe;
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
public class SrvEditorJavaSplitFile extends SrvGenerique {

   final static private int ARRAY_SIZE = 10240;

   /* (non-Javadoc)
   * @see framework.service.SrvGenerique#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    String application = (String)bean.getParameterDataByName("application");
    String pathFile = (String)bean.getParameterDataByName("pathFile");
    String pathDestination = (String)bean.getParameterDataByName("pathDestination");
    String lineNumber = (String)bean.getParameterDataByName("lineNumber");
    if (UtilString.isNotEmpty(application) &&
        UtilString.isNotEmpty(pathFile) &&
        UtilString.isNotEmpty(lineNumber)
       ) {
      try {
          Document dom = (Document)session.getAttribute("resultDom");
    	  pathFile = UtilPath.formatPath(dom, pathFile, ';');
    	  Vector fileList = new Vector();
          File fLst = new File(pathFile);
          try {
            if (fLst.exists() && fLst.isFile()) {
              File fIn = null;
              File fOut = null;
              FileInputStream fInLst = new FileInputStream(fLst);
              DataInputStream dInLst = new DataInputStream(fInLst);
              FileOutputStream fOutStream = null;
              DataOutputStream dOutStream = null;
              try {
                fOutStream = null;
                dOutStream = null;
                String text = null;
                int iLineNumber = Integer.parseInt(lineNumber);
                int line = 0, fileCount = 0;
                while ((text=dInLst.readLine())!=null) {
                	line += 1;
                    if (fOut==null || line>=iLineNumber) {
                    	if (dOutStream != null)
                    		try {dOutStream.close();} catch (IOException ex) {ex.printStackTrace();}
                    	if (fOutStream != null)
                    		try {fOutStream.close();} catch (IOException ex) {ex.printStackTrace();}
                    	String fileNameOut;
                		int idx1 = pathFile.lastIndexOf("\\");
                		int idx2 = pathFile.lastIndexOf("/");
                		int idx = (idx1>idx2) ? idx1 : idx2;
                		String sep = String.valueOf((idx1>idx2) ? '\\' : '/');
                    	if (UtilString.isNotEmpty(pathDestination)) {
                    		fileNameOut = pathDestination;
                    		if (!pathDestination.endsWith(sep))
                    			fileNameOut += sep;
                    	}
                    	else {
                    		if (idx>0)
                    			fileNameOut = pathFile.substring(0, idx+1);
                    		else
                    			fileNameOut = sep;
                    	}
                    	fileNameOut += new DecimalFormat("000000").format(fileCount);
                    	fileNameOut += pathFile.substring(pathFile.lastIndexOf(sep)+1, pathFile.length());
                    	fOut = new File(fileNameOut);
						fOutStream = new FileOutputStream(fOut);
						dOutStream = new DataOutputStream(fOutStream);
						fileList.add(fOut);
						fileCount += 1;
						line = 0;
                    }
                    text += "\r\n";
                    dOutStream.write(text.getBytes());
                    // flush buffer
                    dOutStream.flush();
                }
              }
              catch (FileNotFoundException ex) {
                ex.printStackTrace();
              }
              catch (IOException ex) {
                ex.printStackTrace();
              }
              finally {
                if (dOutStream != null)
                  try {dOutStream.close();} catch (IOException ex) {ex.printStackTrace();}
                if (fOutStream != null)
                  try {fOutStream.close();} catch (IOException ex) {ex.printStackTrace();}
                if (dInLst != null)
                  try {dInLst.close();} catch (IOException ex) {ex.printStackTrace();}
                if (fInLst != null)
                  try {fInLst.close();} catch (IOException ex) {ex.printStackTrace();}
                request.setAttribute("fileList", fileList);
              }
            }
          }
          catch (Exception ex) {
            ex.printStackTrace();
          }
      }
      catch(Exception ex){
        ex.printStackTrace();//new PrintWriter(out));
      }
    }
  }
}

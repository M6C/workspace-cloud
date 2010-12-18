/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.FileOutputStream;
import java.util.Hashtable;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import workspace.adaptateur.application.AdpXmlApplication;
import workspace.util.UtilPath;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilBuildJar;
import framework.ressource.util.UtilFile;
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
public class SrvEditorJavaPackage extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvGenerique#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    String application = (String)bean.getParameterDataByName("application");
    String login= (String)bean.getParameterDataByName("login");
    String password= (String)bean.getParameterDataByName("password");
    String pack= (String)bean.getParameterDataByName("package");
    String type= (String)bean.getParameterDataByName("type");
    if (UtilString.isNotEmpty(application) &&
        UtilString.isNotEmpty(type) &&
        UtilString.isNotEmpty(pack)) {
      try {
        // Recuperation du document xml de l'utilisateur
        Document dom = (Document) request.getSession().getAttribute("resultDom");
        // Chemin principal de l'application selectionnamp;eacute;
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
        if (filePathMain!=null && !filePathMain.equals("")) {
        	if (filePathMain.toUpperCase().startsWith("FTP://")) {
	            // @TODO FTP - Faire la création de WAR
        	}
        	else {
	        	File fileMain = new File(filePathMain);
		        // Cramp;eacute;ation du war Explosamp;eacute;
		        Document xml = AdpXmlApplication.getPackageXmlByName(context, dom, application, type, pack);
		        String exploded = UtilXML.getXPathStringValue(xml, "/PACKAGE/@Exploded");
		        String pathDst = UtilXML.getXPathStringValue(xml, "/PACKAGE/@Filename");
		        if ("true".equalsIgnoreCase(exploded)) {
		          Hashtable hash = new Hashtable();
		          hash.put(application, filePathMain);
		          Node node = null, nodeSubdirectory = null;
		          String from = null, to = null;
		          File fileFrom = null, fileTo = null;
		          File filePathMainTo = null;
		          if (!new File(pathDst).isAbsolute()) {
		            filePathMainTo = new File(filePathMain, pathDst);
		          }  else {
		            filePathMainTo = new File(pathDst);
		          }
		          //NodeList nodeList = xml.getChildNodes();
		          //NodeList nodeList = UtilXML.getNodeList(xml.getDocumentElement(), "/PACKAGE");
		          NodeList nodeList = xml.getFirstChild().getChildNodes();
		          int size = nodeList.getLength();
		          for(int i=0 ; i<size ; i++) {
		            node = nodeList.item(i);
		            if ((node.getNodeType()==Node.ELEMENT_NODE) && node.hasAttributes()) {
		              from = node.getAttributes().getNamedItem("From").getNodeValue();
		              to = node.getAttributes().getNamedItem("To").getNodeValue();
		              nodeSubdirectory = node.getAttributes().getNamedItem("Subdirectory");
		              from = UtilPath.formatPath(dom, hash, from);
		              fileFrom = new File(from);
		              if (!fileFrom.isAbsolute())
		                fileFrom = new File(filePathMain, from);
		              fileTo = new File(filePathMainTo, to);
		  
		              if (fileFrom.exists()&&fileFrom.canRead()) {
		                if (fileFrom.isFile()) {
		                  String nameFrom = fileFrom.getName();
		                  if(!to.toUpperCase().endsWith(nameFrom.toUpperCase())) {
		                    fileTo = new File(fileTo, nameFrom);
		                  }
		                  copyFile(fileFrom, fileTo);
		                }
		                else {
		                  // Recupere le contenu du repertoire
		                  boolean isSubDir = (nodeSubdirectory==null) || Boolean.getBoolean(nodeSubdirectory.getNodeValue());
		                  Vector listFile = UtilFile.dirFile(fileFrom.getCanonicalPath(), isSubDir);
		                  int maxJ = UtilVector.safeSize(listFile);
		                  for(int j=0 ; j<maxJ ; j++){
		                    File file = (File)UtilVector.safeGetElementAt(listFile, j);
		                    if ((file!=null)&&file.isFile()&&file.canRead()){
		                      String path = file.getPath().substring(fileFrom.getCanonicalPath().length()+1);
		                      File fileNew = new File(fileTo, path);
		                      try {copyFile(file, fileNew);} 
		                      catch(Exception ex) {}
		                    }
		                  }
		                }
		              }
		            }
		          }
		        }
		        else {
		          Node node = null;
		          String pathMain = fileMain.getPath();
		          StringBuffer stbSrcFrom = new StringBuffer();
		          StringBuffer stbSrcTo = new StringBuffer();
		          NodeList nodeList = xml.getFirstChild().getChildNodes();
		          int size = nodeList.getLength();
		          for(int i=0 ; i<size ; i++) {
		            node = nodeList.item(i);
		            if ((node.getNodeType()==Node.ELEMENT_NODE) && node.hasAttributes()) {
			              stbSrcFrom.append(node.getAttributes().getNamedItem("From").getNodeValue()).append(";");
			              stbSrcTo.append(node.getAttributes().getNamedItem("To").getNodeValue()).append(";");
		            }
		          }
		          String szSrcFrom = stbSrcFrom.substring(0, stbSrcFrom.length()-1);
		          String szSrcTo = stbSrcTo.substring(0, stbSrcTo.length()-1);
		          String pathSrcFrom = UtilPath.formatPath(/*request,*/ dom, application, szSrcFrom, ';');
		          String[] listPathSrcFrom = UtilString.split(pathSrcFrom, ';');
		          String[] listPathSrcTo = UtilString.split(szSrcTo, ';');
		
		          if (!new File(pathDst).isAbsolute()) {
		            pathDst = new File(filePathMain, pathDst).getCanonicalPath();
		          }  else {
		            pathDst = new File(pathDst).getCanonicalPath();
		          }
		          //UtilBuildJar.build(pathMain, listPathSrc, pathDst);
		          UtilBuildJar.build(listPathSrcFrom, listPathSrcTo, pathDst);
		        }
        	}
        }
      } catch(Exception ex){
        ex.printStackTrace();
      }
    }
  }
  private void copyFile(File in, File out) throws Exception {
    out.getParentFile().mkdirs();
    FileInputStream fis  = new FileInputStream(in);
    FileOutputStream fos = new FileOutputStream(out);
    byte[] buf = new byte[1024];
    int i = 0;
    while((i=fis.read(buf))!=-1) {
      fos.write(buf, 0, i);
    }
    fis.close();
    fos.close();
  }
}
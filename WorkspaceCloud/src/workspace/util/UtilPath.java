package workspace.util;

import java.io.File;
import java.io.IOException;
import java.util.Hashtable;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.ressource.util.UtilSafe;
import framework.ressource.util.UtilString;
import framework.taglib.file.bean.BeanFTP;
import framework.taglib.file.bean.BeanFTPAddress;
import framework.trace.Trace;

public class UtilPath {
	
	  public static String formatPath(Document dom, String pathSrc) throws IOException {
	    return formatPath(dom, null, new Hashtable(), pathSrc, ';');
	  }
	
	  public static String formatPath(Document dom, String pathSrc, char separator) throws IOException {
	    return formatPath(dom, null, new Hashtable(), pathSrc, separator);
	  }
	
	  public static String formatPath(Document dom, Hashtable hash, String pathSrc) throws IOException {
	    return formatPath(dom, null, hash, pathSrc, ';');
	  }
	
	  public static String formatPath(Document dom, Hashtable hash, String pathSrc, char separator) throws IOException {
		  return formatPath(dom, null, hash, pathSrc, separator);
	  }

	  public static String formatPath(Document dom, String application, String pathSrc) throws IOException {
	    return formatPath(dom, application, new Hashtable(), pathSrc, ';');
	  }
	
	  public static String formatPath(Document dom, String application, String pathSrc, char separator) throws IOException {
	    return formatPath(dom, application, new Hashtable(), pathSrc, separator);
	  }
	
	  public static String formatPath(Document dom, String application, Hashtable hash, String pathSrc) throws IOException {
	    return formatPath(dom, application, hash, pathSrc, ';');
	  }
	
	  public static String formatPath(Document dom, String application, Hashtable hash, String pathSrc, char separator) throws IOException {
		String ret = null;
		try {
			String[] listPathSrc = UtilString.split(pathSrc, separator);
			int len = UtilSafe.safeListSize(listPathSrc);
			if (len>0) {
			  File filePath = null;
			  String path = null;
			  int iDeb = 0, iFin = 0, iPos = 0;
			  StringBuffer stb = new StringBuffer();
			  for(int i=0 ; i<len ; i++) {
			    path = (String)UtilSafe.safeListGetElementAt(listPathSrc, i);
			    iPos = 0;
			    while(iPos>=0) {
			      iDeb = path.indexOf('[', iPos);
			      iFin = path.indexOf(']', iDeb);
			      if (iDeb>=0 && iFin>=0) {
			       String szApplication = path.substring(iDeb+1, iFin);
			       filePath = (File)hash.get(szApplication);
			 	   String filePathMain = AdpXmlApplication.getPathMain(dom, szApplication);
			       if (filePath==null) {
			            if (filePathMain!=null && !filePathMain.equals("")) {
			            	if (filePathMain.toUpperCase().startsWith("FTP://")) {
					            // @TODO FTP - Faire le formatage du chemin
			            		filePath = new BeanFTP(new BeanFTPAddress(filePathMain));
			            	}
			            	else {
			                	filePath = new File(filePathMain);
			            	}
				            hash.put(szApplication, filePath);
			            }
			        }
			    	if (!filePathMain.toUpperCase().startsWith("FTP://")) {
			            path = new StringBuffer(path).replace(iDeb, iFin+1, (filePath!=null) ? filePath.getCanonicalPath() : "").toString();
			        	path = path.replace( ((File.separatorChar == '\\') ? '/' : '\\'), File.separatorChar);
			        	path = new File(path).getCanonicalPath();
			        }
			    	else {
			    		path = filePath.getCanonicalPath();
			    	}
			      }
		          else if (UtilString.isNotEmpty(application) && (!new File(path).isAbsolute())) {
		    		// Chemin principal de l'application selectionnamp;eacute;
		      		String filePathApp = AdpXmlApplication.getPathMain(dom, application);
		            path = new File(filePathApp, path).getCanonicalPath();
		          }
			      iPos = iFin;
			    }
			
			    if (stb.length()>0)
			      stb.append(";");
			
			        stb.append(path);
			      }
			      ret = stb.toString();
			    }
			} catch(Exception ex) {
				Trace.ERROR(ex);
			}
		    return ret;
		  }
}
/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service.versioning;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilEncoder;
import framework.service.SrvGenerique;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import javax.naming.NoInitialContextException;
import javax.servlet.http.HttpServletRequest;
import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.CommandAbortedException;
import org.netbeans.lib.cvsclient.connection.AuthenticationException;
import org.netbeans.lib.cvsclient.connection.PServerConnection;
import workspace.bean.versioning.BeanCVS;

/**
 * @author  rocada  Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :  Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvCVS extends SrvGenerique {

  protected BeanCVS beanCVS = null;

  protected StringBuffer traceBuffer = new StringBuffer();

  public SrvCVS() {
  }

  protected void init(HttpServletRequest request, BeanGenerique bean) throws IOException, IllegalArgumentException, NoInitialContextException {
    beanCVS = new BeanCVS(request, bean);
  }

  protected ArrayList excludeCVSDirectory(Iterator vFile) {
    return beanCVS.excludeCVSDirectory(vFile);
  }

  protected ArrayList excludeFile(Iterator vFile) {
    return beanCVS.excludeFile(vFile);
  }

  /**
   * Initialisation dans la requette de l'utilisateur la trace de l'exception, par le paramètre 'jcvsErrorMessage'.
   * @param request Requette de l'utilisateur
   * @param ex Exception qui contient la trace
   */
  protected void traceBuffer(HttpServletRequest request) {
    try {
      request.setAttribute("jcvsErrorMessage", UtilEncoder.encodeHTML(traceBuffer.toString()));
    }
    catch (Exception ex) {
      traceException(request, ex);
    }
  }

  /**
   * Initialisation dans la requette de l'utilisateur la trace de l'exception, par le paramètre 'jcvsErrorMessage'.
   * @param request Requette de l'utilisateur
   * @param trace Trace de l'utilisateur
   * @param ex Exception qui contient la trace
   */
  protected void traceBuffer(HttpServletRequest request, String trace) {
    try {
      request.setAttribute("jcvsErrorMessage", UtilEncoder.encodeHTML(trace));
    }
    catch (Exception ex) {
      traceException(request, ex);
    }
  }

  /**
   * Initialisation dans la requette de l'utilisateur la trace de l'exception, par le paramètre 'jcvsErrorMessage'.
   * @param request Requette de l'utilisateur
   * @param ex Exception qui contient la trace
   */
  protected void traceException(HttpServletRequest request, Exception ex) {
    try {
      traceExceptionInBuffer(request, ex);
      request.setAttribute("jcvsErrorMessage", "ERROR:" + UtilEncoder.encodeHTML(traceBuffer.toString()));
    }
    catch (Exception ex1) {}
  }

  /**
   * Initialisation dans l'attribut 'traceBuffer' la trace de l'exception, par le paramètre 'jcvsErrorMessage'.
   * @param request Requette de l'utilisateur
   * @param ex Exception qui contient la trace
   */
  protected void traceExceptionInBuffer(HttpServletRequest request, Exception ex) {
    try {
      java.io.StringWriter strW = new java.io.StringWriter();
      ex.printStackTrace(new java.io.PrintWriter(strW));
      traceBuffer.append("\r\n").append("ERROR:").append(strW.toString()).append("\r\n");
    }
    catch (Exception ex1) {}
  }

  /**
   * Log la trace de l'exception.
   * @param file Fichier dans lequel la trace va être inscrite
   * @param ex Exception qui contient la trace
   */
  protected void traceException(File file, Exception ex) {
    try {
      java.io.StringWriter strW = new java.io.StringWriter();
      java.io.FileWriter fileW = new java.io.FileWriter(file);
      ex.printStackTrace(new java.io.PrintWriter(strW));
      fileW.write(strW.toString());
      fileW.flush();
      fileW.close();
    }
    catch (Exception ex1) {}
  }

  protected PServerConnection newPServerConnection() throws CommandAbortedException, AuthenticationException {
    return beanCVS.newPServerConnection();
  }

  protected Client newClient() throws AuthenticationException, CommandAbortedException {
    return beanCVS.newClient();
  }

  protected Client newClient(PServerConnection c) {
    return beanCVS.newClient(c);
  }

  public String getApplication() {
    return beanCVS.getApplication();
  }

  public String getEncodedPassword() {
    return beanCVS.getEncodedPassword();
  }

  public String getPort() {
    return beanCVS.getPort();
  }

  public String getRepository() {
    return beanCVS.getRepository();
  }

  /**
 * @return  the traceBuffer
 * @uml.property  name="traceBuffer"
 */
public StringBuffer getTraceBuffer() {
    return beanCVS.getTraceBuffer();
  }

  public String getHostname() {
    return beanCVS.getHostname();
  }

  public String getLocalDirectory() {
    return beanCVS.getLocalDirectory();
  }

  public String getRootDirectory() {
    return beanCVS.getRootDirectory();
  }

  public File getFilePathMain() {
    return beanCVS.getFilePathMain();
  }

  public String getUserName() {
    return beanCVS.getUserName();
  }

  public String getPassword() {
    return beanCVS.getPassword();
  }
}

/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.bean.versioning;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Vector;
import javax.naming.NoInitialContextException;
import javax.servlet.http.HttpServletRequest;
import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.admin.StandardAdminHandler;
import org.netbeans.lib.cvsclient.command.CommandAbortedException;
import org.netbeans.lib.cvsclient.command.CommandException;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.status.StatusCommand;
import org.netbeans.lib.cvsclient.command.status.StatusInformation;
import org.netbeans.lib.cvsclient.connection.AuthenticationException;
import org.netbeans.lib.cvsclient.connection.PServerConnection;
import org.netbeans.lib.cvsclient.connection.StandardScrambler;
import org.netbeans.lib.cvsclient.event.CVSListener;
import org.netbeans.lib.cvsclient.event.FileAddedEvent;
import org.netbeans.lib.cvsclient.event.FileInfoEvent;
import org.netbeans.lib.cvsclient.event.FileRemovedEvent;
import org.netbeans.lib.cvsclient.event.FileUpdatedEvent;
import org.netbeans.lib.cvsclient.event.MessageEvent;
import org.netbeans.lib.cvsclient.event.ModuleExpansionEvent;
import org.netbeans.lib.cvsclient.event.TerminationEvent;
import org.w3c.dom.Document;
import workspace.adaptateur.application.AdpXmlApplication;

/**
 * @author  rocada  Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :  Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class BeanCVS extends SrvGenerique implements CVSListener {

  protected String application = null;
  protected String userName = null; //CVS_USER_ADMIN_LOGIN;
  protected String password = null; //CVS_USER_ADMIN_PASSW;
  protected String hostname = null; //CVS_SERVER_HOSTNAME;
  protected String port = null; //"2401";
  protected String repository = null; //"Projet01";
  protected String rootDirectory = null; //"/CVS";
  protected String localDirectory = null; //"E:/TEMP/Projet01";
  protected String encodedPassword = null;
  protected File filePathMain = null;

  protected StringBuffer traceBuffer = new StringBuffer();

  protected StatusInformation[] statusInformation = null;

  public BeanCVS(Document dom, String application) throws IOException, IllegalArgumentException, NoInitialContextException {
    if (dom==null)
      throw new IllegalArgumentException("Argument dom (org.w3c.dom.Document) is null");

    this.application = application;
    if (application==null)
      throw new IllegalArgumentException("Argument application (java.lang.String) is null");

    String pathMain = AdpXmlApplication.getPathMain(dom, application);
    if (pathMain==null)
      throw new IllegalArgumentException("No main path define for application :" + application);
    
    filePathMain = new File(pathMain);

    localDirectory = AdpXmlApplication.getLocalDirectory(dom, application);
    repository = AdpXmlApplication.getModuleName(dom, application);
    password = AdpXmlApplication.getPassword(dom, application);
    hostname = AdpXmlApplication.getServerHostName(dom, application);
    port = AdpXmlApplication.getServerPort(dom, application);
    rootDirectory = AdpXmlApplication.getServerRepository(dom, application);
    userName = AdpXmlApplication.getUserName(dom, application);
    if ((localDirectory==null) ||
    	(repository==null) ||
    	(password==null) ||
    	(hostname==null) ||
    	(port==null) ||
    	(rootDirectory==null) ||
    	(userName==null)
    	) {
        throw new NoInitialContextException("No local Directory define for application :" + application);
    }

    localDirectory = new File(localDirectory).getCanonicalPath();
    encodedPassword = StandardScrambler.getInstance().scramble(password);

    /**
     *      WARNING TO DEVELOPERS:
     *      Please be warned that attempting to reuse one open connection for more commands is not supported by cvs servers very well.
     *      You are advised to open a new Connection each time.
     *      If you still want to proceed, please do: System.setProperty("javacvs.multiple_commands_warning", "false")
     *      That will disable this message.
     */
    System.setProperty("javacvs.multiple_commands_warning", "false");
  }

  public BeanCVS(HttpServletRequest request, BeanGenerique bean) throws IOException, IllegalArgumentException, NoInitialContextException {
    Document dom = (Document)request.getSession().getAttribute("resultDom");
    if (dom==null)
      throw new IllegalArgumentException("Argument dom (org.w3c.dom.Document) is null");

    application = (String)bean.getParameterDataByName("application");
    if (application==null)
      throw new IllegalArgumentException("Argument application (java.lang.String) is null");

    String pathMain = AdpXmlApplication.getPathMain(dom, application);
    if (pathMain==null)
      throw new IllegalArgumentException("No main path define for application :" + application);

    filePathMain = new File(pathMain);

    localDirectory = (String)bean.get("localDirectory");
    if (localDirectory==null) {
      localDirectory = AdpXmlApplication.getLocalDirectory(dom, application);
   	  localDirectory = (localDirectory==null) ? null : new File(localDirectory).getCanonicalPath();
    }
    else {
      localDirectory = new File(filePathMain, localDirectory).getCanonicalPath();
    }
    repository = (String)bean.get("repository");
    if (repository==null)
      repository = AdpXmlApplication.getModuleName(dom, application);
    password = (String)bean.get("password");
    if (password==null)
      password = AdpXmlApplication.getPassword(dom, application);
    hostname = (String)bean.get("hostname");
    if (hostname==null)
      hostname = AdpXmlApplication.getServerHostName(dom, application);
    port = (String) bean.get("port");
    if (port==null)
      port = AdpXmlApplication.getServerPort(dom, application);
    rootDirectory = (String)bean.get("rootDirectory");
    if (rootDirectory==null)
      rootDirectory = AdpXmlApplication.getServerRepository(dom, application);
    userName = (String)bean.get("userName");
    if (userName==null)
      userName = AdpXmlApplication.getUserName(dom, application);

    if ((localDirectory==null) ||
        	(repository==null) ||
        	(password==null) ||
        	(hostname==null) ||
        	(port==null) ||
        	(rootDirectory==null) ||
        	(userName==null)
        	) {
            throw new NoInitialContextException("No local Directory define for application :" + application);
        }
    encodedPassword = StandardScrambler.getInstance().scramble(password);

    /**
     *      WARNING TO DEVELOPERS:
     *      Please be warned that attempting to reuse one open connection for more commands is not supported by cvs servers very well.
     *      You are advised to open a new Connection each time.
     *      If you still want to proceed, please do: System.setProperty("javacvs.multiple_commands_warning", "false")
     *      That will disable this message.
     */
    System.setProperty("javacvs.multiple_commands_warning", "false");
  }

  public PServerConnection newPServerConnection() throws CommandAbortedException, AuthenticationException {
    PServerConnection c = new PServerConnection();
    c.setUserName(userName);
    c.setEncodedPassword(encodedPassword);
    c.setHostName(hostname);
    c.setPort(Integer.parseInt(port));
    c.setRepository(rootDirectory);
    c.open();
    return c;
  }

  public Client newClient() throws AuthenticationException, CommandAbortedException {
    Client client = new Client(newPServerConnection(), new StandardAdminHandler());
    client.getEventManager().addCVSListener(this);
    client.setLocalPath(localDirectory);
    return client;
  }

  public Client newClient(PServerConnection c) {
    Client client = new Client(c, new StandardAdminHandler());
    client.getEventManager().addCVSListener(this);
    client.setLocalPath(localDirectory);
    return client;
  }

  /**
   * Called when the server wants to send a message to be displayed to
   * the user. The message is only for information purposes and clients
   * can choose to ignore these messages if they wish.
   * @param e the event
   */
  public void messageSent(MessageEvent e) {
    String line = e.getMessage();
    if (e.isTagged()) {
      String message = e.parseTaggedMessage(traceBuffer, "newline");
      // if we get back a non-null line, we have something
      // to output. Otherwise, there is more to come and we
      // should do nothing yet.
      if ((message != null)&&(!message.trim().equals("")))
        traceBuffer.append(message).append("\r\n");
    }
    else if ((line != null)&&(!line.trim().equals("")))
      traceBuffer.append(line).append("\r\n");
  }

  public StatusInformation[] executeStatusInformation(String fileName) throws CommandAbortedException, AuthenticationException, AuthenticationException, CommandException, IOException, CommandException, AuthenticationException, CommandAbortedException {
    return executeStatusInformation(fileName, false);
  }

  public StatusInformation[] executeStatusInformation(String fileName, boolean isRecursive) throws CommandAbortedException, AuthenticationException, AuthenticationException, CommandException, IOException {
    return executeStatusInformation(fileName, isRecursive, true);
  }

  public StatusInformation[] executeStatusInformation(String fileName, boolean isRecursive, boolean withFileContent) throws CommandAbortedException, AuthenticationException, AuthenticationException, CommandException, IOException {
    File[] lFile = null;
    File file = null;
    if (UtilString.isNotEmpty(fileName))
      file = new File(new File(getLocalDirectory(), getRepository()), fileName);
    else
      file = new File(getLocalDirectory(), getRepository());

    if (file.isFile() || !isRecursive) {
      lFile = new File[]{file};
    }
    else {
      Vector vFile = UtilFile.dirFile(file.getCanonicalPath(), isRecursive, (FilenameFilter)null, false, false, withFileContent);
      ArrayList aFile = excludeCVSDirectory(vFile.iterator());
      lFile = new File[aFile.size()];
      aFile.toArray(lFile);
      UtilFile.sortByPathDepthAscendant(lFile);
    }

    return executeStatusInformation(lFile);
  }

  public StatusInformation[] executeStatusInformation(File[] lFile) throws CommandAbortedException, AuthenticationException, AuthenticationException, CommandException, IOException {
    Client client = newClient();

    StatusCommand command = new StatusCommand();
    command.setBuilder(command.createBuilder(client.getEventManager()));
    command.setFiles(lFile);

    GlobalOptions globalOptions = new GlobalOptions();
    globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());
    client.executeCommand(command, globalOptions);

    return statusInformation;
  }

  public ArrayList excludeCVSDirectory(Iterator vFile) {
    File file = null;
    ArrayList array = new ArrayList();
    /**
     * Exclusion des repertoires CVS
     */
    while(vFile.hasNext()) {
      file = (File)vFile.next();
      if (file.isFile()) {
        if (!((file.getParentFile()!=null) &&
              UtilString.isEqualsIgnoreCase(file.getParentFile().getName(), "CVS") &&
              (UtilString.isEqualsIgnoreCase(file.getName(), "Entries") ||
               UtilString.isEqualsIgnoreCase(file.getName(), "Repository") ||
               UtilString.isEqualsIgnoreCase(file.getName(), "Root"))))
          array.add(file);
      }
      else if (UtilString.isNotEqualsIgnoreCase(file.getName(), "CVS")) {
            array.add(file);
      }
    }
    array.trimToSize();
    return array;
  }

  public ArrayList excludeFile(Iterator vFile) {
    File file = null;
    ArrayList array = new ArrayList();
    /**
     * Exclusion des repertoires CVS
     */
    while(vFile.hasNext()) {
      file = (File)vFile.next();
      if (file.isDirectory())
          array.add(file);
    }
    array.trimToSize();
    return array;
  }

  /**
   * Called when a file has been added.
   * @param e the event
   */
  public void fileAdded(FileAddedEvent e) {}


  /**
   * Called when a file is removed.
   * @param e the event
   */
  public void fileRemoved(FileRemovedEvent e) {}


  /**
   * Called when a file has been updated
   * @param e the event
   */
  public void fileUpdated(FileUpdatedEvent e) {}


  /**
   * Called when file information has been received
   */
  public void fileInfoGenerated(FileInfoEvent e) {
    if (statusInformation==null) {
      statusInformation = new StatusInformation[]{(StatusInformation) e.getInfoContainer()};
    }
    else {
      int size = statusInformation.length;
      StatusInformation[] listStatus = new StatusInformation[size+1];
      System.arraycopy(statusInformation, 0, listStatus, 0, size);
      listStatus[size] = (StatusInformation) e.getInfoContainer();
      statusInformation = listStatus;
    }
  }

  /**
   * Recherche dans les fichiers ".cvsignore" si le fichier ou repertoire doit être ignoré
   * @param f File File à tester
   * @throws FileNotFoundException
   * @throws IOException
   * @return boolean true si le fichier ou un des repertoires de l'arborescence est trouvé dans un fichier ".cvsignore"
   */
  public static boolean isIgnored(File f) throws FileNotFoundException, IOException {
    File fileIgnore = null;
    File tmpF = f;
    File parent = tmpF.getParentFile();
    String name = tmpF.getName();
    boolean ret = false;
    while ( (parent != null) && !ret) {
      fileIgnore = new File(parent, ".cvsignore");
      ret = fileIgnore.exists() && (UtilFile.findLine(fileIgnore, name) >= 0);
      name = parent.getName();
      tmpF = parent;
      parent = parent.getParentFile();
    }
    return ret;
  }


  /**
   * called when server responses with "ok" or "error", (when the command
   * finishes)
   */
  public void commandTerminated(TerminationEvent e) {}


  /**
   * Fire a module expansion event. This is called when the servers
   * has responded to an expand-modules request.
   */
  public void moduleExpanded(ModuleExpansionEvent e) {}

  /**
 * @return  the application
 * @uml.property  name="application"
 */
public String getApplication() {
    return application;
  }

  /**
 * @return  the encodedPassword
 * @uml.property  name="encodedPassword"
 */
public String getEncodedPassword() {
    return encodedPassword;
  }

  /**
 * @return  the port
 * @uml.property  name="port"
 */
public String getPort() {
    return port;
  }

  /**
 * @return  the repository
 * @uml.property  name="repository"
 */
public String getRepository() {
    return repository;
  }

  /**
 * @return  the traceBuffer
 * @uml.property  name="traceBuffer"
 */
public StringBuffer getTraceBuffer() {
    return traceBuffer;
  }

  /**
 * @return  the hostname
 * @uml.property  name="hostname"
 */
public String getHostname() {
    return hostname;
  }

  /**
 * @return  the localDirectory
 * @uml.property  name="localDirectory"
 */
public String getLocalDirectory() {
    return localDirectory;
  }

  /**
 * @return  the rootDirectory
 * @uml.property  name="rootDirectory"
 */
public String getRootDirectory() {
    return rootDirectory;
  }

  /**
 * @return  the filePathMain
 * @uml.property  name="filePathMain"
 */
public File getFilePathMain() {
    return filePathMain;
  }

  /**
 * @return  the userName
 * @uml.property  name="userName"
 */
public String getUserName() {
    return userName;
  }

  /**
 * @param password  the password to set
 * @uml.property  name="password"
 */
public void setPassword(String password) {
    this.password = password;
  }

  /**
 * @param application  the application to set
 * @uml.property  name="application"
 */
public void setApplication(String application) {
    this.application = application;
  }

  /**
 * @param encodedPassword  the encodedPassword to set
 * @uml.property  name="encodedPassword"
 */
public void setEncodedPassword(String encodedPassword) {
    this.encodedPassword = encodedPassword;
  }

  /**
 * @param port  the port to set
 * @uml.property  name="port"
 */
public void setPort(String port) {
    this.port = port;
  }

  /**
 * @param repository  the repository to set
 * @uml.property  name="repository"
 */
public void setRepository(String repository) {
    this.repository = repository;
  }

  /**
 * @param traceBuffer  the traceBuffer to set
 * @uml.property  name="traceBuffer"
 */
public void setTraceBuffer(StringBuffer traceBuffer) {
    this.traceBuffer = traceBuffer;
  }

  /**
 * @param hostname  the hostname to set
 * @uml.property  name="hostname"
 */
public void setHostname(String hostname) {
    this.hostname = hostname;
  }

  /**
 * @param localDirectory  the localDirectory to set
 * @uml.property  name="localDirectory"
 */
public void setLocalDirectory(String localDirectory) {
    this.localDirectory = localDirectory;
  }

  /**
 * @param rootDirectory  the rootDirectory to set
 * @uml.property  name="rootDirectory"
 */
public void setRootDirectory(String rootDirectory) {
    this.rootDirectory = rootDirectory;
  }

  /**
 * @param filePathMain  the filePathMain to set
 * @uml.property  name="filePathMain"
 */
public void setFilePathMain(File filePathMain) {
    this.filePathMain = filePathMain;
  }

  /**
 * @param userName  the userName to set
 * @uml.property  name="userName"
 */
public void setUserName(String userName) {
    this.userName = userName;
  }

  /**
 * @return  the password
 * @uml.property  name="password"
 */
public String getPassword() {
    return password;
  }
}

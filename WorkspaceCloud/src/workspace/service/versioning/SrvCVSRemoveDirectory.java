package workspace.service.versioning;

/**
 *           OK
 */

import java.io.File;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.remove.RemoveCommand;
import org.netbeans.lib.cvsclient.command.update.UpdateCommand;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilString;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvCVSRemoveDirectory extends SrvCVS {

  /**
   * (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest req, HttpServletResponse res, BeanGenerique bean) throws Exception {
    try {
      String fileName = (String) bean.get("fileName"); //"aMessage";
      String recursive = (String) bean.get("recursive"); //"true";
      String autoupdate = (String) bean.get("autoupdate"); //"true";
      String deletefirt = (String) bean.get("deletefirst"); //"true";
      boolean isRecursive = ("true".equalsIgnoreCase(recursive));
      boolean isAutoupdate = ("true".equalsIgnoreCase(autoupdate));
      boolean isDeletefirt = ("true".equalsIgnoreCase(deletefirt));

      init(req, bean);

      Client client = newClient();

      RemoveCommand command = new RemoveCommand();
      command.setDeleteBeforeRemove(isDeletefirt);
      command.setIgnoreLocallyExistingFiles(true);
      command.setBuilder(null);

      File file = null;
      if (UtilString.isNotEmpty(fileName))
        file = new File(new File(getLocalDirectory(), getRepository()), fileName);
      else
        file = new File(getLocalDirectory(), getRepository());
      Vector vFile = UtilFile.dirFile(file.getCanonicalPath(), isRecursive, null, false, true);

      ArrayList aFile = excludeCVSDirectory(vFile.iterator());
      File[] lFile = new File[aFile.size()];
      aFile.toArray(lFile);
      UtilFile.sortByPathDepth(lFile);
      GlobalOptions globalOptions = new GlobalOptions();
      globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());

      command.setFiles(lFile);
      client.executeCommand(command, globalOptions);

      if (isAutoupdate) {
        UpdateCommand updateCommand = new UpdateCommand();
        updateCommand.setPruneDirectories(true);
        updateCommand.setBuilder(null);
        updateCommand.setFiles(lFile);
        client.executeCommand(updateCommand, globalOptions);
      }
    }
    finally {
      traceBuffer(req);
    }
  }
}

package workspace.service.versioning;

/**
 *           OK
 */

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.commit.CommitCommand;
import org.netbeans.lib.cvsclient.command.remove.RemoveCommand;
import org.netbeans.lib.cvsclient.command.update.UpdateCommand;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvCVSRemoveFile extends SrvCVS {

  /**
   * (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest req, HttpServletResponse res, BeanGenerique bean) throws Exception {
    try {
      String fileName = (String) bean.get("fileName"); //"aMessage";
      String autocommit = (String) bean.get("autocommit"); //"true";
      String autoupdate = (String) bean.get("autoupdate"); //"true";
      String deletefirt = (String) bean.get("deletefirst"); //"true";
      boolean isAutocommit = ("true".equalsIgnoreCase(autocommit));
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
      File[] lFile = new File[] {file};
      command.setFiles(lFile);

      GlobalOptions globalOptions = new GlobalOptions();
      globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());
      client.executeCommand(command, globalOptions);

      if (isAutocommit) {
        CommitCommand commandCommit = new CommitCommand();
        commandCommit.setBuilder(null);
        commandCommit.setFiles(lFile);
        client.executeCommand(commandCommit, globalOptions);
      }
      if (isAutoupdate) {
        UpdateCommand updateCommand = new UpdateCommand();
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

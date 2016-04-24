package workspace.service.versioning;

/**
 *           OK
 */

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.add.AddCommand;
import org.netbeans.lib.cvsclient.command.commit.CommitCommand;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvCVSAddFile extends SrvCVS {

  /**
   * (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest req, HttpServletResponse res, BeanGenerique bean) throws Exception {
    try {
      String messageStr = (String) bean.get("messageStr"); //"aMessage";
      String fileName = (String) bean.get("fileName"); //"aMessage";
      String autocommit = (String) bean.get("autocommit"); //"true";
      boolean isAutocommit = ("true".equalsIgnoreCase(autocommit));

      init(req, bean);

      Client client = newClient();

      AddCommand command = new AddCommand();
      command.setBuilder(null);

      File file = null;
      if (UtilString.isNotEmpty(fileName))
        file = new File(new File(getLocalDirectory(), getRepository()), fileName);
      else
        file = new File(getLocalDirectory(), getRepository());
      File[] lFile = new File[] {file};
      command.setFiles(lFile);
      command.setMessage(messageStr);

      GlobalOptions globalOptions = new GlobalOptions();
      globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());
      client.executeCommand(command, globalOptions);

      if (isAutocommit) {
        CommitCommand commandCommit = new CommitCommand();
        commandCommit.setBuilder(null);

        commandCommit.setFiles(lFile);
        commandCommit.setMessage(messageStr);

        client.executeCommand(commandCommit, globalOptions);
      }
    }
    finally {
      traceBuffer(req);
    }
  }
}

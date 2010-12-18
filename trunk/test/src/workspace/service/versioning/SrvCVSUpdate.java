package workspace.service.versioning;

/**
 *           OK
 */

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.update.UpdateCommand;

import framework.beandata.BeanGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvCVSUpdate extends SrvCVS {

  /**
   * (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest req, HttpServletResponse res, BeanGenerique bean) throws Exception {
    try {
      String recursive = (String)bean.get("recursive"); //"true";
      boolean isRecursive = ("true".equalsIgnoreCase(recursive));

      init(req, bean);

      // Create a client
      Client client = newClient();

      UpdateCommand command = new UpdateCommand();
      command.setBuilder(null);
      command.setFiles(new File[]{new File(getLocalDirectory(), getRepository())});

      command.setRecursive(isRecursive);
      command.setBuildDirectories(true);
      command.setPruneDirectories(true);

      GlobalOptions globalOptions = new GlobalOptions();
//      globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());
      globalOptions.setCVSRoot(getRootDirectory());
      client.executeCommand(command, globalOptions);
    }
    finally {
      traceBuffer(req);
    }
  }
}

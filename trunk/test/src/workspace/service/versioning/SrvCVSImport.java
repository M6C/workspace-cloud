package workspace.service.versioning;

/**
 *           OK
 */

import java.io.File;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.importcmd.ImportCommand;
import org.netbeans.lib.cvsclient.command.update.UpdateCommand;

import framework.beandata.BeanGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvCVSImport extends SrvCVS {

  /**
   * (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest req, HttpServletResponse res, BeanGenerique bean) throws Exception {
    try {
      String vendorTag  = (String) bean.get("vendorTag"); //"aVendor";
      String releaseTag = (String) bean.get("releaseTag"); //"aRelease";
      String messageStr = (String) bean.get("messageStr"); //"aMessage";
      String autoupdate = (String) bean.get("autoupdate"); //"true";
      boolean isAutoupdate = ("true".equalsIgnoreCase(autoupdate));

      init(req, bean);

      Client client = newClient();
      client.setLocalPath(new File(getLocalDirectory(), getRepository()).getCanonicalPath());

      ImportCommand command = new ImportCommand();
      command.setBuilder(null);

      command.setLogMessage(messageStr);
      command.setModule(getRepository());
      command.setReleaseTag(releaseTag);
      command.setVendorTag(vendorTag);

      GlobalOptions globalOptions = new GlobalOptions();
      client.executeCommand(command, globalOptions);
      if (isAutoupdate) {
        UpdateCommand updateCommand = new UpdateCommand();
        updateCommand.setBuilder(null);
        updateCommand.setFiles(new File[]{new File(getLocalDirectory(), getRepository())});
        updateCommand.setRecursive(true);
        updateCommand.setBuildDirectories(true);
        updateCommand.setPruneDirectories(true);
        globalOptions.setCVSRoot(getRootDirectory());
        client.setLocalPath(getLocalDirectory());
//        globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());
        client.executeCommand(updateCommand, globalOptions);
      }
    }
    finally {
      traceBuffer(req);
    }
  }
}

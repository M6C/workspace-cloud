/*
 * Créé le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.netbeans.lib.cvsclient.Client;
import org.netbeans.lib.cvsclient.command.GlobalOptions;
import org.netbeans.lib.cvsclient.command.add.AddCommand;
import org.netbeans.lib.cvsclient.command.commit.CommitCommand;
import org.netbeans.lib.cvsclient.command.remove.RemoveCommand;
import org.netbeans.lib.cvsclient.command.update.UpdateCommand;

import workspace.service.versioning.SrvCVS;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilVector;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
public class SrvVersionningPageSubmit extends SrvCVS {

/* (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest req, HttpServletResponse res, BeanGenerique bean) throws Exception{
    String application = (String)bean.getParameterDataByName("application");
    String pathToExpand = (String)bean.getParameterDataByName("pathToExpand");
    String messageStr = (String)bean.getParameterDataByName("messageStr");
    ArrayList listFileName = (ArrayList)bean.getParameterDataByName("fileName");
    ArrayList listVerAction = (ArrayList)bean.getParameterDataByName("verAction");

    init(req, bean);

    // Initialise les paramètres de la requète
    req.setAttribute("path", getFilePathMain().toURI().getPath());

    try {
      if (UtilString.isNotEmpty(application) && UtilVector.safeNotEmpty(listFileName) &&
          UtilVector.safeNotEmpty(listVerAction)) {
        ArrayList listAdd = new ArrayList();
        ArrayList listRemove = new ArrayList();
        ArrayList listUpdate = new ArrayList();
        ArrayList listCommit = new ArrayList();
        String action = null;
        for(int i=0 ; i<listVerAction.size() ; i++) {
          action = (String)listVerAction.get(i);
          if (UtilString.isEqualsIgnoreCase(action, "Add"))
            listAdd.add(listFileName.get(i));
          else if (UtilString.isEqualsIgnoreCase(action, "Remove"))
            listRemove.add(listFileName.get(i));
          else if (UtilString.isEqualsIgnoreCase(action, "Update"))
            listUpdate.add(listFileName.get(i));
          else if (UtilString.isEqualsIgnoreCase(action, "Commit"))
            listCommit.add(listFileName.get(i));
        }
        listAdd.trimToSize();
        listRemove.trimToSize();
        listUpdate.trimToSize();

        Client client = newClient();

        GlobalOptions globalOptions = new GlobalOptions();
        globalOptions.setCVSRoot(getRootDirectory() + "/" + getRepository());

        File root = UtilString.isEmpty(pathToExpand) ? getFilePathMain() : new File(getFilePathMain(), pathToExpand);

        if (UtilVector.safeSize(listAdd)>0) {
          boolean executeCommand = false;
          /**
           * ADD
           */
          if (UtilString.isNotEmpty(pathToExpand)) {
            File dirCvsEntries = new File(root, "/CVS/Entries");
            if (dirCvsEntries.exists() && dirCvsEntries.isFile()) {
              executeCommand = true;
            }
            else {
              File parentCvsEntries = new File(root.getParentFile(), "/CVS/Entries");
              if (parentCvsEntries.exists() && parentCvsEntries.isFile()) {
                listAdd.add(0, root.getName());
                executeCommand = true;
              }
              else {
                getTraceBuffer().append("Can't add '").append(pathToExpand).append("' files because :");
                getTraceBuffer().append("No '/CVS/Entries' file found\r\n");
              }
            }
          }
          if (executeCommand) {
            File[] lFile = toFileArray(listAdd, root);
            AddCommand command = new AddCommand();
            command.setBuilder(null);
            command.setFiles(lFile);
            command.setMessage(messageStr);
            client.executeCommand(command, globalOptions);
            listCommit.addAll(listAdd);
          }
        }
        if (UtilVector.safeSize(listRemove)>0) {
          /**
           * REMOVE
           */
          File[] lFile = toFileArray(listRemove, root);
          RemoveCommand command = new RemoveCommand();
          command.setBuilder(null);
          command.setFiles(lFile);
          client.executeCommand(command, globalOptions);
          listCommit.addAll(listRemove);
        }
        if (UtilVector.safeSize(listUpdate)>0) {
          /**
           * UPDATE
           */
          File[] lFile = toFileArray(listUpdate, root);
          UpdateCommand command = new UpdateCommand();
          command.setBuilder(null);
          command.setFiles(lFile);
          client.executeCommand(command, globalOptions);
          listCommit.addAll(listUpdate);
        }

        if (UtilVector.safeSize(listCommit)>0) {
          /**
           * COMMIT Global de tous les fichiers
           */
          File[] lFile = toFileArray(listCommit, root);
          CommitCommand command = new CommitCommand();
          command.setBuilder(null);
          command.setFiles(lFile);
          client.executeCommand(command, globalOptions);
        }
      }
    }
    // If an Exception occurs, write the error to the page.
    catch (Exception ex) {
      ex.printStackTrace();
    }
    finally {
        System.out.println("traceBuffer:"+getTraceBuffer());
    }
  }
  protected File[] toFileArray(List list, File root) {
    File[] ret = null;
    if (list!=null) {
      int size = list.size();
      ret = new File[size];
      for (int i = 0; i < size; ret[i] = new File(root, (String)list.get(i++)));
    }
    return ret;
  }
}

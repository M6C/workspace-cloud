package workspace.service;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

// import org.apache.log4j.Category; // if you use Log4j

/**
 * a servlet handles upload request.<br>
 * refer to http://www.ietf.org/rfc/rfc1867.txt
 *
 * @version  Revision: 1.1
 * @author   Yoon Kyung Koo
 */

public class SrvAdminExecuteCmdOld extends SrvGenerique {
    public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
      String commandLine = request.getParameter("commandLine");
      if ((commandLine!=null)&&(!commandLine.equals(""))){
        try {
          // to shutdown the machine : 'shutdown -s -f -t 20'
          // to reboot the machine   : you will have to add a "/R" into the command
          Runtime.getRuntime().exec(commandLine);
        }
        catch(IOException e) {
          System.err.println(e);
        }
      }
    }
}

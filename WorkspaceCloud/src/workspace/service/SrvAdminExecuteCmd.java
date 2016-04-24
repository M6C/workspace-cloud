package workspace.service;

import java.io.BufferedReader;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintStream;

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

public class SrvAdminExecuteCmd extends SrvGenerique {
    public void init() {
    }

    public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
      String commandLine = request.getParameter("commandLine");
      if ((commandLine!=null)&&(!commandLine.equals(""))){

    	BufferedReader out=null;
        try
        {
          StringBuffer stb = new StringBuffer();
          Process p=Runtime.getRuntime().exec(commandLine);
          p.waitFor();
/*
          Process p=Runtime.getRuntime().exec("cmd");
          PrintWriter in = new PrintWriter(new BufferedWriter(
          new OutputStreamWriter(p.getOutputStream())));
          in.println(commandLine);
          in.println("exit");
          in.flush();
*/
         out=new BufferedReader(new InputStreamReader(p.getInputStream()));
          String str = out.readLine();
          while(str!=null) {
            stb.append(str).append("\r\n");
            str = out.readLine();
          }
          request.setAttribute("resultCommandLine", stb.toString());
          p.destroy();
        }
        catch(Exception ex) {
			ByteArrayOutputStream streamLog = new ByteArrayOutputStream();
			PrintStream psLog = new PrintStream(streamLog);
			ex.printStackTrace(psLog);
			request.setAttribute("resultCommandLine", streamLog.toString());
        }
/*
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        UtilExec.setOutput(baos);
//        UtilExec.execWait(commandLine);
        UtilExec.exec(commandLine);
        if (baos.size()>0)
          request.setAttribute("resultCommandLine", new String(baos.toByteArray()));
        UtilExec.setOutput(null);
*/
      }
    }
}

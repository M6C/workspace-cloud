package workspace.service;

import java.io.*;
import java.nio.*;
import java.nio.channels.*;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.w3c.dom.Document;

import framework.beandata.BeanGenerique;
import framework.service.SrvGenerique;

import workspace.adaptateur.application.AdpXmlApplication;

public class SrvAdminStreaming extends SrvGenerique {

  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    FileChannel rbc = null;
    WritableByteChannel wbc = null;
  
    Document domXml = (Document)session.getAttribute("resultDom");
    String application = (String)bean.getParameterDataByName("application");
    String path = (String)bean.getParameterDataByName("path");
    String filename = (String)bean.getParameterDataByName("filename");
    //Recuperation du chemin principal de l'application
    String szPathMain = AdpXmlApplication.getPathByName(context, domXml, application, "Main");

    try {
        File file = new File(new File(szPathMain, path), filename);

        rbc = new FileInputStream(file).getChannel();
        rbc.position(0);
        wbc = Channels.newChannel(response.getOutputStream());
        //response.setContentType(context.getMimeType(filename));
        response.setContentType("video/mpeg");
        response.setHeader("Content-Length", String.valueOf(file.length()));
  
        ByteBuffer bb = ByteBuffer.allocateDirect(11680);
  
          while (rbc.read(bb) != -1) {
              bb.flip();
              wbc.write(bb);
              bb.clear();
          }
  
        wbc.close();
        rbc.close();
    }
    catch (Exception exp) {
        exp.printStackTrace();

        if (wbc != null)
          wbc.close();

        if (rbc != null)
          rbc.close();
    }
  }

}

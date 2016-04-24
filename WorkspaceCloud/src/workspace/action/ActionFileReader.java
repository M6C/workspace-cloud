package workspace.action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;

/**
 * Title: 
 * Description:
 * Copyright: Copyright (c) 2003
 * Company: 
 * @author not attributable
 * @version 1.0
 */

public class ActionFileReader extends framework.action.ActionFileReader {

  protected File getFileRootSource(HttpServletRequest req) {
	  File ret = null;
    String path = req.getParameter("path");
    String application = req.getParameter("application");
    Document dom = (Document)req.getSession().getAttribute("resultDom");
    String pathMain = AdpXmlApplication.getPathMain(dom, application);
    if ((pathMain!=null)&&(path!=null)) {
    	ret = new File(pathMain, path);
    }
    return ret;
  }
}
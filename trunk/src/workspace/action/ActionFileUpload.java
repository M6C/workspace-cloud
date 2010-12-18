package workspace.action;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import framework.ressource.util.UtilFileUpload;

/**
 * Title: 
 * Description:
 * Copyright: Copyright (c) 2003
 * Company: 
 * @author not attributable
 * @version 1.0
 */

public class ActionFileUpload extends framework.action.ActionFileUpload {
  protected File getFileRootSource(HttpServletRequest req, UtilFileUpload multi) {
	  File ret = null;
    String application = multi.getParameter("application");
    Document dom = (Document)req.getSession().getAttribute("resultDom");
    String path = AdpXmlApplication.getPathMain(dom, application);
    if (path!=null)
    	ret = new File(path);
    return ret;
  }
}
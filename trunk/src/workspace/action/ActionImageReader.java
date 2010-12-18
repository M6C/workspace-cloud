package workspace.action;

import java.io.File;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.transform.TransformerException;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;

public class ActionImageReader extends framework.action.ActionImageReader {

	protected File getRootDirectory(HttpServletRequest request, HttpServletResponse response) {
		File ret = null;
		HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		String application = request.getParameter("application");
        Document domXml = (Document)session.getAttribute("resultDom");
        try {
            //Recuperation du chemin principal de l'application
			String szPathMain = AdpXmlApplication.getPathByName(context, domXml, application, "Main");
			if (szPathMain!=null) {
				ret = new File(szPathMain);
			}
		} catch (TransformerException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return ret;
	}
}

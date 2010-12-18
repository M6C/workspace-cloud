/*
 * Créé le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.StringReader;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import framework.action.ActionServlet;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
public class SrvIndexLoginValider extends SrvGenerique {

	/* (non-Javadoc)
	 * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
	 */
	public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception{
		String login = (String)bean.getParameterDataByName("login");
		String password = (String)bean.getParameterDataByName("password");
		boolean bOk = false;
		if (UtilString.isNotEmpty(login)&&
			UtilString.isNotEmpty(password)) {
			try {
				TransformerFactory tFactory = TransformerFactory.newInstance();
				Source xslSource = new StreamSource(new java.net.URL("file", "", ActionServlet.WORKSPACE_SECURITY_XSL).openStream());
				Source xmlSource = new StreamSource(new java.net.URL("file", "", ActionServlet.WORKSPACE_SECURITY_XML).openStream());
				// Generate the transformer.
				Transformer transformer = tFactory.newTransformer(xslSource);
				StringWriter strWriter = new StringWriter();
				// Pass the xsl parameters
				transformer.setParameter("myID", login);
				transformer.setParameter("myPWD", password);
				// Perform the transformation, sending the output to the response.
				transformer.transform(xmlSource, new StreamResult(strWriter));
				// Get the Xml result
				String strResult = strWriter.toString();
				// Check if the result is not empty
				if (UtilString.isNotEmpty(strResult)) {
					StringReader strReader = new StringReader(strResult);
					// Check if the result can be read
					if (strReader.ready()) {
						// Creation des outils de Parse du fichier XML
						DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
						DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
						// Build the dom document from the result
						Document resultDom = docBuilder.parse(new InputSource(strReader));
						if (resultDom!=null) {
							resultDom.normalize();
							String name = UtilXML.getXPathStringValue(resultDom, "/ROOT/USER/@Name");
							bOk = (UtilString.isNotEmpty(name));
						}
					}
				}
			}
			// If an Exception occurs, write the error to the page.
			catch (Exception ex) {
				ex.printStackTrace();
			}
			finally {
				if (bOk) {
                                  request.getSession().setAttribute("BeanAuthentification", bean);
                                  request.getSession().setAttribute(ActionServlet.SECURITY_XSL, ActionServlet.WORKSPACE_SECURITY_XSL);
                                  request.getSession().setAttribute(ActionServlet.SECURITY_XML, ActionServlet.WORKSPACE_SECURITY_XML);
                                }
				else {
                                  request.getSession().removeAttribute("BeanAuthentification");
                                  throw new Exception("No Authentification");
                                }
			}
		}
	}
}

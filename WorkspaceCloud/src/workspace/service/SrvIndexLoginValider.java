/*
 * Créé le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier généré, allez à :
 * Fenêtre&gt;Préférences&gt;Java&gt;Génération de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.PrintWriter;
import java.io.StringReader;
import java.io.StringWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.xpath.XPathEvaluator;
import org.w3c.dom.xpath.XPathNSResolver;
import org.w3c.dom.xpath.XPathResult;
import org.xml.sax.InputSource;

import com.sun.org.apache.xpath.internal.domapi.XPathEvaluatorImpl;

import framework.action.ActionServlet;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;
import framework.trace.Trace;

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

		// TEST OK
		/*
		if (login!=null) {
			try {
				DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
				DocumentBuilder   docBuilder =factory.newDocumentBuilder();
	
				Document request_doc = null;
				synchronized (docBuilder)
				{
					String testXml = request.getSession().getServletContext().getRealPath("/Xml/test.xml");
					Trace.ERROR(this, "ERROR test testXml:"+testXml);
	
					request_doc = docBuilder.parse(new java.net.URL("file", "", testXml).openStream());
					//TRACE
					Trace.ERROR(this, "ERROR test request_doc:"+request_doc);
				}
				Element reqRootElt = request_doc.getDocumentElement();
				//TRACE
				Trace.ERROR(this, "ERROR test reqRootElt:"+reqRootElt);
				Trace.ERROR(this, "ERROR test reqRootElt.getChildNodes().item(0):"+reqRootElt.getChildNodes().item(0));
				Trace.ERROR(this, "ERROR test reqRootElt.getChildNodes().item(1):"+reqRootElt.getChildNodes().item(1));
				Trace.ERROR(this, "ERROR test reqRootElt.getChildNodes().item(2):"+reqRootElt.getChildNodes().item(2));
			} catch (Exception ex) {
				StringWriter s = new StringWriter();
				ex.printStackTrace(new PrintWriter(s));
				Trace.ERROR(this, "ERROR test Exception ex:"+s.toString());
			}
			return;
		}
	*/
		
		//TRACE
		Trace.DEBUG(this, "login:"+login);
		Trace.DEBUG(this, "password:"+password);
		if (UtilString.isNotEmpty(login)&&
			UtilString.isNotEmpty(password)) {
			try {
				//TransformerFactory tFactory = TransformerFactory.newInstance();
				TransformerFactory tFactory = TransformerFactory.newInstance(
					"org.apache.xalan.processor.TransformerFactoryImpl",
					Thread.currentThread().getContextClassLoader()); 
				//TRACE
				Trace.DEBUG(this, "ActionServlet.WORKSPACE_SECURITY_XSL:"+ActionServlet.WORKSPACE_SECURITY_XSL);
				Trace.DEBUG(this, "ActionServlet.WORKSPACE_SECURITY_XML:"+ActionServlet.WORKSPACE_SECURITY_XML);
				Source xslSource = new StreamSource(new java.net.URL("file", "", ActionServlet.WORKSPACE_SECURITY_XSL).openStream());
				Source xmlSource = new StreamSource(new java.net.URL("file", "", ActionServlet.WORKSPACE_SECURITY_XML).openStream());
				//TRACE
				Trace.DEBUG(this, "xslSource 1:"+xslSource);
				Trace.DEBUG(this, "xmlSource 1:"+xmlSource);
				if (xslSource==null) {
					xslSource = new StreamSource(request.getSession().getServletContext().getResourceAsStream(ActionServlet.WORKSPACE_SECURITY_XSL));
					//TRACE
					Trace.DEBUG(this, "xslSource 2:"+xslSource);
				}
				//TRACE
				{/*
					StringWriter strWriterXsl = new StringWriter();
					//TransformerFactory tFactory = TransformerFactory.newInstance();
					TransformerFactory tFactoryXsl = TransformerFactory.newInstance(
						"org.apache.xalan.processor.TransformerFactoryImpl",
						Thread.currentThread().getContextClassLoader());
					Transformer transformerXsl = tFactoryXsl.newTransformer();
					transformerXsl.transform(xslSource, new StreamResult(strWriterXsl));
					Trace.DEBUG(this, "strWriterXsl.toString():"+strWriterXsl.toString());
				*/}
				if (xmlSource==null) {
					xmlSource = new StreamSource(request.getSession().getServletContext().getResourceAsStream(ActionServlet.WORKSPACE_SECURITY_XML));
					//TRACE
					Trace.DEBUG(this, "xmlSource 2:"+xmlSource);
				}

				//TRACE
				Trace.DEBUG(this, "BEFOR transformer");
				// Generate the transformer.
				Transformer transformer = tFactory.newTransformer(xslSource);
				//TRACE
				Trace.DEBUG(this, "AFTER transformer:"+transformer);
				StringWriter strWriter = new StringWriter();
				// Pass the xsl parameters
				transformer.setParameter("myID", login);
				transformer.setParameter("myPWD", password);
				//TRACE
				Trace.DEBUG(this, "transformer.setParameter");
				// Perform the transformation, sending the output to the response.
				transformer.transform(xmlSource, new StreamResult(strWriter));
				//TRACE
				Trace.DEBUG(this, "transformer.transform");
				// Get the Xml result
				String strResult = strWriter.toString();
				//TRACE
				Trace.DEBUG(this, "strResult:");//+strResult);
				// Check if the result is not empty
				if (UtilString.isNotEmpty(strResult)) {
					StringReader strReader = new StringReader(strResult);
					// Check if the result can be read
					if (strReader.ready()) {
						//TRACE
						Trace.DEBUG(this, "strReader.ready");
						// Creation des outils de Parse du fichier XML
						DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
						DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
						//TRACE
						Trace.DEBUG(this, "newDocumentBuilder");
						// Build the dom document from the result
						Document resultDom = docBuilder.parse(new InputSource(strReader));
						//TRACE
						Trace.DEBUG(this, "docBuilder.parse resultDom:"+resultDom);
						if (resultDom!=null) {
							resultDom.normalize();
							//TRACE
							Trace.DEBUG(this, "docBuilder.parse resultDom.normalize()");
							String name = UtilXML.getXPathStringValue(resultDom, "/ROOT/USER/@Name");
							//String name = getXPathStringValue(resultDom, "/ROOT/USER/@Name");
							//TRACE
							Trace.DEBUG(this, "docBuilder.parse /ROOT/USER/@Name:"+name);
							bOk = (UtilString.isNotEmpty(name));
							//TRACE
							Trace.DEBUG(this, "bOk:"+bOk);
						}
					}
				}
			}
			// If an Exception occurs, write the error to the page.
			catch (Exception ex) {
				Trace.ERROR(this, ex);
			}
			finally {
				try {
					if (bOk) {
	                  request.getSession().setAttribute("BeanAuthentification", bean);
	                  request.getSession().setAttribute(ActionServlet.SECURITY_XSL, ActionServlet.WORKSPACE_SECURITY_XSL);
	                  request.getSession().setAttribute(ActionServlet.SECURITY_XML, ActionServlet.WORKSPACE_SECURITY_XML);
	                }
					else {
						if (request.getSession().getAttribute("BeanAuthentification")!=null)
							request.getSession().removeAttribute("BeanAuthentification");
	                    throw new Exception("No Authentification");
	                }
				}
				// If an Exception occurs, write the error to the page.
				catch (Exception ex) {
					Trace.ERROR(this, ex);
				}
			}
		}
	}
}

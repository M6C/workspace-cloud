/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.URIResolver;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.w3c.dom.Document;

import workspace.adaptateur.application.AdpXmlApplication;
import workspace.util.UtilPath;
import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilBuildJar;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilRequest;
import framework.ressource.util.UtilSafe;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilVector;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaXmlXsl1 extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvGenerique#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
    HttpSession session = request.getSession();
    ServletContext context = session.getServletContext();
    String application = (String)bean.getParameterDataByName("application");
    String pathXml = (String)bean.getParameterDataByName("pathXml");
    String xmlName = (String)bean.getParameterDataByName("xmlName");
    String xmlScope = (String)bean.getParameterDataByName("xmlScope");
    String pathXsl = (String)bean.getParameterDataByName("pathXsl");
    String xslParam = (String)bean.getParameterDataByName("paramXsl");
    if (UtilString.isNotEmpty(application) &&
        (UtilString.isNotEmpty(pathXml) || UtilString.isNotEmpty(xmlName))
       ) {
      try {
        Document dom = (Document)session.getAttribute("resultDom");
        // Chemin principal de l'application selectionné
        String filePathMain = AdpXmlApplication.getPathMain(dom, application);
        Transformer transformer = null;
        TransformerFactory tFactory = TransformerFactory.newInstance();
        String szXsl = UtilRequest.replaceParamByRequestValue(pathXsl, request, session, "");
        if (UtilString.isNotEmpty(szXsl)) {
          //szXsl = UtilPath.formatPath(request, dom, szXsl, ';');
          szXsl = UtilPath.formatPath(dom, szXsl, ';');
          if (!new File(szXsl).isAbsolute())
            szXsl = new File(filePathMain, szXsl).getAbsolutePath();
          Source xslSource = null;
          try {
            xslSource = new StreamSource(new java.net.URL("file", "", szXsl).openStream());
          }
          catch (FileNotFoundException ex) {
            xslSource = new StreamSource(context.getResourceAsStream(szXsl));
          }
          
          // Generate the transformer.
          transformer = tFactory.newTransformer(xslSource);
        }
        else
          // Generate the transformer.
          transformer = tFactory.newTransformer();
        String szXmlPath = UtilRequest.replaceParamByRequestValue(pathXml, request, session, "");
        String szXmlName = UtilRequest.replaceParamByRequestValue(xmlName, request, session, "");
        String szXmlScope = UtilRequest.replaceParamByRequestValue(xmlScope, request, session, "");
        String szXslParam = UtilRequest.replaceParamByRequestValue(xslParam, request, session, "");
        if (transformer!=null) {
          Source xmlSource = null;
          if (UtilString.isNotEmpty(szXmlPath)) {
            //szXmlPath = UtilPath.formatPath(request, dom, szXmlPath, ';');
        	szXmlPath = UtilPath.formatPath(dom, szXmlPath, ';');
            if (!new File(szXmlPath).isAbsolute())
              szXmlPath = new File(filePathMain, szXmlPath).getAbsolutePath();
            // Get the XML input document and the stylesheet, both in the servlet
            // engine document directory.
            try {
              xmlSource = new StreamSource(new java.net.URL("file", "", szXmlPath).openStream());
            } catch (FileNotFoundException ex) {
              xmlSource = new StreamSource(context.getResourceAsStream(szXmlPath));
            }
          }
          else if (UtilString.isNotEmpty(szXmlName)) {
            Document doc = null;
            if (UtilString.isEqualsIgnoreCase("session", szXmlScope))
              doc = (Document)session.getAttribute(szXmlName);
            else
              doc = (Document)request.getAttribute(szXmlName);
            if (doc!=null)
              xmlSource = new DOMSource(doc);
          }
          if (xmlSource!=null) {
            /**
             * Enregistrement des paramètres
             */
            String[] listXslParam = UtilString.split(szXslParam, ';');
            String param = null;
            String[] listParam = null;
            int size = UtilSafe.safeListSize(listXslParam);
            for(int i=0 ; i<size ; i++) {
              param = (String)UtilSafe.safeListGetElementAt(listXslParam, i);
              listParam = UtilString.split(param, '=');
              if ((listParam!=null)&&(listParam.length==2)) {
                transformer.setParameter(listParam[0], listParam[1]);
              }
            }
            StringWriter strWriter = new StringWriter();
	        final ServletContext ctx = context;
	        URIResolver uriResolver = new URIResolver() {
	          public Source resolve(String href, String base) {
	            Source src = new StreamSource(ctx.getResourceAsStream(href));
	            return src;
	          }
	        };
            transformer.setURIResolver(uriResolver);
            // Perform the transformation, sending the output to the response.
            transformer.transform(xmlSource, new StreamResult(strWriter));
            // Get the Xml result
            String xmlResult = strWriter.toString();
            // Check if the result is not empty
            if (UtilString.isNotEmpty(xmlResult)) {
              request.setAttribute("xmlResult", xmlResult);
            }
          }
        }
      }
      catch(Exception ex){
        ex.printStackTrace();//new PrintWriter(out));
      }
    }
  }
}

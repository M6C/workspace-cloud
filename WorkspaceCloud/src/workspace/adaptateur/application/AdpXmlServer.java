package workspace.adaptateur.application;

import java.io.StringWriter;
import java.util.Dictionary;
import java.util.Hashtable;

import javax.servlet.ServletContext;
import javax.xml.transform.TransformerException;

import org.w3c.dom.Document;

import framework.ressource.util.UtilString;
import framework.ressource.util.UtilXML;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public class AdpXmlServer extends AdpXml {
  private AdpXmlServer() {
  }

  public static String getCommandByName(ServletContext context, Document dom, String application, String name) throws TransformerException {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Server/Command/FindByName.xsl";

    Dictionary dictionary = new Hashtable();

    dictionary.put("pApplication", application);
    dictionary.put("pName", name);

    StringWriter strWriter = new StringWriter();
    UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary);
    ret = strWriter.toString();

    if (UtilString.isEmpty(ret))
      throw new IllegalArgumentException("Command '" + name + "' not found in application '"+application+"'");
    else
      ret = ret.trim();

    return ret;
  }

  public static String getPathByName(ServletContext context, Document dom, String application, String command) throws TransformerException {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Server/Path/FindByName.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);
    dictionary.put("pName", command);

    StringWriter strWriter = new StringWriter();
    UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary);
    ret = strWriter.toString();

    if (UtilString.isEmpty(ret))
      throw new IllegalArgumentException("Command '" + command + "' not found in application '"+application+"'");
    else
      ret = ret.trim();

    return ret;
  }
}

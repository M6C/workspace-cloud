package workspace.adaptateur.application;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.StringReader;
import java.io.StringWriter;
import java.net.URI;
import java.net.URISyntaxException;
import java.util.Dictionary;
import java.util.Hashtable;

import javax.servlet.ServletContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Source;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.TransformerException;
import javax.xml.transform.URIResolver;

import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import framework.ressource.util.UtilString;
import framework.ressource.util.UtilXML;
import workspace.util.UtilPath;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public class AdpXmlApplication extends AdpXml {
  private AdpXmlApplication() {
  }

  public static String getLocalDirectory(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/LOCAL_DIRECTORY").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getModuleName(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/MODULE_NAME").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getServerHostName(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/SERVER_HOSTNAME").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getServerPort(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/SERVER_PORT").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getServerRepository(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/SERVER_REPOSITORY").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getUserName(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/USER").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getPassword(Document dom, String application) {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/VERSIONNING/PASSWORD").toString();

    ret = UtilXML.getXPathStringValue(dom, xpath);
    if (ret==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    return ret;
  }

  public static String getPathMain(Document dom, String application) {
	  String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/PATHS/PATH[@Name = 'Main']").toString();

    String szXPathMain = UtilXML.getXPathStringValue(dom, xpath);

    if (szXPathMain==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

	ret = szXPathMain;//new File(szXPathMain);
    if (!szXPathMain.toUpperCase().startsWith("FTP://")) {
    	File file = new File(szXPathMain);
	    if (!file.exists())
	      throw new IllegalArgumentException("Path [" + szXPathMain + "] do not exist.");
	
	    if (file.isFile())
	      throw new IllegalArgumentException("Path [" + szXPathMain + "] is not a directory.");
    }

    return ret;
  }


  public static String getPackageFileNameByName(ServletContext context, Document dom, String application, String type, String name) throws TransformerException {
    String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Packaging/Package/FileNameByName.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);
    dictionary.put("pType", type);
    dictionary.put("pName", name);

    StringWriter strWriter = new StringWriter();
    UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary);
    ret = strWriter.toString();

    if (UtilString.isEmpty(ret))
      throw new IllegalArgumentException("Package '" + name + "' not found in application '"+application+"'");
    else
      ret = ret.trim();

    return ret;
  }

  public static Document getPackageXmlByName(ServletContext context, Document dom, String application, String type, String name) throws TransformerException {
    Document ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Packaging/Package/Content/ContentByName.xsl";//XmlByName.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);
    dictionary.put("pType", type);
    dictionary.put("pName", name);

    try {
      final ServletContext ctx = context;
      URIResolver uriResolver = new URIResolver() {
        public Source resolve(String href, String base) {
          Source src = new StreamSource(ctx.getResourceAsStream(href));
          return src;
        }
      };
      ret = UtilXML.tranformeXmlWithXslToDom(dom, context.getResourceAsStream(szXsl), dictionary, uriResolver);
    } catch (IllegalArgumentException e) {
      throw new IllegalArgumentException("Package '" + name + "' not found in application '"+application+"'");
    } catch (SAXException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (IOException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } catch (ParserConfigurationException e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    }

    return ret;
  }

  public static String getPathByName(ServletContext context, Document dom, String application, String name) throws TransformerException {
	  String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Paths/Path/FindByName.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);
    dictionary.put("pPath", name);

    try {
      final ServletContext ctx = context;
      URIResolver uriResolver = new URIResolver() {
        public Source resolve(String href, String base) {
          Source src = new StreamSource(ctx.getResourceAsStream(href));
          return src;
        }
      };
      StringWriter strWriter = new StringWriter();
      UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary, uriResolver);
      ret = strWriter.toString();
    } catch (IllegalArgumentException e) {
      throw new IllegalArgumentException("Package '" + name + "' not found in application '"+application+"'");
    }

    return ret;
  }

  public static String getClassPathAll(ServletContext context, Document dom, String application) throws TransformerException {
	  String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Build/Classpath/All.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);

    try {
      final ServletContext ctx = context;
      URIResolver uriResolver = new URIResolver() {
        public Source resolve(String href, String base) {
          Source src = new StreamSource(ctx.getResourceAsStream(href));
          return src;
        }
      };
      StringWriter strWriter = new StringWriter();
      UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary, uriResolver);
      ret = strWriter.toString();
    } catch (IllegalArgumentException e) {
      throw new IllegalArgumentException("Classpath not found in application '"+application+"'");
    }

    return ret;
  }

  public static String getJdkPathByName(ServletContext context, Document dom, String application, String name) throws TransformerException {
	  String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Jdk/Path/FindByName.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);
    dictionary.put("pPath", name);

    try {
      final ServletContext ctx = context;
      URIResolver uriResolver = new URIResolver() {
        public Source resolve(String href, String base) {
          Source src = new StreamSource(ctx.getResourceAsStream(href));
          return src;
        }
      };
      StringWriter strWriter = new StringWriter();
      UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary, uriResolver);
      ret = strWriter.toString();
    } catch (IllegalArgumentException e) {
      throw new IllegalArgumentException("Classpath not found in application '"+application+"'");
    }

    return ret;
  }

  public static String getJdkJrePathByName(ServletContext context, Document dom, String application, String name) throws TransformerException {
	  String ret = null;

    checkDocument(dom);
    checkApplication(application);

    String szXsl = "Xsl/User/Application/Jdk/Jre/Path/FindByName.xsl";

    Dictionary dictionary = new Hashtable();
    dictionary.put("pApplication", application);
    dictionary.put("pPath", name);

    try {
      final ServletContext ctx = context;
      URIResolver uriResolver = new URIResolver() {
        public Source resolve(String href, String base) {
          Source src = new StreamSource(ctx.getResourceAsStream(href));
          return src;
        }
      };
      StringWriter strWriter = new StringWriter();
      UtilXML.tranformeXmlWithXsl(dom, context.getResourceAsStream(szXsl), strWriter, dictionary, uriResolver);
      ret = strWriter.toString();
    } catch (IllegalArgumentException e) {
      throw new IllegalArgumentException("Classpath not found in application '"+application+"'");
    }

    return ret;
  }
}
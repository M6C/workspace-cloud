package workspace.adaptateur;

import java.io.File;

import org.w3c.dom.Document;

import framework.ressource.util.UtilXML;

/**
 * <p>Title: </p>
 * <p>Description: </p>
 * <p>Copyright: Copyright (c) 2003</p>
 * <p>Company: </p>
 * @author not attributable
 * @version 1.0
 */

public class AdpXmlApplication {
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

  public static File getPathMain(Document dom, String application) {
    File ret = null;

    checkDocument(dom);
    checkApplication(application);

    String xpath = new StringBuffer("//ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name = '")
        .append(application).append("']/PATHS/PATH[@Name = 'Main']").toString();

    String szXPathMain = UtilXML.getXPathStringValue(dom, xpath);

    if (szXPathMain==null)
      throw new IllegalArgumentException("XPath [" + xpath + "] value not found in document");

    ret = new File(szXPathMain);
    if (!ret.exists())
      throw new IllegalArgumentException("Path [" + szXPathMain + "] do not exist.");

    if (ret.isFile())
      throw new IllegalArgumentException("Path [" + szXPathMain + "] is not a directory.");

    return ret;
  }

  protected static void checkDocument(Document dom) {
    if (dom==null)
      throw new IllegalArgumentException("Argument dom (org.w3c.dom.Document) is null");
  }

  protected static void checkApplication(String application) {
    if (application==null)
      throw new IllegalArgumentException("Argument application (java.lang.String) is null");
    if (application.trim().equals(""))
      throw new IllegalArgumentException("Argument application (java.lang.String) is empty");
  }
}

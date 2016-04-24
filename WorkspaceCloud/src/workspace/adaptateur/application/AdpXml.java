package workspace.adaptateur.application;

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

public class AdpXml {

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

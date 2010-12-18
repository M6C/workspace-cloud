package workspace.taglib.versioning;

import framework.ressource.util.UtilRequest;
import framework.ressource.util.UtilString;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.netbeans.lib.cvsclient.command.status.StatusInformation;
import org.w3c.dom.Document;
import workspace.bean.versioning.BeanCVS;

/**
 * @author  HP_Administrateur
 */
public class TagStatus extends BodyTagSupport {

  private String path =null;
  private String application = null;
  private String name = null;
  private String scope = null;

  public TagStatus() {
  }

  public int doStartTag() {
    if(UtilString.isNotEmpty(getPath())&&
       UtilString.isNotEmpty(getApplication())&&
       UtilString.isNotEmpty(getName())) {
      try {
        Document dom = (Document)pageContext.getSession().getAttribute("resultDom");
        if(dom!=null) {
          String szApplication = UtilRequest.replaceParamByRequestValue(getApplication(), pageContext.getRequest(), pageContext.getSession(), "");
          if (UtilString.isNotEmpty(szApplication)) {
            BeanCVS beanCvs = new BeanCVS(dom, szApplication);
            String szPath = UtilRequest.replaceParamByRequestValue(getPath(), pageContext.getRequest(), pageContext.getSession(), "");
            if (UtilString.isNotEmpty(szPath)) {
              StatusInformation[] listStatus = beanCvs.executeStatusInformation(szPath, false, false);
              if ( (listStatus != null) && (listStatus.length > 0)) {
                String szName = UtilRequest.replaceParamByRequestValue(getName(), pageContext.getRequest(), pageContext.getSession(), "");
                if (UtilString.isNotEmpty(szName)) {
                  if ("session".equalsIgnoreCase(getScope()))
                    pageContext.getSession().setAttribute(szName, listStatus[0]);
                  else
                    pageContext.getRequest().setAttribute(szName, listStatus[0]);
                }
              }
            }
          }
        }
      }
      catch (Exception ex) {
      }
    }
    return SKIP_BODY;
  }

  public int doEndTag() {
    return EVAL_PAGE;
  }

  /**
 * @param path  the path to set
 * @uml.property  name="path"
 */
public void setPath(String path) {
    this.path = path;
  }

  /**
 * @param application  the application to set
 * @uml.property  name="application"
 */
public void setApplication(String application) {
    this.application = application;
  }

  /**
 * @param name  the name to set
 * @uml.property  name="name"
 */
public void setName(String name) {
    this.name = name;
  }

  /**
 * @param scope  the scope to set
 * @uml.property  name="scope"
 */
public void setScope(String scope) {
    this.scope = scope;
  }

  /**
 * @return  the path
 * @uml.property  name="path"
 */
public String getPath() {
    return path;
  }

  /**
 * @return  the application
 * @uml.property  name="application"
 */
public String getApplication() {
    return application;
  }

  /**
 * @return  the name
 * @uml.property  name="name"
 */
public String getName() {
    return name;
  }

  /**
 * @return  the scope
 * @uml.property  name="scope"
 */
public String getScope() {
    return scope;
  }

}

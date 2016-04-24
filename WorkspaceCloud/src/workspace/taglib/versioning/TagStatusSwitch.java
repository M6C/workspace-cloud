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
public class TagStatusSwitch extends BodyTagSupport {

  private String path =null;
  private String application = null;
  private String name = null;
  private String scope = null;

  private StatusInformation statusInformation = null;
  private boolean caseFound = false;

  public TagStatusSwitch() {
  }

  public int doStartTag() {
    boolean isShow=false;
    try {
      if(UtilString.isNotEmpty(getApplication())&&(UtilString.isNotEmpty(getPath()))) {
        String szApplication = UtilRequest.replaceParamByRequestValue(getApplication(), pageContext.getRequest(), pageContext.getSession(), "");
        Document dom = (Document)pageContext.getSession().getAttribute("resultDom");
        if (UtilString.isNotEmpty(szApplication) && (dom!=null)) {
          BeanCVS beanCvs = new BeanCVS(dom, szApplication);
          String szPath = UtilRequest.replaceParamByRequestValue(getPath(), pageContext.getRequest(), pageContext.getSession(), "");
          if (UtilString.isNotEmpty(szPath)) {
            StatusInformation[] listStatus = beanCvs.executeStatusInformation(szPath, false, false);
            if ( (listStatus != null) && (listStatus.length > 0))
              setStatusInformation(listStatus[0]);
          }
        }
      }
      else if (UtilString.isNotEmpty(getName())) {
        String szName = UtilRequest.replaceParamByRequestValue(getName(), pageContext.getRequest(), pageContext.getSession(), "");
        if (UtilString.isNotEmpty(szName)) {
          Object status = null;
          if ("session".equalsIgnoreCase(getScope()))
            status = pageContext.getSession().getAttribute(szName);
          else
            status = pageContext.getRequest().getAttribute(szName);
          if (status!=null) {
            if (status instanceof TagStatusList.BeanStatus)
              setStatusInformation(((TagStatusList.BeanStatus)status).getStatus());
            else
            setStatusInformation((StatusInformation)status);
          }
        }
      }
    }
    catch (Exception ex) {
    }
    return EVAL_BODY_INCLUDE;
  }

  public int doEndTag() {
    caseFound = false;
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
 * @param statusInformation  the statusInformation to set
 * @uml.property  name="statusInformation"
 */
public void setStatusInformation(StatusInformation statusInformation) {
    this.statusInformation = statusInformation;
  }

  /**
 * @param application  the application to set
 * @uml.property  name="application"
 */
public void setApplication(String application) {
    this.application = application;
  }

  /**
 * @param caseFound  the caseFound to set
 * @uml.property  name="caseFound"
 */
public void setCaseFound(boolean caseFound) {
    this.caseFound = caseFound;
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
 * @return  the statusInformation
 * @uml.property  name="statusInformation"
 */
public StatusInformation getStatusInformation() {
    return statusInformation;
  }

  /**
 * @return  the application
 * @uml.property  name="application"
 */
public String getApplication() {
    return application;
  }

  /**
 * @return  the caseFound
 * @uml.property  name="caseFound"
 */
public boolean isCaseFound() {
    return caseFound;
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

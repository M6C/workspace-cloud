package workspace.taglib.path;

import framework.ressource.util.UtilRequest;
import framework.ressource.util.UtilString;
import framework.trace.Trace;

import java.io.File;
import javax.servlet.jsp.tagext.BodyTagSupport;
import org.netbeans.lib.cvsclient.command.status.StatusInformation;
import org.w3c.dom.Document;
import workspace.bean.versioning.BeanCVS;
import workspace.util.UtilPath;

/**
 * @author  HP_Administrateur
 */
public class TagPathFormat extends BodyTagSupport {

  private String application = null;
  private String name = null;
  private String scope = null;
  private String toURI = null;

  public TagPathFormat() {
  }

  public int doStartTag() {
    if(UtilString.isNotEmpty(getName())) {
      try {
        Document dom = (Document)pageContext.getSession().getAttribute("resultDom");
        // DEBUG
		//Trace.DEBUG(this, "dom:"+dom);
        if(dom!=null) {
          String szName = UtilRequest.replaceParamByRequestValue(getName(), pageContext.getRequest(), pageContext.getSession(), "");
          // DEBUG
          //Trace.DEBUG(this, "szName:"+szName);
          if (UtilString.isNotEmpty(szName)) {
            String path = null;
            if (UtilString.isNotEmpty(szName)) {
              if ("session".equalsIgnoreCase(getScope()))
                path = (String)pageContext.getSession().getAttribute(szName);
              else {
                path = pageContext.getRequest().getParameter(szName);
                if (path==null)
                  path = (String)pageContext.getRequest().getAttribute(szName);
              }
            }

            // DEBUG
            //Trace.DEBUG(this, "path1:"+path);

            if (path!=null) {
              //path = UtilPath.formatPath(pageContext.getRequest(), dom, path, ';');
              path = UtilPath.formatPath(dom, path, ';');
              if (path!=null) {
	              File filePath = new File(path);
	              if (!filePath.isAbsolute()) {
	                String szApplication = UtilRequest.replaceParamByRequestValue(getApplication(), pageContext.getRequest(), pageContext.getSession(), "");
	                if (UtilString.isNotEmpty(szApplication)) {
	                  path = new File(new File(szApplication), path).getCanonicalPath();
	                }
	              }
	              if (UtilString.isEqualsIgnoreCase(Boolean.TRUE.toString(), getToURI())) {
	            	  path = new File(path).toURI().getPath();
	              }
	              // DEBUG
	              //Trace.DEBUG(this, "path2:"+path);
	              if ("session".equalsIgnoreCase(getScope()))
	                pageContext.getSession().setAttribute(szName, path);
	              else
	                pageContext.getRequest().setAttribute(szName, path);
              }
            }
          }
        }
      }
      catch (Exception ex) {
  		Trace.ERROR(this, ex);
      }
    }
     return SKIP_BODY;
  }

  public int doEndTag() {
    return EVAL_PAGE;
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

  /**
 * @return  the application
 * @uml.property  name="application"
 */
public String getApplication() {
    return application;
  }

  /**
 * @param application  the application to set
 * @uml.property  name="application"
 */
public void setApplication(
      String application) {
    this.application = application;
  }

	/**
	 * @return  the toURI
	 * @uml.property  name="toURI"
	 */
	public String getToURI() {
		return toURI;
	}
	
	/**
	 * @param toURI  the toURI to set
	 * @uml.property  name="toURI"
	 */
	public void setToURI(String toURI) {
		this.toURI = toURI;
	}
}

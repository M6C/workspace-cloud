package workspace.taglib.versioning;

import framework.ressource.util.UtilString;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * @author  HP_Administrateur
 */
public class TagStatusListSize extends TagSupport {
  private String scope;
  private String name;

  public TagStatusListSize() {
  }

  public int doStartTag() {
    JspWriter out = pageContext.getOut();
    TagStatusList tagParent = null;
    Tag parent = getParent();
    while (parent!=null) {
      if (parent instanceof TagStatusList) {
        tagParent = (TagStatusList)parent;
      }
      parent = parent.getParent();
    }
    if (tagParent != null) {
      if (UtilString.isNotEmpty(getName())) {
        String szSize = (tagParent.getStatusList()==null) ? "0" : String.valueOf(tagParent.getStatusList().size());
        if ("session".equalsIgnoreCase(getScope()))
          pageContext.getSession().setAttribute(getName(), szSize);
        else
          pageContext.getRequest().setAttribute(getName(), szSize);
      }
    }
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
}

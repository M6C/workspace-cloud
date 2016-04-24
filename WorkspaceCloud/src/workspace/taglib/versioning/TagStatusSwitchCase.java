package workspace.taglib.versioning;

import framework.ressource.util.UtilRequest;
import framework.ressource.util.UtilString;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;
import org.netbeans.lib.cvsclient.command.status.StatusInformation;

/**
 * @author  HP_Administrateur
 */
public class TagStatusSwitchCase extends TagSupport {
  private String value;

  public TagStatusSwitchCase() {
  }

  public int doStartTag() {
    boolean isShow=false;
    JspWriter out = pageContext.getOut();
    TagStatusSwitch tagParent = null;
    Tag parent = getParent();
    while (parent!=null) {
      if (parent instanceof TagStatusSwitch) {
        tagParent = (TagStatusSwitch)parent;
      }
      parent = parent.getParent();
    }
    if (tagParent != null) {
      if (!tagParent.isCaseFound()) {
        String szValue = UtilRequest.replaceParamByRequestValue(getValue(), pageContext.getRequest(), pageContext.getSession(), "");
        if (UtilString.isNotEmpty(szValue)) {
          StatusInformation statusInformation = tagParent.getStatusInformation();
          if (statusInformation!=null) {
            String status = statusInformation.getStatus().toString();
            String[] listValue = UtilString.split(szValue, ';');
            if (listValue != null) {
              int size = listValue.length;
              for (int i = 0; i < size && !isShow; i++) {
                isShow = listValue[i].equalsIgnoreCase(status);
              }
              tagParent.setCaseFound(isShow);
            }
          }
        }
      }
    }
    return (isShow) ? EVAL_BODY_INCLUDE : SKIP_BODY;
  }

  public int doEndTag() {
    return EVAL_PAGE;
  }

  /**
 * @param value  the value to set
 * @uml.property  name="value"
 */
public void setValue(String value) {
    this.value = value;
  }

  /**
 * @return  the value
 * @uml.property  name="value"
 */
public String getValue() {
    return value;
  }
}

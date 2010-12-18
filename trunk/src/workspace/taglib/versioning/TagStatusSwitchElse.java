package workspace.taglib.versioning;

import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

public class TagStatusSwitchElse extends TagSupport {

  public TagStatusSwitchElse() {
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
      isShow = !tagParent.isCaseFound();
      tagParent.setCaseFound(isShow);
    }
    return (isShow) ? EVAL_BODY_INCLUDE : SKIP_BODY;
  }

  public int doEndTag() {
    return EVAL_PAGE;
  }
}

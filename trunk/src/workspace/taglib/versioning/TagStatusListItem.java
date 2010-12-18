package workspace.taglib.versioning;

import framework.ressource.util.UtilReflect;
import framework.ressource.util.UtilString;
import framework.trace.Trace;
import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;
import org.netbeans.lib.cvsclient.command.status.StatusInformation;

/**
 * @author  HP_Administrateur
 */
public class TagStatusListItem extends TagSupport {
  private String methode;
  private String methodeArgument;
  private String scope;
  private String name;

  public TagStatusListItem() {
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
      if (UtilString.isNotEmpty(getMethode())) {
        try {
          StatusInformation status = tagParent.getCurrentStatus();
          Class[] type = null;
          Object[] value = null;
          if (UtilString.isNotEmpty(getMethodeArgument())) {
            String[] arg = UtilString.split(getMethodeArgument(), ';');
            int iArg = arg.length;
            type = new Class[iArg];
            value = new Object[iArg];
            for (int i = 0; i < iArg; i++) {
              type[i] = arg[i].getClass();
              value[i] = arg[i];
            }
          }
          out.print(UtilReflect.invokeMethod(status, getMethode(), type, value));
        }
        catch (NoSuchMethodException ex) {
          Trace.ERROR(ex);
        }
        catch (InvocationTargetException ex) {
          Trace.ERROR(ex);
        }
        catch (IllegalAccessException ex) {
          Trace.ERROR(ex);
        }
        catch (IllegalArgumentException ex) {
          Trace.ERROR(ex);
        }
        catch (IOException ex) {
          Trace.ERROR(ex);
        }
      }
      if (UtilString.isNotEmpty(getName())) {
        if ("session".equalsIgnoreCase(getScope()))
          pageContext.getSession().setAttribute(getName(), tagParent.getCurrentBean());
        else
          pageContext.getRequest().setAttribute(getName(), tagParent.getCurrentBean());
      }
    }
    return EVAL_PAGE;
  }

  /**
 * @param methode  the methode to set
 * @uml.property  name="methode"
 */
public void setMethode(String methode) {
    this.methode = methode;
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
 * @param methodeArgument  the methodeArgument to set
 * @uml.property  name="methodeArgument"
 */
public void setMethodeArgument(String methodeArgument) {
    this.methodeArgument = methodeArgument;
  }

  /**
 * @return  the methode
 * @uml.property  name="methode"
 */
public String getMethode() {
    return methode;
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
 * @return  the methodeArgument
 * @uml.property  name="methodeArgument"
 */
public String getMethodeArgument() {
    return methodeArgument;
  }
}

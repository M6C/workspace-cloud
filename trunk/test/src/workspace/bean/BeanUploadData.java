package workspace.bean;

/**
 * @author  HP_Administrateur
 */
public class BeanUploadData {
  private String name;
  private String value;
  private String contentType;
  private int size;
  private boolean aFile;

  public BeanUploadData(String name, String value, String contentType, int size, boolean isFile) {
    this.name = name;
    this.value = value;
    this.contentType = contentType;
    this.size = size;
    this.aFile = isFile;
  }

  /**
 * @return  the name
 * @uml.property  name="name"
 */
public String getName() {
    return name;
  }

  /**
 * @return  the contentType
 * @uml.property  name="contentType"
 */
public String getContentType() {
    return contentType;
  }

  /**
 * @return  the size
 * @uml.property  name="size"
 */
public int getSize() {
    return size;
  }

  /**
 * @param value  the value to set
 * @uml.property  name="value"
 */
public void setValue(String value) {
    this.value = value;
  }

  /**
 * @param name  the name to set
 * @uml.property  name="name"
 */
public void setName(String name) {
    this.name = name;
  }

  /**
 * @param contentType  the contentType to set
 * @uml.property  name="contentType"
 */
public void setContentType(String contentType) {
    this.contentType = contentType;
  }

  /**
 * @param size  the size to set
 * @uml.property  name="size"
 */
public void setSize(int size) {
    this.size = size;
  }

  /**
 * @param aFile  the aFile to set
 * @uml.property  name="aFile"
 */
public void setAFile(boolean aFile) {
    this.aFile = aFile;
  }

  /**
 * @return  the value
 * @uml.property  name="value"
 */
public String getValue() {
    return value;
  }

  /**
 * @return  the aFile
 * @uml.property  name="aFile"
 */
public boolean isAFile() {
    return aFile;
  }
}

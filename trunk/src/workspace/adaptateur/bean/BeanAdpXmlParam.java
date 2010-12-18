package workspace.adaptateur.bean;

public class BeanAdpXmlParam {
	 private String name;
	 private String type;
	 private String bean;
	 private String format;

	 public BeanAdpXmlParam() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BeanAdpXmlParam(String name, String type) {
		super();
		this.name = name;
		this.type = type;
	}

	/**
	 * @return the name
	 */
	public String getName() {
		return name;
	}

	/**
	 * @param name the name to set
	 */
	public void setName(String name) {
		this.name = name;
	}

	/**
	 * @return the type
	 */
	public String getType() {
		return type;
	}
	/**
	 * @param type the type to set
	 */
	public void setType(String type) {
		this.type = type;
	}

	/**
	 * @return the format
	 */
	public String getFormat() {
		return format;
	}

	/**
	 * @param format the format to set
	 */
	public void setFormat(String format) {
		this.format = format;
	}

	/**
	 * @return the bean
	 */
	public String getBean() {
		return bean;
	}

	/**
	 * @param bean the bean to set
	 */
	public void setBean(String bean) {
		this.bean = bean;
	}
}

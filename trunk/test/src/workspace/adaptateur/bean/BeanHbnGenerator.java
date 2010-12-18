package workspace.adaptateur.bean;

public class BeanHbnGenerator {
	private String className;

	public BeanHbnGenerator() {
		super();
	}

	public BeanHbnGenerator(String className) {
		super();
		this.className = className;
	}

	/**
	 * @return the className
	 */
	public String getClassName() {
		return className;
	}

	/**
	 * @param className the className to set
	 */
	public void setClassName(String className) {
		this.className = className;
	}
}

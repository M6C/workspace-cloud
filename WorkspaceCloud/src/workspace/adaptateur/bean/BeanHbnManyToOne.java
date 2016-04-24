package workspace.adaptateur.bean;

public class BeanHbnManyToOne {

	private String name;
	private String column;
	private String className;
	private String notNull;

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
	/**
	 * @return the column
	 */
	public String getColumn() {
		return column;
	}
	/**
	 * @param column the column to set
	 */
	public void setColumn(String column) {
		this.column = column;
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
	 * @return the notNull
	 */
	public String getNotNull() {
		return notNull;
	}
	/**
	 * @param notNull the notNull to set
	 */
	public void setNotNull(String notNull) {
		this.notNull = notNull;
	}
}

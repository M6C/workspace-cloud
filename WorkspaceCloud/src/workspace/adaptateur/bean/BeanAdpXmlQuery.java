package workspace.adaptateur.bean;

public class BeanAdpXmlQuery {
	 private String type;
	 private String query;
	 private String parameterCount;

	 public BeanAdpXmlQuery() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BeanAdpXmlQuery(String type, String query, String parameterCount) {
		super();
		this.type = type;
		this.query = query;
		this.parameterCount = parameterCount;
	}

	 /**
	 * @return the query
	 */
	public String getQuery() {
		return query;
	}
	/**
	 * @param query the query to set
	 */
	public void setQuery(String query) {
		this.query = query;
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
	 * @return the parameterCount
	 */
	public String getParameterCount() {
		return parameterCount;
	}

	/**
	 * @param parameterCount the parameterCount to set
	 */
	public void setParameterCount(String parameterCount) {
		this.parameterCount = parameterCount;
	}
}

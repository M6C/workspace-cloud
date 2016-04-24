package workspace.adaptateur.bean;

public class BeanAdpXmlHibernate implements Cloneable {

	private String table;

	public BeanAdpXmlHibernate() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BeanAdpXmlHibernate(String table) {
		super();
		this.table = table;
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#clone()
	 */
	@Override
	public Object clone() throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		return super.clone();
	}

	/* (non-Javadoc)
	 * @see java.lang.Object#clone()
	 */
	public Object clone(String table) throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		BeanAdpXmlHibernate ret = (BeanAdpXmlHibernate)super.clone();
		ret.setTable(table);
		return ret;
	}

	/**
	 * @return the table
	 */
	public String getTable() {
		return table;
	}

	/**
	 * @param table the table to set
	 */
	public void setTable(String table) {
		this.table = table;
	}
}

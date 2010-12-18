package workspace.adaptateur.bean;

public class BeanAdpXmlServlet implements Cloneable {

	private String name;
	private String aClass;
	private String target;
	private String targetError;
	private String authentification;
	private BeanAdpXmlBean beanAdpXmlBean;

	public BeanAdpXmlServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BeanAdpXmlServlet(String name, String class1, String target, String targetError, String authentification, BeanAdpXmlBean beanAdpXmlBean) {
		super();
		this.name = name;
		aClass = class1;
		this.target = target;
		this.targetError = targetError;
		this.authentification = authentification;
		this.beanAdpXmlBean = beanAdpXmlBean;
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
	public Object clone(String name) throws CloneNotSupportedException {
		// TODO Auto-generated method stub
		BeanAdpXmlServlet ret = (BeanAdpXmlServlet)super.clone();
		ret.setName(name);
		return ret;
	}

	/**
	 * @return the aClass
	 */
	public String getAClass() {
		return aClass;
	}
	/**
	 * @param class1 the aClass to set
	 */
	public void setAClass(String class1) {
		aClass = class1;
	}
	/**
	 * @return the authentification
	 */
	public String getAuthentification() {
		return authentification;
	}
	/**
	 * @param authentification the authentification to set
	 */
	public void setAuthentification(String authentification) {
		this.authentification = authentification;
	}
	/**
	 * @return the beanAdpXmlBean
	 */
	public BeanAdpXmlBean getBeanAdpXmlBean() {
		return beanAdpXmlBean;
	}
	/**
	 * @param beanAdpXmlBean the beanAdpXmlBean to set
	 */
	public void setBeanAdpXmlBean(BeanAdpXmlBean beanAdpXmlBean) {
		this.beanAdpXmlBean = beanAdpXmlBean;
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
	 * @return the target
	 */
	public String getTarget() {
		return target;
	}
	/**
	 * @param target the target to set
	 */
	public void setTarget(String target) {
		this.target = target;
	}
	/**
	 * @return the targetError
	 */
	public String getTargetError() {
		return targetError;
	}
	/**
	 * @param targetError the targetError to set
	 */
	public void setTargetError(String targetError) {
		this.targetError = targetError;
	}
}

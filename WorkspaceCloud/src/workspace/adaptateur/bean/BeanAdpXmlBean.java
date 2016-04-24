package workspace.adaptateur.bean;

import java.util.LinkedList;
import java.util.List;

public class BeanAdpXmlBean {
    private String name;
    private String service;
    private String aClass;
    private String scope;
    private BeanAdpXmlQuery beanAdpXmlQuery;
    private String paramName;
    private String paramType;
    private String paramBean;
    private String paramFormatIn;

    public BeanAdpXmlBean() {
		super();
		// TODO Auto-generated constructor stub
	}

	public BeanAdpXmlBean(String name, String service, String class1, String scope, BeanAdpXmlQuery beanAdpXmlQuery, String paramName, String paramType) {
		super();
		this.name = name;
		this.service = service;
		this.aClass = class1;
		this.scope = scope;
		this.beanAdpXmlQuery = beanAdpXmlQuery;
		this.paramName = paramName;
		this.paramType = paramType;
	}

	public BeanAdpXmlBean(String name, String service, String class1, String scope, BeanAdpXmlQuery beanAdpXmlQuery, String paramName, String paramType, String paramBean) {
		super();
		this.name = name;
		this.service = service;
		this.aClass = class1;
		this.scope = scope;
		this.beanAdpXmlQuery = beanAdpXmlQuery;
		this.paramName = paramName;
		this.paramType = paramType;
		this.paramBean = paramBean;
	}

	public BeanAdpXmlBean(String name, String service, String class1, String scope, BeanAdpXmlQuery beanAdpXmlQuery, String paramName, String paramType, String paramBean, String paramFormatIn) {
		super();
		this.name = name;
		this.service = service;
		this.aClass = class1;
		this.scope = scope;
		this.beanAdpXmlQuery = beanAdpXmlQuery;
		this.paramName = paramName;
		this.paramType = paramType;
		this.paramBean = paramBean;
		this.paramFormatIn = paramFormatIn;
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
	 * @return the beanAdpXmlQuery
	 */
	public BeanAdpXmlQuery getBeanAdpXmlQuery() {
		return beanAdpXmlQuery;
	}
	/**
	 * @param beanAdpXmlQuery the beanAdpXmlQuery to set
	 */
	public void setBeanAdpXmlQuery(BeanAdpXmlQuery beanAdpXmlQuery) {
		this.beanAdpXmlQuery = beanAdpXmlQuery;
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
	 * @return the scope
	 */
	public String getScope() {
		return scope;
	}
	/**
	 * @param scope the scope to set
	 */
	public void setScope(String scope) {
		this.scope = scope;
	}
	/**
	 * @return the service
	 */
	public String getService() {
		return service;
	}
	/**
	 * @param service the service to set
	 */
	public void setService(String service) {
		this.service = service;
	}

	/**
	 * @return the paramName
	 */
	public String getParamName() {
		return paramName;
	}

	/**
	 * @param paramName the paramName to set
	 */
	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	/**
	 * @return the paramType
	 */
	public String getParamType() {
		return paramType;
	}

	/**
	 * @param paramType the paramType to set
	 */
	public void setParamType(String paramType) {
		this.paramType = paramType;
	}

	/**
	 * @return the paramBean
	 */
	public String getParamBean() {
		return paramBean;
	}

	/**
	 * @param paramBean the paramBean to set
	 */
	public void setParamBean(String paramBean) {
		this.paramBean = paramBean;
	}

	/**
	 * @return the paramFormatIn
	 */
	public String getParamFormatIn() {
		return paramFormatIn;
	}

	/**
	 * @param paramFormatIn the paramFormatIn to set
	 */
	public void setParamFormatIn(String paramFormatIn) {
		this.paramFormatIn = paramFormatIn;
	}
}

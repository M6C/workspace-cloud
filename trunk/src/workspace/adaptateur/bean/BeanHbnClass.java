package workspace.adaptateur.bean;

import java.io.File;
import java.util.Hashtable;

public class BeanHbnClass {

	private String packageName;
	private String className;
	private String table;
	private Hashtable<String, BeanHbnMeta> hashMeta = new Hashtable<String, BeanHbnMeta>();
	private Hashtable<String, BeanHbnProperty>  hashProperty = new Hashtable<String, BeanHbnProperty>();
	private Hashtable<String, BeanHbnManyToOne>  hashManyToOne = new Hashtable<String, BeanHbnManyToOne>();
	private Hashtable<String, BeanHbnId>  hashId = new Hashtable<String, BeanHbnId>();
	private File file;

	public void addHbnMeta(String key, BeanHbnMeta bean) {
		hashMeta.put(key, bean);
	}

	public void addHbnManyToOne(String key, BeanHbnManyToOne bean) {
		hashManyToOne.put(key, bean);
	}

	public void addHbnProperty(String key, BeanHbnProperty bean) {
		hashProperty.put(key, bean);
	}

	public void addHbnId(String key, BeanHbnId bean) {
		hashId.put(key, bean);
	}

	public BeanHbnMeta getHbnMeta(String key) {
		return hashMeta.get(key);
	}

	public BeanHbnProperty getHbnProperty(String key) {
		return hashProperty.get(key);
	}

	public BeanHbnManyToOne getHbnManyToOne(String key) {
		return hashManyToOne.get(key);
	}

	public BeanHbnId getHbnId(String key) {
		return hashId.get(key);
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
	/**
	 * @return the file
	 */
	public File getFile() {
		return file;
	}
	/**
	 * @param file the file to set
	 */
	public void setFile(File file) {
		this.file = file;
	}
	/**
	 * @return the hashMeta
	 */
	public Hashtable getHashMeta() {
		return hashMeta;
	}
	/**
	 * @param hashMeta the hashMeta to set
	 */
	public void setHashMeta(Hashtable<String, BeanHbnMeta> hashMeta) {
		this.hashMeta = hashMeta;
	}
	/**
	 * @return the hashProperty
	 */
	public Hashtable getHashProperty() {
		return hashProperty;
	}
	/**
	 * @param hashProperty the hashProperty to set
	 */
	public void setHashProperty(Hashtable<String, BeanHbnProperty> hashProperty) {
		this.hashProperty = hashProperty;
	}
	/**
	 * @return the packageName
	 */
	public String getPackageName() {
		return packageName;
	}
	/**
	 * @param packageName the packageName to set
	 */
	public void setPackageName(String packageName) {
		this.packageName = packageName;
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

	/**
	 * @return the hashId
	 */
	public Hashtable<String, BeanHbnId> getHashId() {
		return hashId;
	}

	/**
	 * @param hashId the hashId to set
	 */
	public void setHashId(Hashtable<String, BeanHbnId> hashId) {
		this.hashId = hashId;
	}

	/**
	 * @return the hashManyToOne
	 */
	public Hashtable<String, BeanHbnManyToOne> getHashManyToOne() {
		return hashManyToOne;
	}

	/**
	 * @param hashManyToOne the hashManyToOne to set
	 */
	public void setHashManyToOne(Hashtable<String, BeanHbnManyToOne> hashManyToOne) {
		this.hashManyToOne = hashManyToOne;
	}
	
}

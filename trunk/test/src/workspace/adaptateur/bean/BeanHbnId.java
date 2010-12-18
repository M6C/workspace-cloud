package workspace.adaptateur.bean;

import java.util.List;
import java.util.Vector;

public class BeanHbnId {

	private String name;
	private String type;
	private String column;
	private List<BeanHbnGenerator> listGenerator = new Vector<BeanHbnGenerator>();
	
	public void addHbnGenerator(BeanHbnGenerator bean) {
		listGenerator.add(bean);
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
	 * @return the listGenerator
	 */
	public List<BeanHbnGenerator> getListGenerator() {
		return listGenerator;
	}
	/**
	 * @param listGenerator the listGenerator to set
	 */
	public void setListGenerator(List<BeanHbnGenerator> listGenerator) {
		this.listGenerator = listGenerator;
	}
}

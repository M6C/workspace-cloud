package workspace.service.generator.jsp.db.mysql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import framework.beandata.BeanGenerique;
import framework.convoyeur.CvrField;
import framework.convoyeur.CvrList;
import framework.ressource.Constante;
import framework.ressource.util.UtilString;
import framework.service.SrvGenerique;

public class SrvTableContent extends SrvGenerique {

	  /* (non-Javadoc)
	   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
	   */
	  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
	    HttpSession session = request.getSession();
		ServletContext context = session.getServletContext();
		try {
			String szDbConnectDriver = "com.mysql.jdbc.Driver";
			String szDbConnectUrl = "jdbc:mysql://localhost/db_hibernate";
			String szDbConnectFile = "";
			String szDbConnectUser = "root";
			String szDbConnectPassword = "";
			String szQueryTable = "SELECT * FROM information_schema.TABLES";
			PreparedStatement stmt = null;
			Connection con = null;
			ResultSet res = null;
			Class.forName(szDbConnectDriver);
			con = DriverManager.getConnection(szDbConnectUrl + szDbConnectFile, 
					szDbConnectUser, szDbConnectPassword);
			stmt = con.prepareStatement(szQueryTable);
			res = stmt.executeQuery();
			while (res.next()) {
				ResultSetMetaData rsmd = res.getMetaData();
				for (int i = 1; i <= rsmd.getColumnCount(); i++) {
					String szName = rsmd.getColumnLabel(i);
					res.getObject(i);
					rsmd.getColumnType(i);
					rsmd.getColumnTypeName(i);
				}
			}
		} catch (Exception ex) {
			System.out.println(ex.getMessage());
		}
	}
}
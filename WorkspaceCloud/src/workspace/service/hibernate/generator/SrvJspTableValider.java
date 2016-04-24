package workspace.service.hibernate.generator;

import java.io.File;
import java.io.FileFilter;
import java.io.FileNotFoundException;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.StringWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.List;
import java.util.Vector;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import org.hibernate.cfg.DefaultNamingStrategy;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import workspace.adaptateur.AdpXmlHibernate;
import workspace.adaptateur.AdpXmlServlet;
import workspace.adaptateur.bean.BeanAdpXmlBean;
import workspace.adaptateur.bean.BeanAdpXmlHibernate;
import workspace.adaptateur.bean.BeanAdpXmlParam;
import workspace.adaptateur.bean.BeanAdpXmlQuery;
import workspace.adaptateur.bean.BeanAdpXmlServlet;
import workspace.adaptateur.bean.BeanHbnClass;
import workspace.adaptateur.bean.BeanHbnId;
import workspace.adaptateur.bean.BeanHbnManyToOne;
import workspace.adaptateur.bean.BeanHbnProperty;
import workspace.util.UtilPath;

import framework.beandata.BeanFindList;
import framework.beandata.BeanGenerique;
import framework.convoyeur.CvrData;
import framework.convoyeur.CvrField;
import framework.ressource.FrmWrkServlet;
import framework.ressource.bean.BeanData;
import framework.ressource.util.UtilAction;
import framework.ressource.util.UtilEvalJava;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilSafe;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilXML;
import framework.service.SrvGenerique;
import framework.trace.Trace;

public class SrvJspTableValider extends SrvGenerique {
    
    private Hashtable hbnTableName = new Hashtable();
    private Hashtable hbnFileName = new Hashtable();
    private Hashtable<String, BeanHbnClass> hbnClassByTable = new Hashtable<String, BeanHbnClass>();

      /* (non-Javadoc)
       * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
       */
      public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception {
        HttpSession session = request.getSession();
        ServletContext context = session.getServletContext();
        try {
            Document dom = (Document)session.getAttribute("resultDom");
            String destination = (String)bean.getParameterDataByName("destination");
            String schema = (String)bean.getParameterDataByName("schema");
            Integer cbxCount = (Integer)bean.getParameterDataByName("cbxCount");
            Integer modelCount = (Integer)bean.getParameterDataByName("modelCount");
            String xml = (String)bean.getParameterDataByName("xml");
            String xmldestination = (String)bean.getParameterDataByName("xmldestination");
            String hbnpath = (String)bean.getParameterDataByName("hbnpath");
            if (UtilString.isNotEmpty(destination) &&
                UtilString.isNotEmpty(schema) &&
                UtilString.isNotEmpty(xml) &&
                UtilString.isNotEmpty(xmldestination) &&
                UtilString.isNotEmpty(hbnpath) &&
                (cbxCount!=null && cbxCount.intValue()>0)) {
                File fXml = new File(UtilPath.formatPath(dom, xml));
                File fXmlDestination = new File(UtilPath.formatPath(dom, xmldestination));
                File fDestination = new File(UtilPath.formatPath(dom, destination));
                if (fXml.exists() &&
                	fDestination.exists()) {

                    iniHbnClass(dom, context, hbnpath);

                    DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
                    DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
                    // Build the dom document from file
                    Document resultDom = docBuilder.parse(fXml);

                	request.setAttribute("schema", schema);
                    int iModelCount = modelCount.intValue();
                    for(int i=0 ; i<iModelCount ; i++) {
	                    // Ecrit un fichier par table
                    	resultDom = writeTableColumn (request, response, resultDom, bean, i);
                    }

                    if (resultDom!=null) {
                        // Perform the transformation, sending the output to the response.
                        UtilXML.writeXml(new File(fXmlDestination, fXml.getName()), resultDom);
                    }
                }
            }
        } catch (Exception ex) {
            Trace.ERROR(this, ex);
            System.out.println(ex.getMessage());
        }
    }

      protected Document writeTableColumn (HttpServletRequest request, HttpServletResponse response, Document resultDom, BeanGenerique bean, int cnt) throws FileNotFoundException, IOException, ParserConfigurationException, SAXException, TransformerException {
        HttpSession session = request.getSession();
        Document dom = (Document)session.getAttribute("resultDom");
        ServletContext context = session.getServletContext();
        String destination = (String)bean.getParameterDataByName("destination");
        String xmlpathtarget = (String)bean.getParameterDataByName("xmlpathtarget");
        String model = (String)request.getParameter("model" + cnt);
        String destName = (String)request.getParameter("destName" + cnt); 
        String modelIns = (String)request.getParameter("modelIns" + cnt); 
        String modelUpd = (String)request.getParameter("modelUpd" + cnt); 
        String modelLst = (String)request.getParameter("modelLst" + cnt);
        String modelSel = (String)request.getParameter("modelSel" + cnt); 
        String modelDel = (String)request.getParameter("modelDel" + cnt); 
        String servName = (String)request.getParameter("servName" + cnt);
        String schema = (String)bean.getParameterDataByName("schema");
        Integer cbxCount = (Integer)bean.getParameterDataByName("cbxCount");

        boolean bModelIns = new Boolean("on".equals(modelIns)).booleanValue(); 
        boolean bModelUpd = new Boolean("on".equals(modelUpd)).booleanValue(); 
        boolean bModelLst = new Boolean("on".equals(modelLst)).booleanValue(); 
        boolean bModelSel = new Boolean("on".equals(modelSel)).booleanValue(); 
        boolean bModelDel = new Boolean("on".equals(modelDel)).booleanValue(); 
        int iCbxCount = cbxCount.intValue();
        String szCbxTable, szTxtTableName, szTxtTableFile;
        String szTxtTableNameFk = null;
        String szBeanListName, szBeanItemName, szBeanExecName;
        File fDestination = new File(UtilPath.formatPath(dom, destination));

        String szPathTableFile;//destination.substring(destination.indexOf('/'));
        if (UtilString.isNotEmpty(xmlpathtarget)) {
            szPathTableFile =  xmlpathtarget;
        }
        else {
            szPathTableFile =  destination.substring(destination.indexOf('/'));
        }
        if (!szPathTableFile.endsWith("/"))
            szPathTableFile = szPathTableFile + "/";

        if (UtilString.isNotEmpty(model)) {
            File fModel =  new File(UtilPath.formatPath(dom, model));
            model = UtilFile.read(fModel);
        }
        else {
            model = new StringBuffer("<%@ taglib uri='Framework_Taglib_Html.tld' prefix='html' %>\r\n")
                    .append("<html>\r\n<head>\r\n<title>{TABLE_NAME}</title>\r\n</head>\r\n")
                    .append("<body>\r\n<table>\r\n<tr><td>{FORM_FIELD}</td></tr>\r\n")
                    .append("<tr><td>{TABLE_FOREIGN_KEY_LINK}</td></tr>\r\n</table>\r\n</body>\r\n")
                    .append("</html>").toString();
        }

        List<String> listLoopColumn = UtilString.extractPart(model, "{LOOP_COLUMN_BEGIN", "}", "{LOOP_COLUMN_END", "}");
        List<String> listLoopColumnText = null;
        List<String> listLoopPk = UtilString.extractPart(model, "{LOOP_PRIMARY_KEY_BEGIN", "}", "{LOOP_PRIMARY_KEY_END", "}");
        List<String> listLoopPkText = null;
        List<String> listLoopFk = UtilString.extractPart(model, "{LOOP_FOREIGN_KEY_BEGIN", "}", "{LOOP_FOREIGN_KEY_END", "}");
        List<String> listLoopFkText = null;

        Hashtable<String, String> hashEventName = new Hashtable<String, String>();
        /**
         * Ecriture du fichier XML
         */
        for(int i=1 ; i<=iCbxCount ; i++) {
            szCbxTable = request.getParameter("cbxTable"+i);
            if (UtilString.isEqualsIgnoreCase(szCbxTable, "on")) {
                szTxtTableName = request.getParameter("txtTableName"+i);
                //szTxtTableFile = request.getParameter("txtTableFile"+i);
                if (UtilString.isNotEmpty(szTxtTableName)) {// && UtilString.isNotEmpty(szTxtTableFile)) {
                    szBeanListName = "beanList"+szTxtTableName;
                    szBeanItemName = "beanItem"+szTxtTableName;
                    szBeanExecName = "beanExec"+szTxtTableName;

                    listLoopColumnText = new Vector<String>();
                    for(int j=0 ; j<listLoopColumn.size() ; j++) {
                        listLoopColumnText.add("");
                    }

                    listLoopPkText = new Vector<String>();
                    for(int j=0 ; j<listLoopPk.size() ; j++) {
                        listLoopPkText.add("");
                    }

                    listLoopFkText = new Vector<String>();
                    for(int j=0 ; j<listLoopFk.size() ; j++) {
                    	listLoopFkText.add("");
                    }

                    String szTxtClassName = classNameByTable(dom, context, szTxtTableName);
                    if (UtilString.isEmpty(szTxtClassName))
                        szTxtClassName = szTxtTableName;

                    String szEventLst = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventLst = UtilString.replaceAll(szEventLst, "{TABLE_NAME}", szTxtTableName);
                    szEventLst = UtilString.replaceAll(szEventLst, "{EVENT}", "Lst");

                    String szEventSel = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventSel = UtilString.replaceAll(szEventSel, "{TABLE_NAME}", szTxtTableName);
                    szEventSel = UtilString.replaceAll(szEventSel, "{EVENT}", "Sel");

                    String szEventAdd = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventAdd = UtilString.replaceAll(szEventAdd, "{TABLE_NAME}", szTxtTableName);
                    szEventAdd = UtilString.replaceAll(szEventAdd, "{EVENT}", "Add");

                    String szEventUpd = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventUpd = UtilString.replaceAll(szEventUpd, "{TABLE_NAME}", szTxtTableName);
                    szEventUpd = UtilString.replaceAll(szEventUpd, "{EVENT}", "Upd");

                    String szEventDel = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventDel = UtilString.replaceAll(szEventDel, "{TABLE_NAME}", szTxtTableName);
                    szEventDel = UtilString.replaceAll(szEventDel, "{EVENT}", "Del");

                    String szItemName = schema+szTxtTableName;
                    request.setAttribute("table", szTxtTableName);
                    BeanFindList beanColumnList = (BeanFindList)loadBean(request, response, "beanColumnList");
                    if (beanColumnList!=null) {
                        CvrData cvr;
                        String szColumnName, szFieldName, szNullable, szKey, szDefault, szExtra, szDataType;
                        StringBuffer sbSqlPkHbn = new StringBuffer();
                        StringBuffer sbSqlPkSql = new StringBuffer();
                        int iSqlPk = 0;
                        StringBuffer sbSqlCol = new StringBuffer();
                        StringBuffer sbSqlUpd = new StringBuffer();
                        StringBuffer sbSqlInsCol = new StringBuffer();
                        StringBuffer sbSqlInsVal = new StringBuffer();
                        String paramName = "", paramType = "", paramFormatIn = "";
                        String paramNamePk = "", paramTypePk = "", paramFormatInPk = "";
                        String paramNameIns = "", paramTypeIns = "", paramFormatInIns = "";
                        int iSqlCol = 0, iSqlUpd = 0, iSqlIns = 0;
                        Long lMaxLength = null;
                        List<BeanAdpXmlBean> listAdpXmlBeanSel = new ArrayList<BeanAdpXmlBean>();
                        for(int j=0 ; j<beanColumnList.getSize() ; j++) {
                            cvr = (CvrData)UtilSafe.safeListGetElementAt(beanColumnList, j);
                            szColumnName = (String)((CvrField)cvr.get("COLUMN_NAME")).getData();
                            lMaxLength = (Long)((CvrField)cvr.get("CHARACTER_MAXIMUM_LENGTH")).getData();
                            szNullable = (String)((CvrField)cvr.get("IS_NULLABLE")).getData();
                            szDefault = (String)((CvrField)cvr.get("COLUMN_DEFAULT")).getData();
                            szKey = (String)((CvrField)cvr.get("COLUMN_KEY")).getData();
                            szExtra = (String)((CvrField)cvr.get("EXTRA")).getData();
                            szDataType = (String)((CvrField)cvr.get("DATA_TYPE")).getData();
                            if (UtilString.isEqualsIgnoreCase(szKey, "PRI")) {
                                szFieldName = idNameByColumn(dom, szTxtTableName, szColumnName);
                                //sbTableColumn.append("");
                                //Ajout les clamp;eacute;s primaires dans les clauses Where
                                if (iSqlPk>0) {
                                    sbSqlPkHbn.append(" AND");
                                    sbSqlPkSql.append(" AND");
                                }
                                sbSqlPkHbn.append(" ").append(szFieldName).append(" = :").append(szFieldName);
                                //sbSqlPkSql.append(" ").append(szColumnName).append(" = :").append(szFieldName);
                                sbSqlPkSql.append(" ").append(szColumnName).append(" = ?");
                                iSqlPk++;
                                paramNamePk += szFieldName + ";";
                                paramTypePk += "INTEGER" + ";";
                                paramFormatInPk += ";";
                            }
                            else {
                                szFieldName = fieldNameByColumn(dom, szTxtTableName, szColumnName);

                                if (UtilString.isEqualsIgnoreCase(szKey, "MUL") && (listLoopFk.size()>0)) {
                                    if (bModelSel) {
                                        request.setAttribute("column", szColumnName);
                                        BeanFindList beanFkColumnList = (BeanFindList)loadBean(request, response, "beanFkColumnList");
                                        cvr = (CvrData)UtilSafe.safeListGetElementAt(beanFkColumnList, 0);
                                        String szRefSchemaName = (String)((CvrField)cvr.get("TABLE_SCHEMA")).getData();
                                        String szRefTableName = (String)((CvrField)cvr.get("TABLE_NAME")).getData();
                                        String szRefColumnName = (String)((CvrField)cvr.get("COLUMN_NAME")).getData();
                                    	if (UtilString.isNotEmpty(szRefSchemaName) &&
                                    		UtilString.isNotEmpty(szRefTableName) &&
                                    		UtilString.isNotEmpty(szRefColumnName)) {

                                            String szBeanItemNameFk = "beanItem"+szRefTableName;
                                            String szTxtClassNameFk = classNameByTable(dom, context, szRefTableName);
                                            String szFieldNameFk = idNameByColumn(dom, szRefTableName, szRefColumnName);

                                            szFieldName = manyToOneNameByColumn(dom, szTxtTableName, szColumnName);

                                            String paramNameFk = szFieldNameFk;
                                            String paramTypeFk = "INTEGER";
                                            String paramBeanFk = szBeanItemName + "." + szFieldName;
                                    		String szQuery = "FROM "+szTxtClassNameFk; 
    	                                    szQuery += " WHERE " + szFieldNameFk + " = :" + szFieldNameFk;
	    	                                BeanAdpXmlQuery beanAdpXmlQuery = new BeanAdpXmlQuery("HIBERNATE", szQuery, "1");
	    	                                BeanAdpXmlBean beanAdpXmlBean = new BeanAdpXmlBean(szBeanItemNameFk, "framework.service.SrvFindData", "framework.beandata.BeanFindData", "request", beanAdpXmlQuery, paramNameFk, paramTypeFk, paramBeanFk);
	    	                                listAdpXmlBeanSel.add(beanAdpXmlBean);
                                    	}
                                    }
                                }

                                //Ajout les colonnes de selection
                                if (iSqlCol>0)
                                    sbSqlCol.append(" ,"); 
                                sbSqlCol.append(" ").append(szColumnName);
                                iSqlCol++;

                                //Ajout les colonnes de mise à jour
                                if (iSqlUpd>0)
                                    sbSqlUpd.append(" ,"); 
                                //sbSqlUpd.append(" ").append(szColumnName).append(" = :").append(szFieldName);
                                sbSqlUpd.append(" ").append(szColumnName).append(" = ?");
                                iSqlUpd++;

                                //Ajout les colonnes d'insertion
                                if (iSqlIns>0) {
                                    sbSqlInsCol.append(" ,");
                                    sbSqlInsVal.append(" ,");
                                }
                                sbSqlInsCol.append(" ").append(szColumnName);
                                //sbSqlInsVal.append(" :").append(szFieldName);
                                sbSqlInsVal.append(" ?");
                                paramName += szFieldName + ";";
                                paramType += convertDataType(szDataType) + ";";
                                paramFormatIn += defaultFormatIn(szDataType) + ";";
                                iSqlIns++;
                            }
                        }
                        paramNameIns = paramName;
                        paramTypeIns = paramType;
                        paramFormatInIns = paramFormatIn;
                        paramName += paramNamePk;
                        paramType += paramTypePk;
                        paramFormatIn += paramFormatInPk;
                        if (!paramName.equals("")) paramName = paramName.substring(0, paramName.length()-1);
                        if (!paramType.equals("")) paramType = paramType.substring(0, paramType.length()-1);
                        if (!paramFormatIn.equals("")) paramFormatIn = paramFormatIn.substring(0, paramFormatIn.length()-1);
                        if (!paramNamePk.equals("")) paramNamePk = paramNamePk.substring(0, paramNamePk.length()-1);
                        if (!paramTypePk.equals("")) paramTypePk = paramTypePk.substring(0, paramTypePk.length()-1);
                        if (!paramFormatInPk.equals("")) paramFormatInPk = paramFormatInPk.substring(0, paramFormatInPk.length()-1);
                        if (!paramNameIns.equals("")) paramNameIns = paramNameIns.substring(0, paramNameIns.length()-1);
                        if (!paramTypeIns.equals("")) paramTypeIns = paramTypeIns.substring(0, paramTypeIns.length()-1);
                        if (!paramFormatInIns.equals("")) paramFormatInIns = paramFormatInIns.substring(0, paramFormatInIns.length()-1);

                        //if (UtilString.isNotEmpty(destName)) {
                        szTxtTableFile = UtilString.replaceAll(destName, "{SCHEMA}", schema);
                        szTxtTableFile = UtilString.replaceAll(destName, "{TABLE_NAME}", szTxtTableName);
                        //}

                        if (resultDom!=null) {
                            try {
                                String szQuery = null;
                                BeanAdpXmlQuery beanAdpXmlQuery = null;
                                BeanAdpXmlBean beanAdpXmlBeanGlobal = null;
                                BeanAdpXmlBean beanAdpXmlBean = null;
                                BeanAdpXmlServlet beanAdpXmlServlet = null;
                                if (bModelLst) {
	                                szQuery = "FROM "+szTxtClassName; 
	                                beanAdpXmlQuery = new BeanAdpXmlQuery("HIBERNATE", szQuery, "0");
	                                beanAdpXmlBeanGlobal = new BeanAdpXmlBean(szBeanListName, "framework.service.SrvFindList", "framework.beandata.BeanFindList", "request", beanAdpXmlQuery, null, null);
	                                resultDom = AdpXmlServlet.addBeanDom(context, resultDom, beanAdpXmlBeanGlobal);
	
	                                //BeanAdpXmlBean beanAdpXmlBean = new BeanAdpXmlBean(szBeanListName, "framework.service.SrvFindList", "framework.beandata.BeanFindList", "request", beanAdpXmlQuery, null, null);
	                                //BeanAdpXmlBean beanAdpXmlBeanGlobal = beanAdpXmlBean;
	                                beanAdpXmlBean = new BeanAdpXmlBean(szBeanListName, null, null, null, null, null, null);
	                                beanAdpXmlServlet = new BeanAdpXmlServlet(szEventLst, "", szPathTableFile+szTxtTableFile, "", "false", beanAdpXmlBean);
	                                resultDom = AdpXmlServlet.addServletDom(context, resultDom, beanAdpXmlServlet);
	                                beanAdpXmlBean.setBeanAdpXmlQuery(null);
	                                beanAdpXmlServlet.setBeanAdpXmlBean(null);
                                }

                                if (bModelSel) {
	                                szQuery = "FROM "+szTxtClassName; 
	                                if(iSqlPk>0)
	                                    szQuery += " WHERE" + sbSqlPkHbn.toString();
	                                beanAdpXmlQuery = new BeanAdpXmlQuery("HIBERNATE", szQuery, Integer.toString(iSqlPk));
	                                beanAdpXmlBean = new BeanAdpXmlBean(szBeanItemName, "framework.service.SrvFindData", "framework.beandata.BeanFindData", "request", beanAdpXmlQuery, paramNamePk, paramTypePk, null, paramFormatInPk);
	                                beanAdpXmlServlet = new BeanAdpXmlServlet(szEventSel, "", szPathTableFile+szTxtTableFile, "", "false", beanAdpXmlBean);
	                                resultDom = AdpXmlServlet.addServletDom(context, resultDom, beanAdpXmlServlet);
	                                resultDom = AdpXmlServlet.addServletBeanGlobalDom(context, resultDom, beanAdpXmlServlet, beanAdpXmlBeanGlobal);
	                                beanAdpXmlBean.setBeanAdpXmlQuery(null);
	                                beanAdpXmlServlet.setBeanAdpXmlBean(null);

	                                for(int j=0 ; j<listAdpXmlBeanSel.size() ; j++) {
		                                resultDom = AdpXmlServlet.addServletBeanDom(context, resultDom, beanAdpXmlServlet, listAdpXmlBeanSel.get(j));
	                                }
                                }

                                if (bModelIns) {
	                                szQuery = "INSERT INTO " + szTxtTableName + " (" + sbSqlInsCol.toString() + ") VALUES (" + sbSqlInsVal.toString() + ")";
	                                beanAdpXmlQuery = new BeanAdpXmlQuery("EXECUTE", szQuery, Integer.toString(iSqlIns));
	                                beanAdpXmlBean = new BeanAdpXmlBean(szBeanExecName, "framework.service.SrvDatabase", "framework.beandata.BeanFindData", "request", beanAdpXmlQuery, paramNameIns, paramTypeIns, null, paramFormatInIns);
	                                beanAdpXmlServlet = new BeanAdpXmlServlet(szEventAdd, "", szPathTableFile+szTxtTableFile, "", "false", beanAdpXmlBean);
	                                resultDom = AdpXmlServlet.addServletDom(context, resultDom, (BeanAdpXmlServlet)beanAdpXmlServlet.clone(szEventAdd));
	                                resultDom = AdpXmlServlet.addServletBeanGlobalDom(context, resultDom, beanAdpXmlServlet, beanAdpXmlBeanGlobal);
	                                beanAdpXmlBean.setBeanAdpXmlQuery(null);
	                                beanAdpXmlServlet.setBeanAdpXmlBean(null);
                                }

                                if(iSqlPk>0) {
                                	if (bModelDel) {
	                                    szQuery = "DELETE FROM " + szTxtTableName + " WHERE" + sbSqlPkSql.toString();
	                                    beanAdpXmlQuery = new BeanAdpXmlQuery("EXECUTE", szQuery, Integer.toString(iSqlPk));
	                                    beanAdpXmlBean = new BeanAdpXmlBean(szBeanExecName, "framework.service.SrvDatabase", "framework.beandata.BeanFindData", "request", beanAdpXmlQuery, paramNamePk, paramTypePk, null, paramFormatInPk);
	                                    beanAdpXmlServlet = new BeanAdpXmlServlet(szEventDel, "", szPathTableFile+szTxtTableFile, "", "false", beanAdpXmlBean);
	                                    resultDom = AdpXmlServlet.addServletDom(context, resultDom, (BeanAdpXmlServlet)beanAdpXmlServlet.clone(szEventDel));
	                                    resultDom = AdpXmlServlet.addServletBeanGlobalDom(context, resultDom, beanAdpXmlServlet, beanAdpXmlBeanGlobal);
	                                    beanAdpXmlBean.setBeanAdpXmlQuery(null);
	                                    beanAdpXmlServlet.setBeanAdpXmlBean(null);
                                	}

                                	if (bModelUpd) {
	                                    szQuery = "UPDATE " + szTxtTableName + " SET " + sbSqlUpd.toString() + " WHERE" + sbSqlPkSql.toString();
	                                    beanAdpXmlQuery = new BeanAdpXmlQuery("EXECUTE", szQuery, Integer.toString(iSqlIns+iSqlPk));
	                                    beanAdpXmlBean = new BeanAdpXmlBean(szBeanExecName, "framework.service.SrvDatabase", "framework.beandata.BeanFindData", "request", beanAdpXmlQuery, paramName, paramType, null, paramFormatIn);
	                                    beanAdpXmlServlet = new BeanAdpXmlServlet(szEventUpd, "", szPathTableFile+szTxtTableFile, "", "false", beanAdpXmlBean);
	                                    resultDom = AdpXmlServlet.addServletDom(context, resultDom, (BeanAdpXmlServlet)beanAdpXmlServlet.clone(szEventUpd));
	                                    resultDom = AdpXmlServlet.addServletBeanGlobalDom(context, resultDom, beanAdpXmlServlet, beanAdpXmlBeanGlobal);
	                                    beanAdpXmlBean.setBeanAdpXmlQuery(null);
	                                    beanAdpXmlServlet.setBeanAdpXmlBean(null);
                                	}
                                }
                            } catch (CloneNotSupportedException e) {
                                // TODO Auto-generated catch block
                                Trace.ERROR(this, e);
                            }
                        }
                    }
                }
            }
        }

        /**
         * Ecriture des pages JSP
         */
        for(int i=1 ; i<=iCbxCount ; i++) {
            szCbxTable = request.getParameter("cbxTable"+i);
            if (UtilString.isEqualsIgnoreCase(szCbxTable, "on")) {
                szTxtTableName = request.getParameter("txtTableName"+i);
                //szTxtTableFile = request.getParameter("txtTableFile"+i);
                if (UtilString.isNotEmpty(szTxtTableName)) {// && UtilString.isNotEmpty(szTxtTableFile)) {
                    szBeanListName = "beanList"+szTxtTableName;
                    szBeanItemName = "beanItem"+szTxtTableName;
                    szBeanExecName = "beanExec"+szTxtTableName;

                    listLoopColumnText = new Vector<String>();
                    for(int j=0 ; j<listLoopColumn.size() ; j++) {
                        listLoopColumnText.add("");
                    }

                    listLoopPkText = new Vector<String>();
                    for(int j=0 ; j<listLoopPk.size() ; j++) {
                        listLoopPkText.add("");
                    }

                    listLoopFkText = new Vector<String>();
                    for(int j=0 ; j<listLoopFk.size() ; j++) {
                    	listLoopFkText.add("");
                    }

                    String szTxtClassName = classNameByTable(dom, context, szTxtTableName);
                    if (UtilString.isEmpty(szTxtClassName))
                        szTxtClassName = szTxtTableName;

                    String szEventLst = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventLst = UtilString.replaceAll(szEventLst, "{TABLE_NAME}", szTxtTableName);
                    szEventLst = UtilString.replaceAll(szEventLst, "{EVENT}", "Lst");

                    String szEventSel = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventSel = UtilString.replaceAll(szEventSel, "{TABLE_NAME}", szTxtTableName);
                    szEventSel = UtilString.replaceAll(szEventSel, "{EVENT}", "Sel");

                    String szEventAdd = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventAdd = UtilString.replaceAll(szEventAdd, "{TABLE_NAME}", szTxtTableName);
                    szEventAdd = UtilString.replaceAll(szEventAdd, "{EVENT}", "Add");

                    String szEventUpd = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventUpd = UtilString.replaceAll(szEventUpd, "{TABLE_NAME}", szTxtTableName);
                    szEventUpd = UtilString.replaceAll(szEventUpd, "{EVENT}", "Upd");

                    String szEventDel = UtilString.replaceAll(servName, "{SCHEMA}", schema);
                    szEventDel = UtilString.replaceAll(szEventDel, "{TABLE_NAME}", szTxtTableName);
                    szEventDel = UtilString.replaceAll(szEventDel, "{EVENT}", "Del");

                    String szItemName = schema+szTxtTableName;
                    request.setAttribute("table", szTxtTableName);
                    BeanFindList beanColumnList = (BeanFindList)loadBean(request, response, "beanColumnList");
                    if (beanColumnList!=null) {
                        CvrData cvr;
                        String szColumnName, szFieldName, szNullable, szKey, szDefault, szExtra;
                        String paramHrefPk = "";
                        Long lMaxLength = null;
                        for(int j=0 ; j<beanColumnList.getSize() ; j++) {
                            cvr = (CvrData)UtilSafe.safeListGetElementAt(beanColumnList, j);
                            szColumnName = (String)((CvrField)cvr.get("COLUMN_NAME")).getData();
                            lMaxLength = (Long)((CvrField)cvr.get("CHARACTER_MAXIMUM_LENGTH")).getData();
                            szNullable = (String)((CvrField)cvr.get("IS_NULLABLE")).getData();
                            szDefault = (String)((CvrField)cvr.get("COLUMN_DEFAULT")).getData();
                            szKey = (String)((CvrField)cvr.get("COLUMN_KEY")).getData();
                            szExtra = (String)((CvrField)cvr.get("EXTRA")).getData();
                            if (UtilString.isEqualsIgnoreCase(szKey, "PRI")) {
                                szFieldName = idNameByColumn(dom, szTxtTableName, szColumnName);
                                paramHrefPk += szFieldName + "=#R$" + szItemName + "." + szFieldName + "#&";

                                for (int k=0 ; k<listLoopPk.size() ; k++) {
                                    String txt = listLoopPk.get(k);
                                    txt = UtilString.replaceAll(txt, "{COLUMN_NAME}", szFieldName);
                                    txt = listLoopPkText.get(k)+txt;
                                    listLoopPkText.remove(k);
                                    listLoopPkText.add(k, txt);
                                }
                            }
                            else {

                                if (UtilString.isEqualsIgnoreCase(szKey, "MUL") && (listLoopFk.size()>0)) {
                                    szFieldName = manyToOneNameByColumn(dom, szTxtTableName, szColumnName);
                                    request.setAttribute("column", szColumnName);
                                    BeanFindList beanFkColumnList = (BeanFindList)loadBean(request, response, "beanFkColumnList");
                                    cvr = (CvrData)UtilSafe.safeListGetElementAt(beanFkColumnList, 0);
                                    String szRefSchemaName = (String)((CvrField)cvr.get("TABLE_SCHEMA")).getData();
                                    String szRefTableName = (String)((CvrField)cvr.get("TABLE_NAME")).getData();
                                    String szRefColumnName = (String)((CvrField)cvr.get("COLUMN_NAME")).getData();
                                	if (UtilString.isNotEmpty(szRefSchemaName) &&
                                		UtilString.isNotEmpty(szRefTableName) &&
                                		UtilString.isNotEmpty(szRefColumnName)) {
                                        String szBeanItemNameFk = "beanItem"+szRefTableName;
                                        String szRefTableObjectName = classNameByTable(dom, context, szRefTableName);
                                        String szRefColumnObjectName = idNameByColumn(dom, szRefTableName, szRefColumnName);
	                                	// FOREIGN KEY
		                                for (int k=0 ; k<listLoopFk.size() ; k++) {
		                                    String txt = listLoopFk.get(k);
		                                    if (evalCondition(txt, cvr)) {
			                                    txt = UtilString.replaceAll(txt, "{COLUMN_NAME}", szFieldName);
			                                    txt = UtilString.replaceAll(txt, "{BEAN_ITEM_FK}", szBeanItemNameFk);
			                                    txt = UtilString.replaceAll(txt, "{SCHEMA_FK}", szRefSchemaName);
			                                    txt = UtilString.replaceAll(txt, "{TABLE_NAME_FK}", szRefTableName);
			                                    txt = UtilString.replaceAll(txt, "{COLUMN_NAME_FK}", szRefColumnObjectName);
			                                    txt = listLoopFkText.get(k)+txt;
			                                    listLoopFkText.remove(k);
			                                    listLoopFkText.add(k, txt);
		                                    }
		                                }
                                	}
                                }
                                else {
                                    szFieldName = fieldNameByColumn(dom, szTxtTableName, szColumnName);
                                    if (UtilString.isNotEmpty(szFieldName)) {
	                                	// COLUMN
		                                for (int k=0 ; k<listLoopColumn.size() ; k++) {
		                                    String txt = listLoopColumn.get(k);
		                                    txt = UtilString.replaceAll(txt, "{COLUMN_NAME}", szFieldName);
		                                    txt = listLoopColumnText.get(k)+txt;
		                                    listLoopColumnText.remove(k);
		                                    listLoopColumnText.add(k, txt);
		                                }
                                    }
                                }
                            }
                        }
                        if (!paramHrefPk.equals("")) paramHrefPk = paramHrefPk.substring(0, paramHrefPk.length()-1);

                        String html = model.toString();

                        for(int k=0 ; k<listLoopColumn.size() ; k++) {
                            String col = listLoopColumn.get(k);
                            String txt = listLoopColumnText.get(k);
                            html = UtilString.replaceAll(html, col, txt);
                        }

                        for(int k=0 ; k<listLoopPk.size() ; k++) {
                            String col = listLoopPk.get(k);
                            String txt = listLoopPkText.get(k);
                            html = UtilString.replaceAll(html, col, txt);
                        }

                        for(int k=0 ; k<listLoopFk.size() ; k++) {
                            String col = listLoopFk.get(k);
                            String txt = listLoopFkText.get(k);
                            html = UtilString.replaceAll(html, col, txt);
                        }

                        html = UtilString.replaceAll(html, "{SCHEMA}", schema);
                        html = UtilString.replaceAll(html, "{TABLE_NAME}", szTxtTableName);
                        html = UtilString.replaceAll(html, "{EVENT_LST}", szEventLst);
                        html = UtilString.replaceAll(html, "{EVENT_SEL}", szEventSel);
                        html = UtilString.replaceAll(html, "{EVENT_ADD}", szEventAdd);
                        html = UtilString.replaceAll(html, "{EVENT_UPD}", szEventUpd);
                        html = UtilString.replaceAll(html, "{EVENT_DEL}", szEventDel);
                        html = UtilString.replaceAll(html, "{BEAN_LIST}", szBeanListName);
                        html = UtilString.replaceAll(html, "{BEAN_LIST_ITEM}", szItemName);
                        html = UtilString.replaceAll(html, "{BEAN_ITEM}", szBeanItemName);
                        html = UtilString.replaceAll(html, "{HREF_PK}", paramHrefPk);
                        html = UtilString.replaceAll(html, "{LOOP_COLUMN_BEGIN", "}", "");
                        html = UtilString.replaceAll(html, "{LOOP_COLUMN_END", "}", "");
                        html = UtilString.replaceAll(html, "{LOOP_PRIMARY_KEY_BEGIN", "}", "");
                        html = UtilString.replaceAll(html, "{LOOP_PRIMARY_KEY_END", "}", "");
                        html = UtilString.replaceAll(html, "{LOOP_FOREIGN_KEY_BEGIN", "}", "");
                        html = UtilString.replaceAll(html, "{LOOP_FOREIGN_KEY_END", "}", "");

                        //if (UtilString.isNotEmpty(destName)) {
                        szTxtTableFile = UtilString.replaceAll(destName, "{SCHEMA}", schema);
                        szTxtTableFile = UtilString.replaceAll(destName, "{TABLE_NAME}", szTxtTableName);
                        //}
                        UtilFile.write(new File(fDestination, szTxtTableFile), html);
                    }
                }
            }
        }
        return resultDom;
    }
    
    protected BeanGenerique loadBean(HttpServletRequest request, HttpServletResponse response, String beanName) {
        BeanGenerique ret = null;
        BeanData beanData = FrmWrkServlet.getBean(beanName);
        if (beanData!=null) {
            try {
                ret = UtilAction.newBean(beanData);
                if (ret!=null) {
                    ret.setBeanData(beanData);
                    UtilAction.executeService(request, response, beanData, ret);
                }
            } catch (ClassNotFoundException e) {
                // TODO Auto-generated catch block
                Trace.ERROR(this, e);
            } catch (InstantiationException e) {
                // TODO Auto-generated catch block
                Trace.ERROR(this, e);
            } catch (IllegalAccessException e) {
                // TODO Auto-generated catch block
                Trace.ERROR(this, e);
            } catch (Exception e) {
                // TODO Auto-generated catch block
                Trace.ERROR(this, e);
            }
        }
        return ret;
    }

    private String classNameByTable(Document dom, ServletContext context, String table) throws IOException, SAXException, ParserConfigurationException, TransformerException {
        String ret = null;
        BeanHbnClass bean = hbnClassByTable.get(table);
        if (bean!=null) {
            ret = bean.getClassName();
        }
        return ret;
    }

    private String fieldNameByColumn(Document dom, String table, String column) throws IOException, SAXException, ParserConfigurationException, TransformerException {
        String ret = null;
        BeanHbnClass bean = hbnClassByTable.get(table);
        if (bean!=null) {
            BeanHbnProperty beanProperty = bean.getHbnProperty(column);
            if (beanProperty!=null) {
                ret = beanProperty.getName();
            }
        }
        return ret;
    }

    private String manyToOneNameByColumn(Document dom, String table, String column) throws IOException, SAXException, ParserConfigurationException, TransformerException {
        String ret = null;
        BeanHbnClass bean = hbnClassByTable.get(table);
        if (bean!=null) {
            BeanHbnManyToOne beanManyToOne = bean.getHbnManyToOne(column);
            if (beanManyToOne!=null) {
                ret = beanManyToOne.getName();
            }
        }
        return ret;
    }

    private String idNameByColumn(Document dom, String table, String column) throws IOException, SAXException, ParserConfigurationException, TransformerException {
        String ret = null;
        BeanHbnClass bean = hbnClassByTable.get(table);
        if (bean!=null) {
            BeanHbnId beanId = bean.getHbnId(column);
            if (beanId!=null) {
                ret = beanId.getName();
            }
        }
        return ret;
    }

    private void iniHbnClass(Document dom, ServletContext context, String hbnpath) throws IOException, SAXException, ParserConfigurationException, TransformerException {
    	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	SimpleDateFormat timeFormat = new SimpleDateFormat("HH:mm:ss");
    	Calendar calDeb = Calendar.getInstance();
    	Date dateDiff = null;
    	System.out.println("iniHbnClass Start At " + dateFormat.format(calDeb.getTime()));
        // Cramp;eacute;ation des outils de Parse du fichier XML
        DocumentBuilderFactory docBuilderFactory = DocumentBuilderFactory.newInstance();
        DocumentBuilder docBuilder = docBuilderFactory.newDocumentBuilder();
        FilenameFilter filenameFilter = null;
        int iLastIndexOf = hbnpath.lastIndexOf('\\');
    	if (iLastIndexOf<0)
    		iLastIndexOf = hbnpath.lastIndexOf('/');
        if (iLastIndexOf>0) {
            String szHbnpathFilter = hbnpath.substring(iLastIndexOf);
        	hbnpath = hbnpath.substring(0, iLastIndexOf);
            if (UtilString.isNotEmpty(szHbnpathFilter)) {
                iLastIndexOf = szHbnpathFilter.lastIndexOf('.');
                if (iLastIndexOf>0) {
                    final String ext = szHbnpathFilter.substring(iLastIndexOf);
                    if (UtilString.isNotEmpty(ext)) {
                    	filenameFilter = new FilenameFilter() {
		                    public boolean accept(File file, String string) {
		                      return UtilFile.isExtFile(string, ext);
		                    }
		                  };
                    }
                }
            }
        }
        File fHbnpath = new File(UtilPath.formatPath(dom, hbnpath));
        File[] listFile = fHbnpath.listFiles(filenameFilter);
        Document domHbn = null;
        BeanHbnClass beanHbnClass = null;
        long len = listFile.length;
        String log = "";
        for(int i=0 ; i<len ; i++) {
        	try {
	        	log = "iniHbnClass File:" + listFile[i];
	        	Calendar calFileDeb = Calendar.getInstance();
	        	log += " From:" + dateFormat.format(calFileDeb.getTime());
	            domHbn = docBuilder.parse(listFile[i]);
	            beanHbnClass = AdpXmlHibernate.toBeanHbnByDB(context, domHbn);
	            hbnClassByTable.put(beanHbnClass.getTable(), beanHbnClass);
	        	Calendar calFileEnd = Calendar.getInstance();
	        	dateDiff = new Date(calFileEnd.getTimeInMillis() - calFileDeb.getTimeInMillis());
	        	log += " To:" + dateFormat.format(calFileEnd.getTime()) + " For:" + timeFormat.format(dateDiff) + " Sec";
        	}
        	finally {
        		System.out.println(log);
        		log = "";
        	}
        }
    	Calendar calEnd = Calendar.getInstance();
    	long millSec = calEnd.getTimeInMillis() - calDeb.getTimeInMillis();
    	long sec = millSec/1000;
    	dateDiff = new Date(millSec);
    	System.out.println("iniHbnClass End At " + dateFormat.format(calEnd.getTime()) + " For " + timeFormat.format(dateDiff) + " Time");
    }

    private String convertDataType(String dataType) {
    	String ret = "STRING";
    	if (dataType!=null) {
    		String szDataType = dataType.toUpperCase();
    		//LIST | STRING | CURSOR | INTEGER | BOOLEAN | OBJECT | DATE | TIME | DATETIME
    		if ("VARCHAR".equals(szDataType)) ret = "STRING";
    		else if ("CHAR".equals(szDataType)) ret = "STRING";
    		else if ("LONGTEXT".equals(szDataType)) ret = "STRING";
    		else if ("INT".equals(szDataType)) ret = "INTEGER";
    		else if ("TINYINT".equals(szDataType)) ret = "INTEGER";
    		else if ("SMALLINT".equals(szDataType)) ret = "INTEGER";
    		else if ("BIGINT".equals(szDataType)) ret = "INTEGER";
    		else if ("DATETIME".equals(szDataType)) ret = "DATE";
    		else if ("TIMESTAMP".equals(szDataType)) ret = "DATE";
    	}
    	return ret;
    }
    
    private boolean evalCondition(String condition, CvrData cvr) {
    	boolean ret = true;
    	String part = null;
    	Iterator itPart = UtilString.extractPart(condition,"[", "]").iterator();
    	while(itPart.hasNext() && ret) {
    		part = (String)itPart.next();
    	    Hashtable list = cvr.getList();
    	    Enumeration eKey = list.keys();
    	    Enumeration eVal = list.elements();
    	    while (eKey.hasMoreElements() && eVal.hasMoreElements()) {
    	      String key = (String)eKey.nextElement();
    	      String val = (String)eVal.nextElement();
    	      if (key.toUpperCase().equals("DATA_TYPE"))
    	    	  val = convertDataType(val);
    	      part.replaceAll("{"+key+"}", "\"" + val + "\"");
    		}
    	    try {
    	    	ret = UtilEvalJava.safeResolveBooleanExpression(part);
    	    }
    	    catch (Exception ex) {
    	    	ret = false;
    	    	Trace.ERROR(this, ex);
    	    }
    	}
    	return ret;
    }

    private String defaultFormatIn(String dataType) {
    	String ret = "";
    	if (dataType!=null) {
    		String szDataType = dataType.toUpperCase();
    		//LIST | STRING | CURSOR | INTEGER | BOOLEAN | OBJECT | DATE | TIME | DATETIME
    		if ("DATE".equals(szDataType)) ret = "yyyy.MM.dd";
    		else if ("TIME".equals(szDataType)) ret = "HH:mm:ss";
    		else if ("DATETIME".equals(szDataType)) ret = "yyyy.MM.dd HH:mm:ss";
    	}
    	return ret;
    }
}
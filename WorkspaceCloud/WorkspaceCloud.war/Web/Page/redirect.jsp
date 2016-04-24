<%@ page import="java.net.URL" %>
<%@ page import="java.util.Hashtable" %>
<%@ page import="java.util.Enumeration" %>

<%!
	static final String STR_SERVER = "http://rocadavid.no-ip.info";//"http://172.0.0.1:7001";
	static final String STR_DOMAINE = STR_SERVER+"/WorkSpace";
	static final String STR_WEBAPP_HOME = STR_DOMAINE+"/action.servlet";
	static final String STR_WEBAPP_REDIRECT = STR_WEBAPP_HOME + "?event=Redirect&adresse=";
	static final String STR_WEBAPP_IMAGEREADER = STR_DOMAINE+"/Actionimagereader?file=";

	static final String STR_COMMENT_DEB = "<!--";
	static final String STR_COMMENT_FIN = "-->";

	static final int LEN_COMMENT_DEB = STR_COMMENT_DEB.length();
	static final int LEN_COMMENT_FIN = STR_COMMENT_FIN.length();

	static final char CAR_COT = '"';
	static final char CAR_EQUAL = '=';

		static final int DEBUG_LEVEL_VERY_HIGHT = 4;
		static final int DEBUG_LEVEL_HIGHT = 3;
		static final int DEBUG_LEVEL_MEDIUM = 2;
		static final int DEBUG_LEVEL_LOW = 1;
		static final int DEBUG_LEVEL_NEVER = 0;
	static final int DEBUG = 3;

	StringBuffer trace = new StringBuffer();

		// Liste des liens à ramp;eacute;-amp;eacute;crire
		Hashtable tableLink = new Hashtable();
	static boolean addInputHidden = false;
	static String[] addInputHiddenName;
	static String[] addInputHiddenValue;

	public StringBuffer makeTrace(char car, String tag, String att, String src, boolean isTag, boolean isTagEnd, boolean isAtt, boolean isSrc, boolean isCot) {
	  if (DEBUG>=DEBUG_LEVEL_VERY_HIGHT) {
		trace.append("Char:&nbsp;").append(car).append("<br>").append("\r\n");
		trace.append("&nbsp;-&nbsp;String<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;Tag:&nbsp;").append(tag).append("<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;Att:&nbsp;").append(att).append("<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;Src:&nbsp;").append(src).append("<br>").append("\r\n");
		trace.append("&nbsp;-&nbsp;Boolean<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;isTag:&nbsp;").append(isTag).append("<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;isTagEnd:&nbsp;").append(isTagEnd).append("<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;isAtt:&nbsp;").append(isAtt).append("<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;isSrc:&nbsp;").append(isSrc).append("<br>").append("\r\n");
		trace.append("&nbsp;&nbsp;&nbsp;&nbsp;isCot:&nbsp;").append(isCot).append("<br>").append("\r\n");
		trace.append("<br>");
	  }
	  return trace;
	}

	public String replaceString( String str, String txt1, String txt2 ) {
	  StringBuffer ret = new StringBuffer(str);
	  replace( ret, txt1, txt2 );
	  return ret.toString();
	}

	public void replace( StringBuffer str, String txt1, String txt2 ) {
	  int index = 0;
	  int iTxt1Len = txt1.length();
	  int iTxt2Len = txt2.length();
//		while( (index=str.toString().indexOf(txt1, index))>=0 ) {
	  while( (index=str.toString().indexOf(txt1))>=0 ) {
		str.delete(index, (index+iTxt1Len));
		str.insert(index, txt2);
//		  index+=iTxt2Len;
	  }
	}

	public String cleanString(String str) {
	  StringBuffer ret = new StringBuffer(str);
	  clean(ret);
	  return ret.toString();
	}

	public void clean(StringBuffer ret) {
	  replace(ret, "       ", " ");
	  replace(ret, "    ", " ");
	  replace(ret, "  ", " ");
	  replace(ret, "= ", "=");
	  replace(ret, " =", "=");
	  replace(ret, "> ", ">");
	  replace(ret, "< ", "<");
	  replace(ret, " >", ">");
	  replace(ret, " <", "<");
	  replace(ret, "\n", "");
	  replace(ret, "\r", "");
	  replace(ret, "\t", "");
	  replace(ret, "&nbsp;", " ");
	  replace(ret, "&#160;", " ");
	}

	public String convertUrl(URL url, String tag, String att, String src) {
	  Enumeration en = tableLink.keys();
	  if((src!=null)&&(src.indexOf("://")==-1)) {
		String key = null;
		String[] val = null;
		while(en.hasMoreElements()) {
		  key = (String)en.nextElement();
		  if (key.equalsIgnoreCase(tag)) {
			val = (String[])tableLink.get(key);
			for(int i=0 ; i<val.length ; i++) {
			  if (val[i].equalsIgnoreCase(att)) {
				try {
				  src = new java.net.URL(url, src).toExternalForm();
				  if ("IMG".equalsIgnoreCase(tag))
					src = STR_WEBAPP_IMAGEREADER + java.net.URLEncoder.encode(src, "UTF-8");
				  else if ("FORM".equalsIgnoreCase(tag) && "ACTION".equalsIgnoreCase(att)){
					addInputHidden = true;
					addInputHiddenName = new String[] {"adresse", "event", "aLocal_intForm"};
//					addInputHiddenValue = new String[] {java.net.URLEncoder.encode(src, "UTF-8"), "Redirect"};
					addInputHiddenValue = new String[] {src, "Redirect", "true"};
					src = "/action.servlet";//STR_WEBAPP_HOME;
				  }
				  else
					src = STR_WEBAPP_REDIRECT + java.net.URLEncoder.encode(src, "UTF-8");
				}
				catch(Exception ex) {
					trace.append(src).append("\r\n");
				}
			  }
			}
		  }
		}
	  }
	  return src;
	}

	public String convertPage(URL url, String str) {
	  StringBuffer ret = new StringBuffer();

	  String tag = "", att = "", src = "";
	  boolean isTag = false, isTagEnd = false, isTagName = false, isAtt = false, isSrc = false;
	  boolean isCot = false;
	  int size = str.length();
	  char car;
	  for(int i=0 ; i<size ; i++) {
		car = str.charAt(i);

		if (!isSrc)
		  // Copie le caractere
		  ret.append(car);

		switch(car) {

		  case '<': {
			if (!isCot) {
			  if (!isTag) {
				makeTrace(car, tag, att, src, isTag, isTagEnd, isAtt, isSrc, isCot);
				// Verifi si c'est un debut de commentaire
				if ((i+LEN_COMMENT_DEB<size)&&(str.substring(i, i+LEN_COMMENT_DEB).equals(STR_COMMENT_DEB))) {
				  // Recherche la fin du commentaire
				  int iTmp = str.indexOf(STR_COMMENT_FIN, i);
				  if (iTmp>i) {
					// Copie le commentaire
					ret.append(str.substring(i+1, iTmp + LEN_COMMENT_FIN));
					// Saute jusqu'à la fin du commentaire
					i = iTmp + LEN_COMMENT_FIN - 1;
				  } else {
					// Va a la fin du fichier et termine la boucle
					i = size;
				  }
				}
				else {
				  // Avance jusqu'au debut d'un texte
				  i = runToText(i, size, str, ret);
				  // Sauvegarde le caractère courant
				  car = str.charAt(i);
				  if (car=='/') {
					// Indique que nous somme dans un tag de fin
					isTag = false; isTagEnd = true; isTagName = true; isAtt = false; isSrc = false;
				  }
				  else {
					// Indique que nous somme dans un tag
					isTag = true; isTagEnd = false; isTagName = true; isAtt = false; isSrc = false;
					// Initialise le debut du tag
					tag = String.valueOf(car); att = ""; src = "";
				  }
				  // Copie le caractere
				  ret.append(car);
				}
			  }
			}
			else if (isAtt && isSrc) {
			  src += car;
			}
		  }
		  break;

		  case '>': {
			makeTrace(car, tag, att, src, isTag, isTagEnd, isAtt, isSrc, isCot);
			if (!isCot) {
			  if (isTag) {
				if (isAtt && isSrc) {
					src = convertUrl(url, tag, att, src);
					// Copie la valeur
					ret.append(src);
					// Copie le caractere
					ret.append(car);
					if (addInputHidden) {
					  int iSize = addInputHiddenName.length;
					  for(int ii=0 ; ii<iSize ; ii++){
					    ret.append("<input type=\"hidden\" name=\"").append(addInputHiddenName[ii]).append("\" value=\"").append(addInputHiddenValue[ii]).append("\"/>");
					  }
					  addInputHidden = false;
					}
				}
			  }
			  tag = ""; att = ""; src = "";
			  // Indique que nous somme sorti d'un tag
			  isTag = false; isTagEnd = false; isTagName = false; isAtt = false; isSrc = false;
			}
			else if (isAtt && isSrc) {
			  src += car;
			  // Copie le caractere
			  ret.append(car);
			}
		  }
		  break;

		  case '"': {
			makeTrace(car, tag, att, src, isTag, isTagEnd, isAtt, isSrc, isCot);
			if (isAtt && isSrc && isCot) {
				src = convertUrl(url, tag, att, src);
				// Copie la valeur
				ret.append("\"").append(src).append(car);
				att = ""; src = "";
				// Indique que nous somme dans un tag
				isTag = true; isTagEnd = false; isTagName = false; isAtt = false; isSrc = false;
			}
			isCot = !isCot;
		  }
		  break;

		  case '=': {
			makeTrace(car, tag, att, src, isTag, isTagEnd, isAtt, isSrc, isCot);
			if (!isCot) {
			  if (isAtt) {
				  // Avance jusqu'au debut d'un texte
				  i = runToText(i, size, str, ret);
				  // Sauvegarde le caractère courant
				  car = str.charAt(i);
				  // Verifi si la chaine commance par une cote
				  isCot = (car==CAR_COT);
				  if (!isCot)
					// Initialise le debut de la valeur
					src = String.valueOf(car);
				  // Indique que nous somme dans la valeur de l'attribut
				  isTag = true; isTagEnd = false; isTagName = false; isAtt = true; isSrc = true;
			  }
			}
			else if (isAtt && isSrc) {
			  src += car;
			}
		  }
		  break;

		  case '\t':
		  case ' ': {
			makeTrace(car, tag, att, src, isTag, isTagEnd, isAtt, isSrc, isCot);
			if (!isCot) {
			  if (isTagName) {
				// Indique que nous ne somme plus dans le nom du tag
				isTag = true; isTagEnd = false; isTagName = false; isAtt = false; isSrc = false;
			  }
			  else if (isAtt && isSrc && !isCot) {
				src = convertUrl(url, tag, att, src);
				// Copie la valeur
				ret.append(src);
				// Copie le caractere
				ret.append(car);
				att = ""; src = "";
				// Indique que nous somme dans un tag
				isTag = true; isTagEnd = false; isTagName = false; isAtt = false; isSrc = false;
			  }
			  else if (isAtt) {
				// Avance jusqu'au debut d'un texte
				i = runToText(i, size, str, ret);
				// Sauvegarde le caractère courant
				car = str.charAt(i);
				// Verifi si on a un signe equal
				isAtt = (car==CAR_EQUAL);
				if (!isAtt) {
				  att="";
				  i--;
				} else {
				  // Copie le caractere
				  ret.append(car);
				}
			  }
			}
			else if (isAtt && isSrc) {
			  src += car;
			}
		  }
		  break;

		  case '\r':
		  case '\n':
		  break;

		  default: {
			// Verifi si on est au debut d'un nom d'attribut
			isAtt = (isTag && !isTagEnd && !isTagName && (!isCot || isSrc));

			// Copie le caractere
			if (isSrc)
			  src += car;
			else if (isAtt)
			  att += car;
			else if (isTagName)
			  tag += car;
		  }
		}
	  }
	  return ret.toString();
	}
	protected int runToText(int i, int size, String str, StringBuffer ret) {
	  char car = str.charAt(i);
	  // Avance jusqu'au debut du prochain texte
	  for( ; i<size && (((car=str.charAt(++i))==' ')||(car=='\r')||(car=='\n')||(car=='\t')) ; );
	  return i;
	}
	protected boolean isLocalParameter(String name) {
	  return (name.startsWith("aLocal_")) ||
			 (name.equals("event")) ||
			 (name.equals("adresse"));
	}
	protected String addRequestParameter(HttpServletRequest request, String adresse) {
	  java.util.Enumeration en = request.getParameterNames();
	  String intForm = request.getParameter("aLocal_intForm");
          String sep = (adresse.indexOf('?')>0) ? "&" : "?";
	  while(en.hasMoreElements()) {
            // Get the name of the request parameter
            String name = (String)en.nextElement();
            if (!isLocalParameter(name)) {
              // If the request parameter can appear more than once in the query string, get all values
              String value = request.getParameter(name);
              adresse += sep + name + "=" + value;
              sep = "&";
            }
          }
	  return adresse;
	}

	protected java.net.URL sendFormDataReadResponse(HttpServletRequest request, String adresse, StringBuffer content) throws Exception {
                java.net.URL url = null;
		String intForm = request.getParameter("aLocal_intForm");
		if ("true".equals(intForm)) {
		  // URL of CGI-Bin script.
		  url = new java.net.URL (adresse);
		  // URL connection channel.
		  java.net.HttpURLConnection urlConn = (java.net.HttpURLConnection)url.openConnection();
//		  java.net.URLConnection urlConn = url.openConnection();;
                  // Do POST method request
                  urlConn.setRequestMethod("GET");
		  urlConn.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
		  urlConn.setUseCaches (false);
		  urlConn.setDoOutput (true);
		  urlConn.setDoInput (true);
		  // Send POST output.
		  java.io.DataOutputStream printout = new java.io.DataOutputStream (urlConn.getOutputStream ());
		  String param = "";
		  String sep = "";//(adresse.indexOf('?')>0) ? "&" : "?";
		  java.util.Enumeration en = request.getParameterNames();
		  while(en.hasMoreElements()) {
		    // Get the name of the request parameter
		    String name = (String)en.nextElement();
		    if (!isLocalParameter(name)) {
			  // If the request parameter can appear more than once in the query string, get all values
			  String value = request.getParameter(name);
			  param += sep + name + "=" + java.net.URLEncoder.encode(value, "UTF-8");
			  sep = "&";
		    }
		  }
                  if (param.length()>0) {
                    if (DEBUG>DEBUG_LEVEL_NEVER) {
                      trace.append("Param:").append(param).append("<br>\r\n");
                      trace.append("Param:").append("hl=fr&q=test&btnG=Rechercher&meta=").append("<br>\r\n");
                    }
		    printout.writeBytes (param);
		    printout.flush ();
                  }
		  printout.close ();
		  // Get response data.
		  java.io.DataInputStream input = new java.io.DataInputStream (urlConn.getInputStream());
		  int c = -1;
		  while((c=input.read())!=-1){
			  content.append(c);
                  }
                  input.close ();
/*
	  java.io.InputStream inUrl = url.openStream();
	  java.io.InputStreamReader readUrl = new java.io.InputStreamReader(inUrl);
	  int c = -1;
	  while((c=readUrl.read())!=-1){
	    content.append((char)c);
	  }
          readUrl.close();
          inUrl.close();
*/
	}
	else {
	  adresse = addRequestParameter(request, adresse);
trace.append("Adresse:").append(adresse).append("\r\n");
	  url = new java.net.URL (adresse);
	  java.io.InputStream inUrl = url.openStream();
	  java.io.InputStreamReader readUrl = new java.io.InputStreamReader(inUrl);
	  int c = -1;
	  while((c=readUrl.read())!=-1){
	    content.append((char)c);
	  }
          readUrl.close();
          inUrl.close();
	}
        return url;
      }
%>

<%
// Initialise la liste des liens à ramp;eacute;-amp;eacute;crire
tableLink.put("a", new String[]{"href"});
tableLink.put("form", new String[]{"action"});

String adresse = request.getParameter("adresse");
StringBuffer contentTmp = new StringBuffer();
String content = new String();
trace = new StringBuffer();
if ((adresse!=null)&&(!adresse.equals(""))) {
  try {
    java.net.URL url = sendFormDataReadResponse(request, adresse, contentTmp);
// DEBUT - Convertion des liens contenu dans la page
    if (DEBUG>=DEBUG_LEVEL_HIGHT) {
      System.out.println(contentTmp);
    }
    clean(contentTmp);
    content = convertPage(url, contentTmp.toString());
// FIN - Convertion des liens contenu dans la page
  } catch(Exception ex) {
    if (DEBUG>DEBUG_LEVEL_NEVER) {
      trace.append(new String("Error :<br>"+ex.getMessage()+"<br>"));
      java.io.StringWriter strW =  new java.io.StringWriter();
      ex.printStackTrace(new java.io.PrintWriter(strW));
      trace.append(strW.toString().replaceAll("\r\n", "<br>"));
    }
    else
      ex.printStackTrace();
  }
  finally {
    if (DEBUG>DEBUG_LEVEL_NEVER) {
      System.out.println(trace);
      System.out.println(content);
    }
  }
}
%>
<html>
  <head>
  </head>
  <body>
    <form action="action.servlet">
      <input type="hidden" name="event" value="Redirect"/>
      <table>
        <tr>
          <td>
            Adresse
          </td>
          <td>
            <input type="text" name="adresse" value="<%=adresse%>"/>
          </td>
        </tr>
        <tr>
          <td colspan="2">
            <A href="action.servlet?event=Index&connection=ok">home</A>
            <input type="submit"/>
            &nbsp;
            <input type="reset"/>
          </td>
        </tr>
      </table>
    </form>
    <%if (DEBUG>DEBUG_LEVEL_NEVER) {%>
    <div>
      <%=trace.toString()%>
    </div>
    <%}%>
    <div>
      <%=content.toString()%>
    </div>
  </body>
</html>

<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%!
public class HTMLData{
	protected	StringBufferScanner	data;
	protected	String			location;
	private	HTMLAttributeSet	urlAttributes;
	private OccurrenceReplacer	replacer;
	
	
	/**
	* Construit un nouvel objet HTMLData.
	* @param stream contenu d'une page HTML.
	* @param url adresse absolue de la page.
	* @see java.io.InputStream
	*/
	public HTMLData(InputStream iS, String url){
		location=url;
		
		//conversion du InputStream en StringBufferScanner
		try{
			data=new StringBufferScanner();
			BufferedReader	in=new BufferedReader(new InputStreamReader(iS));
			String 		line;
		
			for(;;){
				line=in.readLine();
				
				if(line==null)
					break;
				data.append(line+" \n");
			}
			
		}catch(IOException e){
			//si ça damp;eacute;raille, on envoie le fragment de code HTML qui sera affichamp;eacute; à la place dans la page
			data=new StringBufferScanner("<html><body><p>Erreur pendant la fusion de cette page</p></body></html>");
		}
	}
	
	/**
	* AJOUT PAR	:	Xavier Onoptchenko
	*				Michael VINGERT
	* Construit un nouvel objet HTMLData.
	* @param String contenu d'une page HTML.
	* @param url adresse absolue de la page.
	*/
	public HTMLData(String page, String url){
		location=url;
		
		try{
			data=new StringBufferScanner();
			BufferedReader	in=new BufferedReader(new StringReader(page));
			String 		line;
		
			for(;;){
				line=in.readLine();
				
				if(line==null)
					break;
				data.append(line+" \n");
			}
			
		}catch(IOException e){
			//si ça damp;eacute;raille, on envoie le fragment de code HTML qui sera affichamp;eacute; à la place dans la page
			data=new StringBufferScanner("<html><body><p>Erreur pendant la fusion de cette page</p></body></html>");
		}
	}
	
	
	/**
	* Retourne les donnamp;eacute;es HTML contenues dans l'objet HTMLData sous forme de chaîne.
	* @return le contenu de la page HTML repramp;eacute;sentamp;eacute;e par le HTMLData.
	*/
	public String getHTMLDataString(){
		return(data.toString());
	}


	
	/**
	* Retourne l'URL de l'emplacement de la page HTML du HTMLData.
	* @return l'URL (thamp;eacute;oriquement absolue) identifiant l'emplacement de la page HTML repramp;eacute;sentamp;eacute;e par l'objet HTMLData.
	*/
	public String getLocation(){
		return(location);
	}
	
	
	/**
	* Modifie l'emplacement d'origine thamp;eacute;orique du document HTML.
	* @param la nouvelle URL (absolue) à affecter à cet objet <code>HTMLData</code>.
	*/
	public void setLocation(String url){
		location=url;
	}

	
	
	/**
	* Retourne la base URL de l'emplacement parent du HTMLData. <br>
	* Exemple : si l'URL du HTMLData est <code>http://serveur.domaine.com/index.html</code>,
	* la base retournamp;eacute;e sera <code>http://serveur.domaine.com/</code>.
	* @return l'URL parente sous forme de <code>String</code>,
	* ou une chaîne vide si aucun emplacement parent ne peut être damp;eacute;terminamp;eacute;.
	*/
	public String getParentLocation(){
		//il suffit de ramp;eacute;cupamp;eacute;rer le damp;eacute;but de la chaine jusqu'au dernier slash ('/').
		int	lastSlash=location.lastIndexOf("/")+1;
		if(lastSlash==-1)
			return("");
		return(location.substring(0,lastSlash));
	}



	/**
	* Retourne une repramp;eacute;sentation de l'objet HTMLData sous forme de chaîne.
	* @return une chaîne qui indique l'emplacement d'origine du document HTML
	* contenu dans cet objet <code>HTMLData</data>.
	*/
	public String toString(){
		return("Le document HTML à l'adresse : "+location);
	}

/*================================================================================================================
					Les mamp;eacute;thodes d'extraction de contenu HTML
================================================================================================================*/

	
	/**
	* Retourne le titre de la page HTML.
	* @return le contenu de la balise HTML <code>title</code>,
	* ou une chaine vide si cette balise n'est pas damp;eacute;finie dans le document.
	*/
	public String getTitle(){
		return(getTagContent("title",false));
	}
	
	
	
	/**
	* Retourne l'en-tête de la page HTML.
	* @param includeHeadTag spamp;eacute;cifie s'il faut inclure les balises <code>head</code>
	* et <code>/head</code> en damp;eacute;but et fin de la chaîne retournamp;eacute;e.
	* @param includeComments spamp;eacute;cifie s'il faut inclure les commentaires HTML rencontramp;eacute;s.
	* @param includeScripts spamp;eacute;cifie s'il faut inclure les damp;eacute;finitions de scripts rencontramp;eacute;es.
	* @return l'en-tête du document HTML damp;eacute;finie par la balise <code>head</code>.
	*/
	public String getHeader(boolean includeHeadTag, boolean includeComments, boolean includeScripts){
		String header=getTagContent("head",includeHeadTag);
		
		if(!includeScripts)
			header=removeTags(header,"script");
		
		if(!includeComments)
			header=removeComments(header);
			
		return(header);
	}
	
	
	
	/**
	* Retourne le corps de la page HTML.
	* @param includeBodyTag spamp;eacute;cifie s'il faut inclure les balises <code>body</code>
	* et <code>/body</code> en damp;eacute;but et fin de la chaîne retournamp;eacute;e.
	* @param includeComments spamp;eacute;cifie s'il faut inclure les commentaires HTML rencontramp;eacute;s.
	* @param includeScripts spamp;eacute;cifie s'il faut inclure les damp;eacute;finitions de scripts rencontramp;eacute;es.
	* @return le corps du document HTML damp;eacute;fini par la balise <code>body</code>.
	*/
	public String getBody(boolean includeBodyTag, boolean includeComments, boolean includeScripts){
		String body=getTagContent("body",includeBodyTag);
		
		if(!includeScripts)
			body=removeScripts(body);
		
		if(!includeComments)
			body=removeComments(body);
			
		return(body);
	}
	
	
	

	/**
	* Retourne le contenu de toutes les balises <code>script</code> du document HTML.
	* @param includeScriptTags spamp;eacute;cifie s'il faut inclure les balises <code>script</code> et <code>/script</code>
	* en damp;eacute;but et fin de chaîne retournamp;eacute;e.
	* @return une chaîne qui contient la concatamp;eacute;nation du contenu de toutes les balises de script
	* rencontramp;eacute;es dans la page HTML, une chaîne vide si aucune n'a amp;eacute;tamp;eacute; trouvamp;eacute;e.
	*/
	public String getScripts(boolean includeScriptTags){
		StringBuffer 	scripts=new StringBuffer();
		int	tmp=data.indexOf("<script"),
			begin=data.indexOf(">",tmp)+1,
			end;
			
		while(tmp!=-1){
			end=data.indexOf("</script>",begin);
			
			//on ramp;eacute;cupère toutes les damp;eacute;clarations de fonctions de la balise
			scripts.append(getOnlyFunctionDeclarationInScriptTag(begin,end));
			
			tmp=data.indexOf("<script",end);
			begin=data.indexOf(">",tmp)+1;
		}
		
		
		if(includeScriptTags)
			(scripts.insert(0,"<script>")).append("</script>");
		
		return(scripts.toString());
	}



			/*----------------------------------------------------------
			Mamp;eacute;thodes privamp;eacute;es utilisamp;eacute;es pour l'extraction de contenu HTML
			----------------------------------------------------------*/
	
	/*
		Retourne seulement les damp;eacute;clarations de fonctions d'une balise script
		comprise entre deux indices.
		(C'est-à-dire tous les blocs de type "function [...] }"
	
	*/
	private String getOnlyFunctionDeclarationInScriptTag(int start, int end){
		StringBuffer	sb=new StringBuffer();
		int	fctIndex=data.indexOf("function ",start,end),
			fctEndIndex;
		
		
		while(fctIndex!=-1){
			fctEndIndex=data.indexOf("}",fctIndex,end)+1;
			sb.append(data.substring(fctIndex,fctEndIndex)+"\n");
			fctIndex=data.indexOf("function ",fctEndIndex,end);
		}
		
		return(sb.toString());
	}
	
	
	
	
	/*
		Retourne sous forme de chaîne le contenu d'une balise spamp;eacute;cifiamp;eacute;e dans le document
		(la première de ce type rencontramp;eacute;e si ce n'est pas une balise unique).
		On peut choisir de retourner ou non dans la chaîne la balise elle-même.
	*/
	private String getTagContent(String tag, boolean includeTag){
		int	begin, end;
		String	tagContent=new String("");
		
		//On cherche les indices de damp;eacute;but et de fin
		//est-ce qu'on retourne aussi la balise englobante ?
		if(includeTag){
			begin=data.indexOf("<"+tag);
			end=data.indexOf(">",data.indexOf("</"+tag,begin))+1;
		}else{
			begin=data.indexOf(">",data.indexOf("<"+tag))+1;
			end=data.indexOf("</"+tag+">",begin);
		}
		
		//si on a trouvamp;eacute; cette balise, on en extrait le contenu
		if(begin>=0)
			tagContent=data.substring(begin,end);
			
		return(tagContent);	
	}
	
	
	
	/*
		Retire d'un fragment de code HTML passamp;eacute; en paramètre
		toutes les occurences d'une balise spamp;eacute;cifiamp;eacute;e.
	*/
	private String removeTags(String str, String tag){
		StringBufferScanner code=new StringBufferScanner(str);
		int	begin=code.indexOf("<"+tag+" "),
			end;
		
		while(begin!=-1){
			end=code.indexOf(">",code.indexOf("</"+tag,begin))+1;
			code.delete(begin,end);
			begin=code.indexOf("<"+tag+" ");
		}
		
		return(code.toString());
	}
	
	
	
	/*
		Retire de la chaîne spamp;eacute;cifiamp;eacute;e toutes les damp;eacute;clarations de fonction JS
		rencontramp;eacute;es dans des balises script.
	*/
	private String removeScripts(String str){
		StringBufferScanner code=new StringBufferScanner(str);
		int	begin=code.indexOf("<script "),
			end;
		
		while(begin!=-1){
			end=code.indexOf("</script>",begin);
			removeFunctionDeclarationsInScriptTag(code,begin,end);
			begin=code.indexOf("<script ",begin+1);
		}
		
		return(code.toString());		
	}


	
	private String removeFunctionDeclarationsInScriptTag(StringBufferScanner code, int start, int end){
		int	fctIndex=code.indexOf("function ",start,end),
			fctEndIndex;
		
		
		while(fctIndex!=-1){
			fctEndIndex=code.indexOf("}",fctIndex,end)+1;
			code.delete(fctIndex,fctEndIndex);
			fctIndex=code.indexOf("function ",fctIndex,end);
		}
		
		return(code.toString());		
	}





	/*
		Retire d'un fragment de code HTML passamp;eacute; en paramètre
		tous les commentaires rencontramp;eacute;s.
	*/
	private String removeComments(String str){
		StringBufferScanner code=new StringBufferScanner(str);
		int	begin=code.indexOf("<!--"),
			end;
		
		while(begin!=-1){
			end=code.indexOf("-->",begin)+3;
			code.delete(begin,end);
			begin=code.indexOf("<!--");
		}
		
		return(code.toString());
	}	
	







	
	
/*================================================================================================================
					Les mamp;eacute;thodes de conversion des URL en absolu
================================================================================================================*/
	
	
	/**
	* Convertit toutes les URL relatives du document HTML en URL absolues, en prenant comme base URL
	* celle de l'URL affectamp;eacute;e à l'objet <code>HTMLData</code>.
	* @param attributeSet un objet <code>HTMLAttributeSet</code> où sont damp;eacute;finis les attributs HTML
	* pouvant contenir des URL.
	* @param anchorReplacer l'objet <code>OccurrenceReplacer</code> chargamp;eacute; d'implamp;eacute;menter
	* le remplacement des noms d'ancre.
	* @see HTMLAttributeSet
	* @see OccurrenceReplacer
	*/
	public void convertRelativeLinksToAbsolute(HTMLAttributeSet attributeSet, OccurrenceReplacer anchorReplacer){
		urlAttributes=attributeSet;
		replacer=anchorReplacer;
		
		//System.out.println("conversion de la page "+location);
		
		for(Enumeration e=urlAttributes.getTags();e.hasMoreElements();){
			convertRelativeLinksToAbsoluteInTags((String)(e.nextElement()));
		}
		
	}
	



				/*---------------------------------------------------
				Mamp;eacute;thodes privamp;eacute;es utilisamp;eacute;es pour la conversion des URL
				---------------------------------------------------*/
			
				
	/*
		Convertit toutes les URL de la page
		contenues dans les attributs d'une balise donnamp;eacute;e.
	*/
	private void convertRelativeLinksToAbsoluteInTags(String tag){
		int	startIndex=0,
			index;
		
		index=data.indexOf("<"+tag+" ");
			
		while(index!=-1){
			startIndex=convertLinksInTagAtIndex(tag, index+(tag.length())+1);
			index=data.indexOf("<"+tag+" ",startIndex);
		}
	}
	
	
	
	/*
		Convertit toutes les URL contenues dans les attributs
		de la balise spamp;eacute;cifiamp;eacute;e s'ouvrant à l'indice donnamp;eacute;.
		Retourne l'indice de fermeture de la balise.
	*/
	private int convertLinksInTagAtIndex(String tag, int tagBeginning){
		Vector attributes=urlAttributes.getAttributes(tag);
		int 	l=attributes.size();
		
		//Pour tous les attributs à URL de la balise
		for(int i=0;i<l;i++){
			String	currentAttribute=(String)(attributes.elementAt(i));
			int	index=data.indexOf(currentAttribute,tagBeginning,">");
		
			//si on a trouvamp;eacute; une occurence de cet attribut
			if(index!=-1){
				//si c'est l'attribut NAME (des balises A ou MAP), c'est un cas spamp;eacute;cial (ancre ou image map)
				if(currentAttribute.equals("name"))
					changeAnchorNameAtIndex(index);
				else
					convertLinkInAttributeAtIndex(index);
			}
		}
		
		//on retourne l'indice de fin du tag pour ne pas repasser par là plus tard
		return(data.indexOf(">",tagBeginning));
	}
	
	
	
	/*
		Remplace le nom d'ancre damp;eacute;fini à l'indice donnamp;eacute;.
	*/
	private void changeAnchorNameAtIndex(int index){
		int	anchorIndex=data.indexOf("=",index)+1,
			anchorEnd;

		//si il y a des guillemets	
		if(data.charAt(anchorIndex)=='"'){
			anchorIndex++;
			anchorEnd=data.indexOf("\"",anchorIndex);
		}
		
		//ou non (alors la fin est marquamp;eacute;e par le premier espace suivant ou la fermeture de la balise)
		else{
			anchorEnd=data.indexOf(" ",anchorIndex);
			if(anchorEnd==-1)
				anchorEnd=data.indexOf(">",anchorIndex);
			else
				anchorEnd=Math.min(anchorEnd,data.indexOf(">",anchorIndex));
		}
		
		replaceAnchorBetween(anchorIndex, anchorEnd);
	}
	
	
	
	/*
		Convertit l'URL figurant dans l'attribut à l'indice donnamp;eacute;.
	*/
	private void convertLinkInAttributeAtIndex(int index){
		int	urlIndex=data.indexOf("=",index)+1,
			urlEnd;
		
		//on extrait les indices de damp;eacute;but et de fin de la chaîne d'url
		
		//si il y a des guillemets
		if(data.charAt(urlIndex)=='"'){
			urlIndex++;
			urlEnd=data.indexOf("\"",urlIndex);
		}
		
		//ou non (alors la fin est marquamp;eacute;e par le premier espace suivant ou la fermeture de la balise)
		else{
			urlEnd=data.indexOf(" ",urlIndex);
			if(urlEnd==-1)
				urlEnd=data.indexOf(">",urlIndex);
			else
				urlEnd=Math.min(urlEnd,data.indexOf(">",urlIndex));
		}
		
		convertURLBetween(urlIndex, urlEnd);
	}
	
	
	
	/*
		Remplace le nom d'ancre situamp;eacute; entre les deux indices spamp;eacute;cifiamp;eacute;s.
	*/
	private void replaceAnchorBetween(int start, int end){
		data.replace(start,end,replacer.getReplacementString(location,data.substring(start,end)));
	}
	
	
	/*
		Convertit l'URL situamp;eacute;e entre les deux indices spamp;eacute;cifiamp;eacute;s.
	*/
	private void convertURLBetween(int start, int end){
		data.replace(start,end,generateAbsoluteURL(data.substring(start,end)));
	}
	
	
	
	/*
		Gamp;eacute;nère l'URL absolue à partir de l'URL d'origine.
	*/
	private String generateAbsoluteURL(String originalURL){
		if(originalURL.indexOf("://")!=-1)		//lien damp;eacute;ja absolu, on ne modifie rien
			return(originalURL);

		if(originalURL.startsWith("javascript:"))	//lien vers une fonction javascript, forcamp;eacute;ment interne
			return(originalURL);				//on ne modifie rien

		if(originalURL.startsWith("mailto:"))		//adresse e-mail, on ne modifie rien
			return(originalURL);
			
		if(originalURL.startsWith("#"))			//lien interne (ancre)
			return("#"+replacer.getReplacementString(location,originalURL.substring(1)));

			
		return(getParentLocation()+originalURL);		//dans tous les autres cas -> lien relatif donc à changer	
	}
	


	

/*================================================================================================================
				Les mamp;eacute;thodes de changement du nom des fonctions JavaScript
================================================================================================================*/


	/**
	* Change les noms de fonction JavaScript de la page de façon à avoir
	* des noms damp;eacute;pendants de l'URL, c'est-à-dire thamp;eacute;oriquement uniques.
	* @param jsReplacer l'objet <code>OccurrenceReplacer</code> chargamp;eacute; d'implamp;eacute;menter
	* le remplacement des noms de fonction.
	* @see OccurrenceReplacer
	*/
	public void changeJavascriptFunctionNames(OccurrenceReplacer jsReplacer){
		replacer=jsReplacer;
		int	tmp=data.indexOf("<script"),
			begin=data.indexOf(">",tmp)+1,
			end;
			
		while(tmp!=-1){
			end=data.indexOf("</script>",begin);
						
			handleScriptTag(begin,end);
			
			tmp=data.indexOf("<script",end);
			begin=data.indexOf(">",tmp)+1;
		}
		
		
	}


			/*--------------------------------------------------------------------
			Mamp;eacute;thodes privamp;eacute;es utilisamp;eacute;es pour le changement des fonctions JavaScript
			--------------------------------------------------------------------*/
				
	/*
		Gère le changement des noms de fonctions JS damp;eacute;finies
		dans la balise script comprise entre les 2 indices spamp;eacute;cifiamp;eacute;s.
	*/
	private void handleScriptTag(int start, int end){
		//une damp;eacute;claration de fonction JS commence forcamp;eacute;ment par le mot clef "function" en minuscules
		int	fctIndex=data.indexOf("function ",start,end);
		int	fctEndIndex;
		String	functionName, newName;
		
		while(fctIndex!=-1){
			//on cherche les indices de damp;eacute;but et de fin du NOM de la fonction
			for(fctIndex=fctIndex+8;data.charAt(fctIndex)==' ';fctIndex++);
			for(fctEndIndex=fctIndex;Character.isLetterOrDigit(data.charAt(fctEndIndex));fctEndIndex++);
			functionName=data.substring(fctIndex,fctEndIndex);

			//on gamp;eacute;nère un nom de remplacement
			newName=replacer.getReplacementString(location,functionName);
			//on fait la substitution...
			data.replace(fctIndex,fctEndIndex,newName);
			//puis on remplace dans tout le reste du document
			replaceFunctionNameInPage(functionName, newName);
			
			fctIndex=data.indexOf("function ",fctEndIndex,end);
		}
	}
	

	
	/*
		Remplace dans toute la page tous les appels à une fonction JS dont le nom est spamp;eacute;cifiamp;eacute;,
		par le nouveau nom passamp;eacute; en paramètre.
	*/
	private void replaceFunctionNameInPage(String name, String newName){
		int	fctIndex=data.indexOf(name),
			fctEndIndex;
		
		while(fctIndex!=-1){
			fctEndIndex=fctIndex+name.length();
			
			//on teste si le nom est ramp;eacute;ellement fini (sinon c'est un autre nom de fonction)
			if(!(Character.isJavaIdentifierPart(data.charAt(fctEndIndex))))
				//si c'est vraiment un appel de fonction
				if(isFunctionCall(fctIndex, fctEndIndex))
					data.replace(fctIndex,fctEndIndex,newName);
					
			fctIndex=data.indexOf(name,fctEndIndex+1);
		}
	}
	
	
	
	/*
		Teste si la sous-chaîne comprise entre les deux indices est un appel de fonction JS.
		
		Les appels de fonction sont faits :
			- dans la balise script,
			- dans une autre fonction,
			- en expression à amp;eacute;valuer pour la fonction JS setTimeout,
			- dans un amp;eacute;vènement HTML (OnMouseOver, OnFocus, etc...),
			- ou dans un lien href avec le mot clef "javascript:"
			
		POUR L'INSTANT CETTE METHODE TESTE SEULEMENT S'IL S'AGIT D'UN MOT ENTIER ET JUSTE UN MOT.
		-> A AFFINER !!!
	
	*/
	private boolean isFunctionCall(int start, int end){
		boolean b;
		
		b=(!Character.isJavaIdentifierPart(data.charAt(start-1))&&(!Character.isJavaIdentifierPart(data.charAt(end))));
		
		return(b);
	}
}
%>
/*
 * Cramp;eacute;amp;eacute; le 23 juil. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.service;

import java.io.File;
import java.io.FilenameFilter;
import java.io.IOException;
import java.io.PrintWriter;
import java.lang.reflect.Method;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Vector;
import java.util.zip.ZipEntry;
import java.util.zip.ZipFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import framework.beandata.BeanGenerique;
import framework.ressource.util.UtilFile;
import framework.ressource.util.UtilPackage;
import framework.ressource.util.UtilPackageResource;
import framework.ressource.util.UtilReflect;
import framework.ressource.util.UtilSafe;
import framework.ressource.util.UtilString;
import framework.ressource.util.UtilVector;
import framework.service.SrvGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class SrvEditorJavaCompletion extends SrvGenerique {

  /* (non-Javadoc)
   * @see framework.service.SrvDatabase#execute(framework.beandata.BeanDatabase)
   */
  public void execute(HttpServletRequest request, HttpServletResponse response, BeanGenerique bean) throws Exception{
    String className = (String)bean.getParameterDataByName("className");
    String source = (String)bean.getParameterDataByName("source");
    String caretPos = (String)bean.getParameterDataByName("caretPos");
    if (UtilString.isEmpty(className) && UtilString.isNotEmpty(source) && UtilString.isNotEmpty(caretPos)) {
      int iCaretPos = Integer.parseInt(caretPos);
      source = URLDecoder.decode(source);
      className = getClassBeforePos (source, iCaretPos);
    }
    if (UtilString.isNotEmpty(className)) {
     try {
       Method[] listMethod = UtilReflect.getMethods(className);
       if (listMethod != null) {
         PrintWriter out = response.getWriter();
         int size = listMethod.length, sizeParam;
         StringBuffer sb = new StringBuffer(className).append(":");
         Method method = null;
         Class[] listCls = null;
         Class cls = null;
         for (int i = 0; i < size; i++) {
           method = listMethod[i];
           sb.append(method.getName());
           sb.append("(");
           listCls = method.getParameterTypes();
           if (listCls!=null) {
             sizeParam = listCls.length - 1;
             for (int j = 0; j <= sizeParam; j++) {
               cls = listCls[j];
               sb.append(cls.getName());
               if (j < sizeParam)
                 sb.append(", ");
             }
           }
           sb.append("):");
         }
         out.print(sb.toString());
       }
     }
     catch (ClassNotFoundException ex) {
     }
    }
  }

  private String getClassBeforePos (String source, int pos) throws IOException {
    String ret = null;
    //String sourceReverse = UtilString.reverseString(source.substring(0, pos-1));
    String sourceReverse = UtilString.reverseString(source.substring(0, pos));
    String szVar = UtilString.getWordBeforePos (source, pos, false);
    if (UtilString.isNotEmpty(szVar)) {
      while (szVar.endsWith(".")) {
        szVar = szVar.substring(0, szVar.length() - 1);
        pos--;
      }
      // Variable decoupe dans une liste à partir du '.'
      List listVar = new ArrayList();
      // Class correspondant à chaque entramp;eacute;e de 'listVar'
      List listClass = new ArrayList();
      // Packages à parcourir pour faire la recherche
      List listPackage = getListPackage(source);
      // Decoupe la variable dans une liste à partir du '.'
      UtilString.split(szVar, '.', listVar);
      if (UtilVector.safeNotEmpty(listVar)) {
        int size = listVar.size();
        String var = null, varReverse = null;
        // Parcour la liste des sous-variables
        for (int i = 0; i < size; i++) {
          var = (String) listVar.get(i);
          if (UtilString.isNotEmpty(var)) {
            // Premiere sous-variable
            if (i == 0) {
              // Inverse le texte de la variable
              varReverse = UtilString.reverseString(var);
              int idxRev = varReverse.length();
              boolean isLoop = true;
              while (isLoop) {
                // Recherche la sous-variable en remontant dans le source
                idxRev = UtilString.indexOfWordOnly(sourceReverse, varReverse, idxRev);
                if (idxRev >= 0) {
                  // Position de la sous-variable à partir du debut
                  int idx = pos - idxRev - var.length();
                  // On verifi si la position correspond à une declaration
                  String szDeclaration = getClassDeclaration(source, idx);
                  if (UtilString.isNotEmpty(szDeclaration)) {
                    // On a la class de declaration de la variable
                    if (szDeclaration.indexOf('.')>=0)
                      // Il s'agit d'un nom de class avec le package
                      listClass.add(i, szDeclaration.trim());
                    else {
                      // Recherche la class dans les packages importamp;eacute;s et l'ajoute à la liste si elle est trouvamp;eacute;e
                      addClassFromPackage(listClass, i, listPackage, szDeclaration);
                    }
                    isLoop = false;
                  }
                  idxRev += varReverse.length();
                }
                else {
                  /**
                   * Cas d'une variable static
                   */
                  // Recherche la variable dans les packages importamp;eacute;s et l'ajoute à la liste si elle est trouvamp;eacute;e
                  addClassFromPackage(listClass, i, listPackage, var);
                  isLoop = false;
                }
              }
            }
          }
        }
      }
      if (!listClass.isEmpty()) {
        for( Iterator it = listClass.iterator(); it.hasNext() ; ret=(String)it.next());
      }
    }
    return ret;
  }

  private void addClassFromPackage(List listClass, int i, List listPackage, String var) throws IOException {
    // Recherche de la class dans les packages importamp;eacute;s
    String objClassImport = findClassInPackage(listPackage, var);
    if (objClassImport!=null)
      // Ajout de la class
      listClass.add(i, objClassImport.trim());
  }

  private String findClassInPackage(List listPackage, String classe) throws IOException {
    String ret = null;
    /**
     * Recherche la classe dans les imports de package/class
     */
    int size = listPackage.size();
    for(int i=0 ; i<size && (ret==null); i++) {
      String szPackage = (String)listPackage.get(i);
      if (szPackage.endsWith(".*")) {
        // C'est un ensemble de class
        szPackage = szPackage.substring(0, szPackage.lastIndexOf('.'));
        try {
          Class c = UtilReflect.loadClass(szPackage + "." + classe);
          if (c != null)
            ret = szPackage + "." + classe;
        }
        catch (ClassNotFoundException ex) {}
      }
      else if (szPackage.endsWith("." + classe)) {
        ret = szPackage;
      }
    }
    return ret;
  }

  private List getListPackage(String text) throws IOException {
    List ret = new ArrayList();
    String sz = null;
    /**
     * Recherche de 'class' qui marque la fin des imports de package/class
     */
    int idxClass = UtilString.indexOfWordOnly(text, "class");
    if (idxClass > 0) {
      int idxImport = 0, idxPackage = 0, idxEnd = 0, idxDot = 0;

      /**
       * Ajout du package actuel
       */
      addPackageAfterWord(ret, text, "package", idxPackage, idxClass);

      /**
       * Ajout des imports de package/class
       */
      while (idxImport>=0) {
        // Recherche 'import'
        idxImport = addPackageAfterWord(ret, text, "import", idxImport, idxClass);
        if (idxImport >= 0)
          idxImport++;
        else
          break;
      }
    }

    /**
     * Ajoute le package 'java.lang'
     */
    ret.add("java.lang.*");

    return ret;
  }

  private int addPackageAfterWord(List listPackage, String text, String word, int idxStart, int idxEnd) {
    int ret = -1;
    idxStart = UtilString.indexOfWordOnly(text, word, idxStart);
    if ( (idxStart >= 0) && (idxStart < idxEnd)) {
      int idx = text.indexOf(';', idxStart);
      if ( (idxStart < idx) && (idx < idxEnd)) {
        // Recupere le package d'import
        String pack = text.substring(idxStart + word.length(), idx);
        listPackage.add(pack.replace((char)160, ' ').trim());
        ret = idxStart;
      }
    }
    return ret;
  }

  /**
   * Retourne le text avant 'pos' dans 'text' si il represente une declaration de class
   * @param text String
   * @param pos int
   * @return String
   */
  private String getClassDeclaration(String text, int pos) {
    String ret = null;
    String szDeclaration = UtilString.getWordBeforePos(text, pos, false);
    if ((UtilString.isNotEmpty(szDeclaration)) &&
        (szDeclaration.indexOf('(') < 0) &&
        (szDeclaration.indexOf('+') < 0) &&
        // Test les types primitif
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "void") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "boolean") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "short") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "int") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "long") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "char") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "float") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "double") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "byte") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "public") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "protected") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "private") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "static") &&
        UtilString.isNotEqualsIgnoreCase(szDeclaration, "final")) {
      // On a la class de declaration de la variable
//      if (szDeclaration.startsWith("\"") && szDeclaration.endsWith("\""))
//        ret = "new String("+szDeclaration+")";
//      else
        ret = szDeclaration;
    }
    return ret;
  }
  /**
   * Methodes non utilisamp;eacute;es
   */


  /**
   * Retourne une liste de tous les jar accessible
   * @throws IOException
   * @return List
   */
  private List old_getClassLocation() throws IOException {
    ArrayList ret = new ArrayList();
    // Ajoute la liste des jar du classpath
    UtilVector.addElements(ret, UtilPackage.getClassPathResources());
    // Ne fonctionne pas : Le but est d'ajouter tous les jar du repertoire Web-Inf de l'application Web
    //UtilVector.addElements(ret, UtilFile.dir("Web-Inf", true, ".jar", false, true));
    return ret;
  }

  /**
   * Recherche 'packageClass' dans 'listClassResource'
   * Et retourne la liste des chemins/jar contenant la class
   * @param listClassResource List class dans passamp;eacute; en paramètre
   * @param packageClass String
   * @return List
   */
  private List old_findClass(List listClassResource, String packageClass) {
    List ret = new ArrayList();
    String fileName = null;
    String pathPackageClass = packageClass.replaceAll(".", "/") + ".class";
    int size = UtilSafe.safeListSize(listClassResource);
    for(int i=0 ; i<size ; i++) {
      fileName = (String)listClassResource.get(i);
      File file = new File(fileName);
      if (file.exists()) {
        if (file.isDirectory()) {
          File[] listFile = file.listFiles(new FilenameFilter() {
            public boolean accept(File file, String string) {
              return UtilFile.isExtFile(string, ".class");
            }
          });
          int sizeListFile = UtilSafe.safeListSize(listFile);
          if (sizeListFile>0) {
            String sz = UtilFile.getPathRelative(file, listFile[0]);
            sz = sz.substring(0, sz.lastIndexOf('.'-1));
            ret.add(UtilPackage.getClassNameToFileName(sz));
          }
        }
        else if (UtilFile.isExtFile(fileName, ".jar")) {
          try {
            ZipFile zip = new ZipFile(file);
            ZipEntry entriePack = zip.getEntry(pathPackageClass);
            if (entriePack != null) {
              ret.add(packageClass);
            }
          }
          catch (Exception ex) {
          }
        }
      }
    }
    return ret;
  }

  /**
   * Retourne le text après 'pos' dans 'text' si c'est une constructeur
   * @param text String
   * @param pos int
   * @return String
   */
  private String old_getClassContructeur(String text, int pos) {
    String ret = null;
    char car;
    StringBuffer sbDefinition = new StringBuffer();
    for (int j = pos; j < pos; j++) {
      car = text.charAt(j);
      if (car == ';')
        break;
      else
        sbDefinition.append(text.charAt(j));
    }
    String szDefinition = sbDefinition.toString().trim();
    int idxEq = szDefinition.indexOf('=');
    // Verifi si c'est une definition
    if (idxEq >= 0) {
      // Le caractere '=' à amp;eacute;tamp;eacute; trouvamp;eacute; c'est une initialisation
      int idxNew = szDefinition.toUpperCase().indexOf("NEW ", idxEq);
      if (idxNew >= 0) {
        // 'New' à amp;eacute;tamp;eacute; trouvamp;eacute; donc il doit y avoir un constructeur
        if (UtilString.isEmpty(szDefinition.substring(idxEq, idxNew).trim())) {
          // Il n'y a rien entre '=' et 'New'
          int idxParDeb = szDefinition.indexOf("(", idxNew);
          // On recupere la class du constructeur
          ret = szDefinition.substring(idxNew+3, idxParDeb).trim();
        }

      }
    }
    return ret;
  }

  private Hashtable old_getClassImport2(String text) {
    Hashtable ret = new Hashtable();
    // Liste des classes du classpath
    Vector vListPackage = UtilPackage.computePackageResources();

    /**
     * Recherche de 'class' qui marque la fin des imports de package/class
     */
    int idxClass = UtilString.indexOfWordOnly(text, "class");
    if (idxClass>0) {
      int idxImport = 0, idxPackage = 0, idxEnd = 0, idxDot = 0;
      boolean isLoop = false;

      /**
       * Recherche de la classe dans le package actuel
       */
      idxPackage = UtilString.indexOfWordOnly(text, "package");
      if (idxPackage>=0) {
        idxEnd = text.indexOf(';', idxImport);
        if ( (idxPackage < idxClass) && (idxEnd < idxPackage)) {
          // Recupere le package d'import
          String szPackage = text.substring(idxPackage + 6, idxEnd).trim();
          // Ajout des classes
          for (int i = 0; i < vListPackage.size(); i++) {
            UtilPackageResource item = (UtilPackageResource) vListPackage.elementAt(i);
            idxDot = item.pack.lastIndexOf('.');
            ret.put(item.pack.substring(idxDot + 1), item.pack);
          }
        }
      }

      /**
       * Recherche des imports de package/class
       */
      do {
        isLoop = false;
        // Recherche 'import'
        idxImport = UtilString.indexOfWordOnly(text, "import");
        if (idxImport>=0) {
          idxEnd = text.indexOf(';', idxImport);
          if ((idxImport < idxClass) && (idxImport < idxEnd)) {
            // Recupere le package d'import
            String szPackage = text.substring(idxImport + 6, idxEnd).trim();
            if (szPackage.endsWith(".*")) {
              // C'est un ensemble de class
              idxDot = szPackage.lastIndexOf('.');
              szPackage = szPackage.substring(0, idxDot);
              // Ajout des classes
              for (int i = 0; i < vListPackage.size(); i++) {
                UtilPackageResource item = (UtilPackageResource) vListPackage.elementAt(i);
                if (szPackage.equals(item.pack)) {
//                  idxDot = item.pack.lastIndexOf('.');
//                  ret.put(item.pack.substring(idxDot + 1), item.pack);
                  ret.put(item.pack, item.pack);
                }
              }
            }
            else {
              // C'est une classe unique
              idxDot = szPackage.lastIndexOf('.');
              // Ajout de la classe
              if (idxDot > 0)
                ret.put(szPackage.substring(idxDot + 1), szPackage);
              else
                ret.put(szPackage, szPackage);
            }
            isLoop = true;
          }
        }
      }
      while (isLoop);
    }

    return ret;
  }
}
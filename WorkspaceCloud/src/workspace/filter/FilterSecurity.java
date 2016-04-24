/*
 * Cramp;eacute;amp;eacute; le 1 damp;eacute;c. 2004
 *
 * Pour changer le modèle de ce fichier gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
package workspace.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import framework.beandata.BeanGenerique;

/**
 * @author rocada
 *
 * Pour changer le modèle de ce commentaire de type gamp;eacute;namp;eacute;ramp;eacute;, allez à :
 * Fenêtre&gt;Pramp;eacute;famp;eacute;rences&gt;Java&gt;Gamp;eacute;namp;eacute;ration de code&gt;Code et commentaires
 */
public class FilterSecurity implements Filter {

  private final static String URL_LOGOUT = "?event=Index";

  private FilterConfig filterConfig = null;

  /* (non-Javadoc)
   * @see javax.servlet.Filter#init(javax.servlet.FilterConfig)
   */
  public void init(FilterConfig arg0) throws ServletException {
    filterConfig = arg0;
  }

  /* (non-Javadoc)
   * @see javax.servlet.Filter#destroy()
   */
  public void destroy() {
  }

  /* (non-Javadoc)
   * @see javax.servlet.Filter#doFilter(javax.servlet.ServletRequest, javax.servlet.ServletResponse, javax.servlet.FilterChain)
   */
  public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
    BeanGenerique bean = null;
    HttpServletRequest req = (HttpServletRequest) request;
    // Lecture du nom du paramètre qui indique si l'evenement à besoin d'une authentification
    String szInputName = filterConfig.getInitParameter("InputName");
    String szEventAuthentification = (String)filterConfig.getServletContext().getAttribute(szInputName);
    // Verifi si il y a besoin d'une authentification
    if (Boolean.FALSE.toString().equals(szEventAuthentification)) {
      // Continue si il n'y a pas besoin d'authentification
      chain.doFilter(request, response);
    }
    else {
      try {
        String event = request.getParameter("event");
        /****** Check event ******/
        if ( (event != null) && (!event.equals(""))) {
          /****** Looking for Authentification ******/
          bean = (BeanGenerique) req.getSession().getAttribute("BeanAuthentification");
        }
      }
      finally {
        if (bean == null) {
          // Lecture de l'url par defaut si le bean d'authentification n'a pas été trouvé
          String szDefaultUrl = filterConfig.getInitParameter("DefaultUrl");
          filterConfig.getServletContext().getRequestDispatcher(szDefaultUrl).forward(request, response); ;
        }
        else {
          /****** Authentified Redirection ******/
          chain.doFilter(request, response);
        }
      }
    }
  }
}

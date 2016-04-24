<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:import href="/Xsl/User/Application/Util/UtilFormatPath.xsl"/>

<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>
  <xsl:param name="pApplication"/>
  <xsl:param name="pType"/>
  <xsl:param name="pName"/>
  <xsl:variable name="user" select="/ROOT/USER"/>
  <xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION"/>
  <xsl:variable name="package" select="$application[@Name=$pApplication]/PACKAGING/PACKAGE[@Type=$pType and @Name=$pName]"/>
  <xsl:template match="/">
      <!-- Parcour le package -->
    <xsl:for-each select="$package">
          <!-- Creation d'un element avec le nom du Tag courant -->
            <xsl:element name="{name()}">
            <xsl:for-each select="@*">
                    <!-- Creer un attribut avec le nom de l'attribut courant -->
                    <xsl:attribute name="{name()}">
                    <xsl:choose>
                      <xsl:when test="name(current())='Filename'">
                        <!-- Appel le template de remplacement des champs des applications -->
                        <xsl:call-template name="replace-application-path">
                          <xsl:with-param name="text" select="current()"/>
                        </xsl:call-template>
                      </xsl:when>
                      <xsl:otherwise>
                        <!-- Ecrit le resultat dans l'attribut -->
                        <xsl:value-of select="."/>
                      </xsl:otherwise>
                    </xsl:choose>
                    </xsl:attribute>
            </xsl:for-each>
              <!-- Parcour le contenu du package -->
            <xsl:for-each select="$package/CONTENT">
                  <!-- Creation d'un element avec le nom du Tag courant -->
                    <xsl:element name="{name()}">
                      <!-- Parcour les attribut du Tag courant -->
                    <xsl:for-each select="@*">
                          <!-- Creer un attribut avec le nom de l'attribut courant -->
                            <xsl:attribute name="{name()}">
                              <!-- Stock le resultat du template appele dans une variable -->
                                <xsl:variable name="result">
                                    <!-- Appel le template de remplacement des champs des applications -->
                                  <xsl:call-template name="replace-application-path">
                                    <xsl:with-param name="text" select="current()"/>
                                  </xsl:call-template>
                              </xsl:variable>
                              <!-- Ecrit le resultat dans l'attribut -->
                          <xsl:value-of select="$result"/>
                            </xsl:attribute>
                    </xsl:for-each>
                    </xsl:element>
            </xsl:for-each>
            </xsl:element>
    </xsl:for-each>
  </xsl:template>
</xsl:stylesheet>
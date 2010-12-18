<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">
<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

  <xsl:param name="pApplication"/>
  <xsl:param name="pType"/>
  <xsl:param name="pName"/>

  <xsl:variable name="user" select="/ROOT/USER"/>
  <xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION"/>
  <xsl:variable name="package" select="$application[@Name=$pApplication]/PACKAGING/PACKAGE[@Type=$pType and @Name=$pName]"/>
  <xsl:variable name="content" select="$package/CONTENT"/>
	
  <xsl:template match="/">
    <!-- Variable de resultat -->
    <xsl:variable name="res">
      <xsl:for-each select="$content">
     	  <!-- Ajout le chemin des classes d'une application -->
        <xsl:value-of select="concat(current()/@From, '=>')"/>
        <xsl:value-of select="concat(current()/@To, ';')"/>
      </xsl:for-each>
    </xsl:variable>
    <!-- Ecrit le contenu de la variable resultat  -->
    <xsl:value-of select="normalize-space($res)"/>
  </xsl:template>

</xsl:stylesheet>
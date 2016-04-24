<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

  <xsl:template name="replace-application-path">
    <xsl:param name="text"/>
    <xsl:choose>
      <xsl:when test="contains($text,'[') and contains($text,']')">
          <!-- Nom de l'application  rechercher -->
                <xsl:variable name="lApplication" select="substring-before(substring-after($text, '['), ']')" />
                <!-- Chemin principal de l'application -->
                <xsl:variable name="lPath">
            <xsl:call-template name="application-path">
              <xsl:with-param name="applicationName" select="$lApplication"/>
              <xsl:with-param name="pathName" select="'Main'"/>
            </xsl:call-template>
                </xsl:variable>
                <!-- Remplace le nom de l'application par son chemin -->
                <xsl:variable name="lPathNew">
            <xsl:call-template name="replace-string">
              <xsl:with-param name="text" select="$text"/>
              <xsl:with-param name="replace" select="concat(concat('[', $lApplication), ']')"/>
              <xsl:with-param name="with" select="$lPath"/>
            </xsl:call-template>
        </xsl:variable>
        <!-- Boucle sur la recherche -->
              <xsl:call-template name="replace-application-path">
          <xsl:with-param name="text" select="$lPathNew"/>
              </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
          <!-- Dans les autres cas renvoi le text -->
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

    <!-- Recherche un chemin de l'application -->
    <xsl:template name="application-path">
      <xsl:param name="applicationName"/>
      <xsl:param name="pathName"/>
    <xsl:value-of select="$application[@Name=$applicationName]/PATHS/PATH[@Name=$pathName]"/>
    </xsl:template>
    <!-- Remplace 'replace' par 'with' dans 'text' -->
  <xsl:template name="replace-string">
    <xsl:param name="text"/>
    <xsl:param name="replace"/>
    <xsl:param name="with"/>
    <xsl:choose>
      <xsl:when test="contains($text,$replace)">
        <xsl:value-of select="substring-before($text,$replace)"/>
        <xsl:value-of select="$with"/>
        <xsl:call-template name="replace-string">
          <xsl:with-param name="text" select="substring-after($text,$replace)"/>
          <xsl:with-param name="replace" select="$replace"/>
          <xsl:with-param name="with" select="$with"/>
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$text"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
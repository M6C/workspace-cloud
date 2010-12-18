<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>

  <xsl:variable name="param" select="/xsl:stylesheet/xsl:param"/>

  <xsl:template match="/">
  <XSL-PARAM>
  	<!-- Parcour le package -->
    <xsl:for-each select="$param">
  		<!-- Creation d'un element avec le nom du Tag courant -->
			<xsl:element name="PARAM">
				<!-- Parcour les attribut du Tag courant -->
		    <xsl:for-each select="@*">
					<!-- Creer un attribut avec le nom de l'attribut courant -->
					<xsl:attribute name="{name()}">
			      <xsl:value-of select="."/>
					</xsl:attribute>
		    </xsl:for-each>
			</xsl:element>
    </xsl:for-each>
  </XSL-PARAM>
  </xsl:template>
</xsl:stylesheet>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

	<xsl:param name="pTable"/>

	<xsl:variable name="class" select="/hibernate-mapping/class[@Table=$pTable]"/>
	
	<xsl:template match="/">
    <xsl:value-of select="$class/@name"/>
	</xsl:template>

</xsl:stylesheet>

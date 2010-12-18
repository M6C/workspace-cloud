<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

	<xsl:param name="pApplication"/>
	<xsl:param name="pType"/>

	<xsl:variable name="user" select="/ROOT/USER"/>
	<xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name=$pApplication]"/>
	<xsl:variable name="type" select="$application/PACKAGING/PACKAGE[@Type=$pType]/FILE"/>
	
	<xsl:template match="/">
    <xsl:value-of select="$type"/>
	</xsl:template>

</xsl:stylesheet>

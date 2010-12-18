<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

    <xsl:param name="pApplication"/>
    <xsl:param name="pType"/>
    <xsl:param name="pName"/>

    <xsl:variable name="user" select="/ROOT/USER"/>
    <xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name=$pApplication]"/>
  <xsl:variable name="package" select="$application[@Name=$pApplication]/PACKAGING/PACKAGE[@Type=$pType and @Name=$pName]"/>
    
    <xsl:template match="/">
    <xsl:value-of select="$package/@Filename"/>
    </xsl:template>

</xsl:stylesheet>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>

  <xsl:param name="pApplication"/>
  <xsl:param name="pType"/>
  <xsl:param name="pName"/>

  <xsl:variable name="user" select="/ROOT/USER"/>
  <xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION"/>
  <xsl:variable name="package" select="$application[@Name=$pApplication]/PACKAGING/PACKAGE[@Type=$pType and @Name=$pName]"/>
	
  <xsl:template match="/">
    <xsl:for-each select="$package">
       <xsl:copy-of select="current()/."/>
    </xsl:for-each>
  </xsl:template>

</xsl:stylesheet>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

  <xsl:param name="pApplication"/>
  <xsl:param name="pType"/>

  <xsl:variable name="user" select="/ROOT/USER"/>
  <xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name=$pApplication]"/>
  <xsl:variable name="type" select="$application/PACKAGING/PACKAGE[@Type=$pType]"/>

  <xsl:template match="/">{'data':[
	{'package':''}
    <xsl:for-each select="$type">
    	,{'package':'<xsl:value-of select="@Name"/>'}
    </xsl:for-each>
    ]
    }
  </xsl:template>

</xsl:stylesheet>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

  <xsl:variable name="param" select="/xsl:stylesheet/xsl:param"/>

  <xsl:template match="/">{'data':[
	{'param':''}
    <xsl:for-each select="$param">
    	,{'param':'<xsl:value-of select="@name"/><xsl:value-of select="@Name"/>'}
    </xsl:for-each>
    ]
    }
  </xsl:template>

</xsl:stylesheet>
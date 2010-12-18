<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>
  <xsl:template match="/">{'data':[
	{'project':''}
    <xsl:for-each select="/ROOT/USER/PROFILES/PROFILE/APPLICATIONS/APPLICATION">
    	,{'project':'<xsl:value-of select="@Name"/>'}
    </xsl:for-each>
    ]
    }
  </xsl:template>
</xsl:stylesheet>
<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="text" encoding="ISO-8859-1" indent="no"/>

  <xsl:strip-space elements="*"/>

  <xsl:param name="pApplication"/>
  <xsl:param name="pType"/>
  <xsl:param name="pName"/>

  <xsl:variable name="user" select="/ROOT/USER"/>
  <xsl:variable name="application" select="$user/PROFILES/PROFILE/APPLICATIONS/APPLICATION[@Name=$pApplication]"/>
  <xsl:variable name="type" select="$application/PACKAGING/PACKAGE[@Type=$pType and @Name=$pName]"/>

  <!-- Copie toutes les balises -->
  <xsl:template match="*">
    {'<xsl:value-of select="name()"/>':'attribute', 'leaf':'false',
        children: [
            <xsl:apply-templates select="@*"/>
            <xsl:apply-templates/>
        ]
    }
  </xsl:template>

  <!-- Copie tous les attributs -->
  <xsl:template match="@*">
  	<xsl:if test="position()>1">,</xsl:if>{'text':'<xsl:value-of select="name()"/>-'<xsl:value-of select="."/>', 'leaf':'true'}
  </xsl:template>

  <xsl:template match="/">
  [
    {'text':'parameter', 'leaf':'false',
        children: [
             {'text':'application-'<xsl:value-of select="$pApplication"/>', 'leaf':'true'}
            ,{'text':'application-'<xsl:value-of select="$pType"/>', 'leaf':'true'},
            ,{'text':'application-'<xsl:value-of select="$pName"/>', 'leaf':'true'}
        ]
    },
    <xsl:for-each select="$type">
    {'text':'attribute', 'leaf':'false',
        children: [
            <xsl:apply-templates select="@*"/>
        ]
    },
    {'text':'detail', 'leaf':'false',
        children: [
            <xsl:apply-templates/>
        ]
    }
    </xsl:for-each>
    }
  ]
  </xsl:template>

</xsl:stylesheet>
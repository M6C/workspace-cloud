<xsl:stylesheet version="1.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:xalan="http://xml.apache.org/xalan"
                exclude-result-prefixes="xalan">

<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>

    <!-- Decoupe 'names' et 'types' Et ajout les elements PARAM -->
	<xsl:template name="fxAddElementParam">
        <xsl:param name="names"/>
        <xsl:param name="types"/>
        <xsl:param name="beans"/>
        <xsl:param name="formatins"/>
        <xsl:variable name="first" select="substring-before($names,';')"/>
        <xsl:variable name="rest" select="substring-after($names,';')"/>
        <xsl:variable name="first_type" select="substring-before($types,';')"/>
        <xsl:variable name="rest_type" select="substring-after($types,';')"/>
        <xsl:variable name="first_bean" select="substring-before($beans,';')"/>
        <xsl:variable name="rest_bean" select="substring-after($beans,';')"/>
        <xsl:variable name="first_formatin" select="substring-before($formatins,';')"/>
        <xsl:variable name="rest_formatin" select="substring-after($formatins,';')"/>
 
        <xsl:if test='$first'>
			<xsl:element name="PARAM">
		        <!-- Creer un attribut Name -->
		        <xsl:attribute name="Name">
			        <xsl:value-of select="$first"/>
		        </xsl:attribute>
		        <xsl:if test="$first_type">
			        <!-- Creer un attribut Type -->
			        <xsl:attribute name="Type">
				        <xsl:value-of select="$first_type"/>
			        </xsl:attribute>
		        </xsl:if>
		        <xsl:if test="$first_bean">
			        <!-- Creer un attribut Bean -->
			        <xsl:attribute name="Bean">
				        <xsl:value-of select="$first_bean"/>
			        </xsl:attribute>
		        </xsl:if>
		        <xsl:if test="$first_formatin">
			        <!-- Creer un attribut Format -->
			        <xsl:attribute name="FormatIn">
				        <xsl:value-of select="$first_formatin"/>
			        </xsl:attribute>
		        </xsl:if>
			</xsl:element>
        </xsl:if>
 
        <xsl:if test='$rest'>
	        <xsl:if test='$rest_type'>
	            <xsl:call-template name='fxAddElementParam'>
	                <xsl:with-param name='names' select='$rest'/>
	                <xsl:with-param name='types' select='$rest_type'/>
	                <xsl:with-param name='beans' select='$rest_bean'/>
	                <xsl:with-param name='formatins' select='$rest_formatin'/>
	            </xsl:call-template>
	        </xsl:if>
        </xsl:if>
        <xsl:if test='not($rest)'>
			<xsl:element name="PARAM">
		        <!-- Creer un attribut Name -->
		        <xsl:attribute name="Name">
			        <xsl:value-of select="$names"/>
		        </xsl:attribute>
				<xsl:if test='not($rest_type)'>
			        <!-- Creer un attribut Type -->
			        <xsl:attribute name="Type">
				        <xsl:value-of select="$types"/>
			        </xsl:attribute>
				</xsl:if>
				<xsl:if test='not($rest_bean)'>
			        <!-- Creer un attribut Bean -->
			        <xsl:attribute name="Bean">
				        <xsl:value-of select="$beans"/>
			        </xsl:attribute>
				</xsl:if>
				<xsl:if test='not($rest_formatin)'>
			        <!-- Creer un attribut Format -->
			        <xsl:attribute name="FormatIn">
				        <xsl:value-of select="$formatins"/>
			        </xsl:attribute>
				</xsl:if>
			</xsl:element>
        </xsl:if>
	</xsl:template>

</xsl:stylesheet>
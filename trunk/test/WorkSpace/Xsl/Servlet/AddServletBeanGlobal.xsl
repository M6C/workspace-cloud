<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="xml" encoding="ISO-8859-1" indent="yes"/>

    <xsl:param name="pName"/>
    <xsl:param name="pBeanName"/>

	<!-- Copie toutes les balises -->
	<xsl:template match="*">
		<xsl:element name="{name()}">
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates/>
		</xsl:element>
	</xsl:template>

	<!-- Copie tous les attributs -->
	<xsl:template match="@*">
		<xsl:attribute name="{name()}">
			<xsl:value-of select="."/>
		</xsl:attribute>
	</xsl:template>

	<!-- Applique les templates que sur les sous elements de ROOT -->
	<xsl:template match="/ROOT/SERVLET[@Name=$pName]">

		<xsl:element name="SERVLET">

			<!--xsl:copy-of select="/BEAN/node()|/BEAN/@*"/-->

			<!--xsl:copy-of select="attribute::*"/-->
			<!--xsl:copy-of select="."/-->

			<!--xsl:copy-of select="*[name()!='BEAN' and @Name!=$pBeanName]"/-->

			<!--
			<xsl:apply-templates select="@*"/>
	
			<xsl:element name="{name()}">
				<xsl:apply-templates select="@*"/>
				<xsl:apply-templates/>
			</xsl:element>
			-->

			<xsl:copy-of select="attribute::*"/>
			<xsl:apply-templates select="./BEAN"/>

	   		<!-- Ajout de l'element ROOT -->
	    	<xsl:element name="BEAN">
		        <!-- Creer un attribut Name -->
		        <xsl:attribute name="Name">
			        <xsl:value-of select="$pBeanName"/>
		        </xsl:attribute>
	    	</xsl:element>

		</xsl:element>

		<!--xsl:apply-templates/-->

    </xsl:template>
</xsl:stylesheet>
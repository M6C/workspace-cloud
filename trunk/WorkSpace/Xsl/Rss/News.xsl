<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" indent="no"/>

  <xsl:variable name="title" select="/rss/channel/title"/>
  <xsl:variable name="item" select="/rss/channel/item"/>
    
  <xsl:template match="/">

    <table>
      <tr class="title">
        <!-- Ecrit le titre -->
        <td class="title" colspan="2"><xsl:value-of select="normalize-space($title)"/></td>
      </tr>
      <!-- Boucle sur chanque element -->
      <xsl:for-each select="$item">
      <tr class="item_title">
        <td class="item_title">
            <!-- Date de pblication de chaque element-->
            <xsl:value-of select='normalize-space(./pubDate)'/>
        </td>
        <td class="item_title">
            <!-- Construit le lien avec le titre de chaque element et la description -->
            <xsl:element name="a">
                <xsl:attribute name="href"><xsl:value-of select='normalize-space(./link)'/></xsl:attribute>
                <xsl:attribute name="title"><xsl:value-of select='normalize-space(./description)'/></xsl:attribute>
                <xsl:value-of select='normalize-space(./title)'/>
            </xsl:element>
        </td>
      </tr>
      </xsl:for-each>
     </table>

  </xsl:template>

</xsl:stylesheet>

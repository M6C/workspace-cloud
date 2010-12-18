<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="html" encoding="ISO-8859-1" indent="yes"/>

  <xsl:variable name="title" select="/rss/channel/title"/>
  <xsl:variable name="pubDate" select="/rss/channel/pubDate"/>
  <xsl:variable name="item" select="/rss/channel/item"/>
    
  <xsl:template match="/">
  <table class="treeview" id="theTableToDo">
      <tr>
          <td class="treeviewTopLeft"><IMG height="8px" width="8px" src="/WorkSpace/img/TreeView/b.gif"/></td>
          <td class="treeviewTop"></td>
          <td class="treeviewTopRight"></td>
      </tr>
      <tr>
          <td class="treeviewLeft"></td>
          <th class="treeviewHeader">
              <!-- Ecrit le titre -->
              <font size="4px">Task List <xsl:value-of select="normalize-space($title)"/> : <xsl:value-of select='normalize-space($pubDate)'/></font>
          </th>
          <td class="treeviewRight"></td>
      </tr>
      <tr>
          <td class="treeviewLeft"></td>
          <td class="treeviewMain">
              <div id="theCellToDo">
                <!-- Boucle sur chanque element -->
                <xsl:for-each select="$item">
                  <!-- Date de publication de chaque element-->
                  <li/><b><xsl:value-of select='normalize-space(./pubDate)'/></b>:
                  <!-- Construit le lien avec le titre de chaque element et la description -->
                  <xsl:element name="a">
                      <xsl:attribute name="href"><xsl:value-of select='normalize-space(./link)'/></xsl:attribute>
                      <xsl:attribute name="title"><xsl:value-of select='normalize-space(./description)'/></xsl:attribute>
                      <xsl:value-of select='normalize-space(./title)'/>
                  </xsl:element>
                  <br/>
                </xsl:for-each>
              </div>
          </td>
          <td class="treeviewRight"></td>
      </tr>
      <tr>
          <td class="treeviewBottomLeft"></td>
          <td class="treeviewBottom"></td>
          <td class="treeviewBottomRight"><IMG height="8px" width="8px" src="/WorkSpace/img/TreeView/b.gif"/></td>
      </tr>
  </table>
  </xsl:template>

</xsl:stylesheet>
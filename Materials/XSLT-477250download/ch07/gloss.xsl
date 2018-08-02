<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

   <xsl:output method="xhtml" encoding="UTF-8"/>
   <!--<xsl:include href="params_single.xsl"/>-->
   <xsl:template match="termtable">
      <h2>Glossary</h2>
      <xsl:for-each select="dfn">
         <xsl:apply-templates select="document(@term)"/>
      </xsl:for-each>
   </xsl:template>
   <xsl:template match="term">
      <p>
         <strong>
            <xsl:value-of select="label"/>
         </strong>: <xsl:value-of select="definition"/>
      </p>
   </xsl:template>

</xsl:stylesheet>

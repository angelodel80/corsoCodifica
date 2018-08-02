<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
   <xsl:output method="xhtml" encoding="UTF-8"
      doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
      doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN" indent="no"/>

   <xsl:template match="/">
      <html>
         <head>
            <title>
               <xsl:value-of select="reference/body/title"/>
            </title>
         </head>
         <body>
            <xsl:apply-templates select="reference/body"/>
            <p><strong>Element index</strong>:
               <xsl:apply-templates select="//element" mode="index"/>
                
            </p>
         </body>
      </html>
   </xsl:template>
   <xsl:template match="title">
      <h1>
         <xsl:value-of select="."/>
      </h1>
   </xsl:template>
   <xsl:template match="purpose">
      <h2>Purpose</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="usage">
      <h2>Usage</h2>
      <xsl:apply-templates select="p"/>
   </xsl:template>

   <xsl:template match="p">
      <p>
         <xsl:apply-templates/>
      </p>
   </xsl:template>

   <xsl:template match="attr | element">
      <code>
         <xsl:value-of select="."/>
      </code>
   </xsl:template>

  <xsl:template match="element" mode="index">
      <ul>
         <xsl:for-each select=".">
            <li>
            <xsl:value-of select="name()"/>
            <xsl:text>: </xsl:text>
            <xsl:value-of select="."/>
            <xsl:text> </xsl:text>
            </li>
         </xsl:for-each>
      </ul>
  </xsl:template>
   
   <xsl:template match="code">
      <xsl:copy-of select="."/>
   </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="utf-8"?>
<!-- number2.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Automobile manufacturers and their cars</title>
      </head>
      <body>
        <xsl:for-each select="cars/manufacturer">
          <p>
            <xsl:text>Cars produced by </xsl:text>
            <xsl:value-of select="@name"/>
            <xsl:text>: </xsl:text>
            <xsl:number value="count(car)" format="01"/>
          </p>
        </xsl:for-each>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

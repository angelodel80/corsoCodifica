<?xml version="1.0"?>
<!-- text.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>Test of &lt;xsl:text&gt;</title>
      </head>
      <body style="font-family: sans-serif;">
        <!-- disable-output-escaping="no" by default -->
        <h1>Test of &lt;xsl:text&gt;</h1>
        <p>
          <xsl:text>Your document contains </xsl:text>
          <xsl:value-of select="count(//*)"/>
          <xsl:text> elements and </xsl:text>
          <xsl:value-of select="count(//@*)"/>
          <xsl:text> attributes.  </xsl:text>
        </p>
        <p>
          <xsl:text 
            disable-output-escaping="yes">&lt;Have a great day!&gt;</xsl:text>
        </p>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

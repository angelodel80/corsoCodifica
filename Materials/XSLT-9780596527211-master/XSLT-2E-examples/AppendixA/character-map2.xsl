<?xml version="1.0" encoding="utf-8"?>
<!-- character-map2.xsl -->
<xsl:stylesheet version="2.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" use-character-maps="jsp"/>

  <xsl:character-map name="jsp">
    <xsl:output-character character="&#xAB;" string="&lt;%="/>
    <xsl:output-character character="&#xBB;" string="%&gt;"/>
  </xsl:character-map>

  <xsl:template match="jsp-test">
    <html>
      <head>
        <title>A test of some special characters</title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>Generating a .jsp page</h1>
        <p>Here's the value of a JSP function:
          <xsl:apply-templates select="text()"/>
        </p>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

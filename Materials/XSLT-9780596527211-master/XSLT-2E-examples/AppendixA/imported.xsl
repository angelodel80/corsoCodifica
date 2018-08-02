<?xml version="1.0"?>
<!-- imported.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:template match="programlisting">
    <pre>
      <xsl:value-of select="."/>
    </pre>
  </xsl:template>

</xsl:stylesheet>

<?xml version="1.0"?>
<!-- namespace-alias-2.xsl -->
<stylesheet version="1.0"
  xmlns="http://www.w3.org/1999/XSL/Transform"
  xmlns:xslout="[anything but the XSL namespace]">

  <output method="xml" indent="yes"/>
 
  <namespace-alias stylesheet-prefix="xslout"
    result-prefix="#default"/>

  <template match="/">
    <xslout:stylesheet version="1.0">
      <xslout:output method="xml"/>
      <xslout:template match="/">
        <xslout:copy-of select="."/>
      </xslout:template>
    </xslout:stylesheet>
  </template>

</stylesheet>

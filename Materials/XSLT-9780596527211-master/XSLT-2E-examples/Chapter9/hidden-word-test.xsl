<?xml version="1.0"?>
<!-- hidden-word-test.xsl -->
<xsl:stylesheet version="1.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:saxon="java:com.oreilly.xslt.HiddenWord"
  xmlns:xalan="xalan://com.oreilly.xslt.HiddenWord"
  xmlns:ora="http://www.oreilly.com/xslt"
  extension-element-prefixes="saxon xalan ora">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title>
          Test of hidden word generator
        </title>
      </head>
      <body style="font-family: sans-serif;">
	      <h1>Test of hidden word generator</h1>
        <xsl:comment>
          This &lt;form&gt; doesn't have a method or action
          attribute; a real form would, of course...
        </xsl:comment>
        <xsl:variable name="createGraphic">
          <xsl:choose>
            <xsl:when test="function-available('saxon:createJPEG')"> 
              <xsl:value-of select="saxon:createJPEG('hidden.jpg', 'giraffe', 48, 200, 100)"/>
            </xsl:when>
            <xsl:when test="function-available('xalan:createJPEG')">
              <xsl:value-of select="xalan:createJPEG('hidden.jpg', 'monkey', 48, 200, 100)"/>
            </xsl:when>
            <xsl:when test="function-available('ora:createJPEG')">
              <xsl:value-of select="ora:createJPEG('hidden.jpg', 'okapi', 48, 200, 100)"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="1"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>
        <form align="center">
          <p>Enter the word hidden in the graphic below:</p>
          <xsl:choose>
            <xsl:when test="number($createGraphic)">
              <p style="font-style: italic; font-size: 150%;">
                <xsl:text>Sorry, the image function isn't available.</xsl:text>
              </p>
            </xsl:when>
            <xsl:otherwise>
              <p>
                <img src="hidden.jpg" width="200" height="100" border="3"/>
              </p>
            </xsl:otherwise>
          </xsl:choose>
          <p>
            <input type="text" name="hiddenWord" size="20" maxlength="20"/>
          </p>
          <p>
            <input type="submit" value="Submit"/>
          </p>
        </form>
      </body>
    </html>
  </xsl:template>

</xsl:stylesheet>

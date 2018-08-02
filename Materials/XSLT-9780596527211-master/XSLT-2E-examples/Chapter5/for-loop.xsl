<?xml version="1.0"?>
<!-- for-loop.xsl -->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="text"/>

  <xsl:param name="i" select="1"/>
  <xsl:param name="increment" select="1"/>
  <xsl:param name="operator" select="'&lt;='"/>
  <xsl:param name="testValue" select="10"/>

  <xsl:template match="/">
    <xsl:call-template name="for-loop">
      <xsl:with-param name="i"         select="$i"/>
      <xsl:with-param name="increment" select="$increment"/>
      <xsl:with-param name="operator"  select="$operator"/>
      <xsl:with-param name="testValue" select="$testValue"/>
    </xsl:call-template>
  </xsl:template>

  <xsl:template name="for-loop">
    <xsl:param name="i"/>
    <xsl:param name="increment"/>
    <xsl:param name="operator"/>
    <xsl:param name="testValue"/>

    <xsl:variable name="testPassed">
      <xsl:choose>
        <xsl:when test="$operator = '!='">
          <xsl:if test="$i != $testValue">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$operator = '&lt;='">
          <xsl:if test="$i &lt;= $testValue">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$operator = '&gt;='">
          <xsl:if test="$i &gt;= $testValue">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$operator = '='">
          <xsl:if test="$i = $testValue">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$operator = '&lt;'">
          <xsl:if test="$i &lt; $testValue">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:when test="$operator = '&gt;'">
          <xsl:if test="$i &gt; $testValue">
            <xsl:text>true</xsl:text>
          </xsl:if>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message terminate="yes">
            <xsl:text>Sorry, the for-loop emulator only </xsl:text>
            <xsl:text>handles six operators &#xA;</xsl:text>
            <xsl:text>(&lt; | &gt; | = | &lt;= | &gt;= | !=).  </xsl:text>
            <xsl:text>The value </xsl:text>
            <xsl:value-of select="$operator"/>
            <xsl:text> is not allowed.&#xA;</xsl:text>
          </xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <xsl:if test="$testPassed='true'">
      <!-- Put your logic here, whatever it might be.  For the purpose      -->
      <!-- of our example, we'll just write some text to the output stream. -->

      <xsl:text>Value of i=</xsl:text>
      <xsl:value-of select="$i"/>
      <xsl:text>&#xA;</xsl:text>

      <!-- Your logic should end here; don't change the rest of this        -->
      <!-- template!                                                        -->

      <!-- Now for the important part: we increment the index variable and  -->
      <!-- loop.  Notice that we're passing the incremented value, not      -->
      <!-- changing the variable itself.                                    -->

      <xsl:call-template name="for-loop">
        <xsl:with-param name="i"         select="$i + $increment"/>
        <xsl:with-param name="increment" select="$increment"/>
        <xsl:with-param name="operator"  select="$operator"/>
        <xsl:with-param name="testValue" select="$testValue"/>
      </xsl:call-template>
    </xsl:if> 
  </xsl:template>

</xsl:stylesheet>

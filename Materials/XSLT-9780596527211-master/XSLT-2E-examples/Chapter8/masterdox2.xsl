<?xml version="1.0"?>
<!-- masterdox2.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="/report/title"/></title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>
          Selected Purchase Orders - Sorted by state
          <span style="font-style: italic; 
                       text-decoration: underline;">abbreviation</span>
        </h1>
        <xsl:apply-templates 
          select="document(/report/po/@filename)/purchase-order">
          <xsl:sort select="customer/address/state"/>
          <xsl:sort select="customer/address/city"/>
        </xsl:apply-templates>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="purchase-order">
    <h2>
      <xsl:value-of 
        select="customer/address[@type='business']/name/title"/>
      <xsl:text> </xsl:text>
      <xsl:value-of 
        select="customer/address[@type='business']/name/first-name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of 
        select="customer/address[@type='business']/name/last-name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of 
        select="customer/address[@type='business']/city"/>
      <xsl:text>, </xsl:text>
      <span style="font-weight: bold;">
        <xsl:value-of 
          select="customer/address[@type='business']/state"/>
      </span>
    </h2>
    <p>
      <xsl:text>Ordered on </xsl:text>
      <xsl:value-of select="date/@month"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="date/@day"/>
      <xsl:text>/</xsl:text>
      <xsl:value-of select="date/@year"/>
      <xsl:text>:</xsl:text>
    </p>
    <table width="80%" border="0">
      <tr style="background: #66FF66;">
        <th>Item</th>
        <th>Quantity</th>
        <th>Price Each</th>
        <th>Total</th>
      </tr>
      <xsl:for-each select="items/item">
        <tr>
          <xsl:attribute name="style">
            <xsl:text>background: </xsl:text>
            <xsl:choose>
              <xsl:when test="position() mod 2">
                <xsl:text>#CCCCFF</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>#66FF66</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
            <xsl:text>;</xsl:text>
          </xsl:attribute>
          <td width="40%">
            <span style="font-weight: bold;">
              <xsl:value-of select="name"/>
            </span>
            <xsl:text> (part #</xsl:text>
            <xsl:value-of select="@part-no"/>
            <xsl:text>)</xsl:text>
          </td>
          <td style="text-align: center;" width="20%">
            <xsl:value-of select="qty"/>
          </td>
          <td style="text-align: right;" width="20%">
            <xsl:value-of select="price"/>
          </td>
          <td style="text-align: right;" width="20%">
            <xsl:choose>
              <xsl:when test="position()=1">
                <xsl:value-of 
                  select="format-number(price * qty, '$#,###.00')"/>
              </xsl:when>
              <xsl:otherwise>
                <xsl:value-of 
                  select="format-number(price * qty, '#,###.00')"/>
              </xsl:otherwise>
            </xsl:choose>
          </td>
        </tr>
      </xsl:for-each>
      <tr style="font-weight: bold;">
        <td colspan="3" style="text-align: right;">
          Total for this order:
        </td>
        <td style="text-align: right; background: black; color: white;">
          <xsl:variable name="orderTotal">
            <xsl:call-template name="sumItems">
              <xsl:with-param name="items" select="items/item" />
            </xsl:call-template>      
          </xsl:variable>
          <xsl:value-of 
            select="format-number($orderTotal, '$#,###.00')"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="sumItems">
    <xsl:param name="items" />
    <xsl:param name="runningTotal" select="0" />
    <xsl:choose>
      <xsl:when test="$items">
        <xsl:variable name="firstItemSubtotal"
          select="$items[1]/qty * $items[1]/price" />
        <xsl:call-template name="sumItems">
          <xsl:with-param name="items" select="$items[position() > 1]" />
          <xsl:with-param name="runningTotal" 
            select="$runningTotal + $firstItemSubtotal" />
        </xsl:call-template>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$runningTotal" />
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>      

</xsl:stylesheet>

<?xml version="1.0"?>
<!-- masterdox3.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:states="http://www.usps.com/ncsc/lookups/abbreviations.html"
  exclude-result-prefixes="states">

  <states:name abbrev="AL">Alabama</states:name>
  <states:name abbrev="AK">Alaska</states:name>
  <states:name abbrev="AS">American Samoa</states:name>
  <states:name abbrev="AZ">Arizona</states:name>
  <states:name abbrev="AR">Arkansas</states:name>
  <states:name abbrev="CA">California</states:name>
  <states:name abbrev="CO">Colorado</states:name>
  <states:name abbrev="CT">Connecticut</states:name>
  <states:name abbrev="DE">Delaware</states:name>
  <states:name abbrev="DC">District of Columbia</states:name>
  <states:name abbrev="FM">Federated States of Micronesia</states:name>
  <states:name abbrev="FL">Florida</states:name>
  <states:name abbrev="GA">Georgia</states:name>
  <states:name abbrev="GU">Guam</states:name>
  <states:name abbrev="HI">Hawaii</states:name>
  <states:name abbrev="ID">Idaho</states:name>
  <states:name abbrev="IL">Illinois</states:name>
  <states:name abbrev="IN">Indiana</states:name>
  <states:name abbrev="IA">Iowa</states:name>
  <states:name abbrev="KS">Kansas</states:name>
  <states:name abbrev="KY">Kentucky</states:name>
  <states:name abbrev="LA">Louisiana</states:name>
  <states:name abbrev="ME">Maine</states:name>
  <states:name abbrev="MH">Marshall Islands</states:name>
  <states:name abbrev="MD">Maryland</states:name>
  <states:name abbrev="MA">Massachusetts</states:name>
  <states:name abbrev="MI">Michigan</states:name>
  <states:name abbrev="MN">Minnesota</states:name>
  <states:name abbrev="MS">Mississippi</states:name>
  <states:name abbrev="MO">Missouri</states:name>
  <states:name abbrev="MT">Montana</states:name>
  <states:name abbrev="NE">Nebraska</states:name>
  <states:name abbrev="NV">Nevada</states:name>
  <states:name abbrev="NH">New Hampshire</states:name>
  <states:name abbrev="NJ">New Jersey</states:name>
  <states:name abbrev="NM">New Mexico</states:name>
  <states:name abbrev="NY">New York</states:name>
  <states:name abbrev="NC">North Carolina</states:name>
  <states:name abbrev="ND">North Dakota</states:name>
  <states:name abbrev="MP">Northern Mariana Islands</states:name>
  <states:name abbrev="OH">Ohio</states:name>
  <states:name abbrev="OK">Oklahoma</states:name>
  <states:name abbrev="OR">Oregon</states:name>
  <states:name abbrev="PW">Palau</states:name>
  <states:name abbrev="PA">Pennsylvania</states:name>
  <states:name abbrev="PR">Puerto Rico</states:name>
  <states:name abbrev="RI">Rhode Island</states:name>
  <states:name abbrev="SC">South Carolina</states:name>
  <states:name abbrev="SD">South Dakota</states:name>
  <states:name abbrev="TN">Tennessee</states:name>
  <states:name abbrev="TX">Texas</states:name>
  <states:name abbrev="UT">Utah</states:name>
  <states:name abbrev="VT">Vermont</states:name>
  <states:name abbrev="VI">Virgin Islands</states:name>
  <states:name abbrev="VA">Virginia</states:name>
  <states:name abbrev="WA">Washington</states:name>
  <states:name abbrev="WV">West Virginia</states:name>
  <states:name abbrev="WI">Wisconsin</states:name>
  <states:name abbrev="WY">Wyoming</states:name>

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
                       text-decoration: underline;">name</span>
        </h1>
        <xsl:for-each 
          select="document(/report/po/@filename)/purchase-order
                  /customer/address/state">
          <xsl:sort 
            select="document('')/*/states:name[@abbrev=current()]"/>
          <xsl:sort select="../city"/>
          <xsl:apply-templates select="ancestor::purchase-order"/>
        </xsl:for-each> 
      </body>
    </html>
  </xsl:template>

  <xsl:template match="purchase-order">
    <h2>
      <xsl:variable name="businessAddress" 
        select="customer/address[@type='business']"/>
      <xsl:value-of 
        select="$businessAddress/name/title"/>
      <xsl:text> </xsl:text>
      <xsl:value-of 
        select="$businessAddress/name/first-name"/>
      <xsl:text> </xsl:text>
      <xsl:value-of 
        select="$businessAddress/name/last-name"/>
      <xsl:text> - </xsl:text>
      <xsl:value-of 
        select="$businessAddress/city"/>
      <xsl:text>, </xsl:text>
      <span style="font-weight: bold;">
        <xsl:value-of 
          select="document('')/*/
                  states:name[@abbrev=$businessAddress/state]"/>
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

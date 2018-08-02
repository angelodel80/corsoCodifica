<?xml version="1.0"?>
<!-- masterdox5.xsl -->
<xsl:stylesheet version="2.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema"
  xmlns:states="http://www.usps.com/ncsc/lookups/abbreviations.html"
  exclude-result-prefixes="xs states">

  <xsl:variable name="purchase-orders"
    select="document(/report/po/@filename)/purchase-order"/>

  <xsl:function name="states:getStateName" as="xs:string">
    <xsl:param name="abbr" as="xs:string"/>
    <xsl:variable name="abbreviations" as="xs:string*"
      select="'AL', 'AK', 'AS', 'AZ', 'AR', 'CA', 'CO', 'CT',
              'DE', 'DC', 'FM', 'FL', 'GA', 'GU', 'HI', 'ID',
              'IL', 'IN', 'IA', 'KS', 'KY', 'LA', 'ME', 'MH',
              'MD', 'MA', 'MI', 'MN', 'MS', 'MO', 'MT', 'NE',
              'NV', 'NH', 'NJ', 'NM', 'NY', 'NC', 'ND', 'MP',
              'OH', 'OK', 'OR', 'PW', 'PA', 'PR', 'RI', 'SC',
              'SD', 'TN', 'TX', 'UT', 'VT', 'VI', 'VA', 'WA',
              'WV', 'WI', 'WY'"/>
    <xsl:variable name="stateNames" as="xs:string*"
      select="'Alabama', 'Alaska', 'American Samoa','Arizona', 
              'Arkansas', 'California', 'Colorado', 'Connecticut', 
              'Delaware', 'District of Columbia',
              'Federated States of Micronesia', 'Florida', 'Georgia', 
              'Guam', 'Hawaii', 'Idaho', 'Illinois', 'Indiana', 
              'Iowa', 'Kansas', 'Kentucky', 'Louisiana', 'Maine', 
              'Marshall Islands', 'Maryland', 'Massachusetts', 
              'Michigan', 'Minnesota', 'Mississippi', 'Missouri', 
              'Montana', 'Nebraska', 'Nevada', 'New Hampshire',
              'New Jersey', 'New Mexico', 'New York', 
              'North Carolina', 'North Dakota', 
              'Northern Mariana Islands', 'Ohio', 'Oklahoma', 
              'Oregon', 'Palau', 'Pennsylvania', 'Puerto Rico',
              'Rhode Island', 'South Carolina', 'South Dakota',
              'Tennessee', 'Texas', 'Utah', 'Vermont', 
              'Virgin Islands', 'Virginia', 'Washington', 
              'West Virginia', 'Wisconsin', 'Wyoming'"/>
    <xsl:variable name="index"
      select="if (count(index-of($abbreviations, $abbr)) gt 0) 
              then subsequence(index-of($abbreviations, $abbr), 1, 1)
              else 0"/>
    <xsl:value-of 
      select="if ($index gt 0)
              then string(subsequence($stateNames, $index, 1))
              else ''"/>
  </xsl:function>

  <xsl:output method="html"/>

  <xsl:template match="/">
    <html>
      <head>
        <title><xsl:value-of select="/report/title"/></title>
      </head>
      <body style="font-family: sans-serif;">
        <h1>
          Selected Purchase Orders - 
          <span style="font-style: italic; 
                       text-decoration: underline;">Grouped</span>
          by state name
        </h1>
        <xsl:for-each-group 
          select="$purchase-orders" group-by="customer/address/state">
          <xsl:sort 
            select="states:getStateName(current-grouping-key())"/>
          <h2 style="color: white; background: black;">
            Purchase Orders from 
            <xsl:value-of 
              select="states:getStateName(current-grouping-key())"/>
          </h2>
          <xsl:for-each select="current-group()">
            <xsl:sort select="customer/address/city"/>
            <xsl:apply-templates select="."/>
          </xsl:for-each>
        </xsl:for-each-group>
      </body>
    </html>
  </xsl:template>

  <xsl:template match="purchase-order">
    <h3>
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
    </h3>
    <p>
      <xsl:text>Ordered on </xsl:text>
      <xsl:variable name="monthValue" as="xs:string"
        select="if (date/@month &lt; 10)
                then concat('0', date/@month)
                else date/@month"/>
      <xsl:variable name="dayValue" as="xs:string"
        select="if (date/@day &lt; 10)
                then concat('0', date/@day)
                else date/@day"/>
      <xsl:variable name="orderDate" as="xs:date"
        select="xs:date(concat(date/@year, '-', 
                               $monthValue, '-', $dayValue))"/>
      <xsl:value-of 
        select="format-date($orderDate, '[FNn], [MNn] [D1], [Y]')"/>
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
        <tr style="{if (position() mod 2) 
                   then 'background: #CCCCFF;' 
                   else 'background: #66FF66;'}">
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
            <xsl:value-of 
              select="if (position() = 1) 
                      then format-number(price * qty, '$#,###.00')
                      else format-number(price * qty, '#,###.00')"/>
          </td>
        </tr>
      </xsl:for-each>
      <tr style="font-weight: bold;">
        <td colspan="3" style="text-align: right;">
          Total for this order:
        </td>
        <td align="right" style="color: white; background: black;">
          <xsl:value-of 
            select="format-number(sum(items/item/(qty * price)), 
                                  '$#,###.00')"/>
        </td>
      </tr>
    </table>
  </xsl:template>

</xsl:stylesheet>

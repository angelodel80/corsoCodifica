<?xml version="1.0"?>
<!-- piechart-exslt.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:svg="http://www.w3.org/2000/svg"
  extension-element-prefixes="dates-and-times math"
  xmlns:math="http://exslt.org/math"
  xmlns:dates-and-times="http://exslt.org/dates-and-times">
  
  <xsl:output method="xml"/>

  <xsl:variable name="totalSales" select="sum(//brand)"/>
  <xsl:variable name="stores" select="count(/sales/store)"/>

  <xsl:template match="/">
    <svg:svg width="450" height="300" version="1.1"
      baseProfile="full"
      xmlns="http://www.w3.org/2000/svg"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      xmlns:ev="http://www.w3.org/2001/xml-events">
      <xsl:comment>
        ECMAScript to handle mouse events
      </xsl:comment>

      <!-- Our generated SVG file has three functions: -->
      <!-- - mouse_over normally displays the details for a store -->
      <!--   in place of the legend. -->
      <!-- - mouse_out normally restores the legend when the mouse -->
      <!--   leaves a slice of the pie. -->
      <!-- - click handles a mouse click on a given slice of pie. -->
      <!--   If this is the first time we've clicked on this slice, -->
      <!--   this slice becomes the current item, and its sales -->
      <!--   details are displayed until the user clicks on another -->
      <!--   slice of pie. -->
      <!--   If this is the second time we've clicked on this slice, -->
      <!--   the detials view is switched off and the normal mouse -->
      <!--   behavior returns. -->

      <svg:script type="text/ecmascript">
        <xsl:text disable-output-escaping="yes">
    
    detailsViewOn = false;
    currentItem = 0;

    function mouse_over(selectedItem, totalItems) 
    {
      if (!detailsViewOn || selectedItem == currentItem)
      {
        for (i = 1; totalItems >= i; i++)
        {
          obj = svgDocument.getElementById("details" + i);
          obj.setAttributeNS(null, "visibility", "hidden");
          obj = svgDocument.getElementById("legend" + i);
          obj.setAttributeNS(null, "visibility", "hidden");
        }
  
        obj = svgDocument.getElementById("details" + selectedItem);
        obj.setAttributeNS(null, "visibility", "visible");
      }
    }

    function mouse_out(totalItems) 
    {
      if (!detailsViewOn)
      {
        for (i = 1; totalItems >= i; i++)
        {
          obj = svgDocument.getElementById("details" + i);
          obj.setAttributeNS(null, "visibility", "hidden");
          obj = svgDocument.getElementById("legend" + i);
          obj.setAttributeNS(null, "visibility", "visible");
        }
      }
    }

    function click(selectedItem, totalItems)
    {
      if (selectedItem != currentItem)
      {
        currentItem = selectedItem;
        mouse_over(selectedItem, totalItems);
        detailsViewOn = true;
      }
      else
      {
        obj = svgDocument.getElementById("details" + selectedItem);
        if (obj.getAttributeNS(null, "visibility") == "visible")
        {
          detailsViewOn = false;
          currentItem = 0;
        }
        else
        {
          currentItem = selectedItem;
          mouse_over(selectedItem, totalItems);
          detailsViewOn = true;
        }
      }
    }
          //      </xsl:text></svg:script>
        <xsl:text>&#xA;</xsl:text>

        <!-- Generate the title and subtitle.  We draw the title and -->
        <!-- subtitle on the chart, and we set the <svg:title> element -->
        <!-- in the SVG document itself. -->
        <xsl:variable name="titleText">
          <xsl:value-of select="/report/caption/heading"/>
          <xsl:text> - </xsl:text>
          <xsl:choose>
            <xsl:when test="function-available('math:cos')">
              <xsl:variable name="dateString">
                <xsl:text>--</xsl:text>
                <xsl:if test="string-length(/report/@month) = 1">
                  <xsl:text>0</xsl:text>
                </xsl:if>
                <xsl:value-of select="/report/@month"/>
                <xsl:text>--</xsl:text>
              </xsl:variable>
              <xsl:value-of 
                select="dates-and-times:month-name($dateString)"/>
              <xsl:text> </xsl:text>
              <xsl:value-of select="/report/@year"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="/report/@month"/>
              <xsl:text>/</xsl:text>
              <xsl:value-of select="/report/@year"/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:variable>

        <svg:title>
          <xsl:value-of select="$titleText"/>
        </svg:title>
        <svg:text font-size="24px" text-anchor="start" 
          font-weight="bold" x="10" y="40">
          <xsl:value-of select="$titleText"/>
        </svg:text>
        <svg:text font-size="14px" text-anchor="middle" y="60" x="225">
          <xsl:value-of select="/report/caption/subheading"/>
        </svg:text>
        
        <xsl:variable name="totalSales" select="sum(//brand)"/>
        <xsl:variable name="stores" select="count(/report/store)"/>
        
        <xsl:for-each select="/report/store">
          <xsl:variable name="storeSales" select="sum(brand)"/>
          <xsl:variable name="color">
            <xsl:choose>
              <xsl:when test="(position() mod 6) = 1">
                <xsl:text>red</xsl:text>
              </xsl:when>
              <xsl:when test="(position() mod 6) = 2">
                <xsl:text>orange</xsl:text>
              </xsl:when>
              <xsl:when test="(position() mod 6) = 3">
                <xsl:text>purple</xsl:text>
              </xsl:when>
              <xsl:when test="(position() mod 6) = 4">
                <xsl:text>blue</xsl:text>
              </xsl:when>
              <xsl:when test="(position() mod 6) = 5">
                <xsl:text>green</xsl:text>
              </xsl:when>
              <xsl:otherwise>
                <xsl:text>gray</xsl:text>
              </xsl:otherwise>
            </xsl:choose>
          </xsl:variable>
          <xsl:variable name="explode" select="position()=1"/>
          
          <!-- Create the pie slice for each store -->
          <xsl:apply-templates select=".">
            <xsl:with-param name="color" select="$color"/>
            <xsl:with-param name="storeSales" select="$storeSales"/>
            <xsl:with-param name="totalSales" select="$totalSales"/>
            <xsl:with-param name="runningTotal" 
              select="sum(preceding-sibling::store/brand)"/>
            <xsl:with-param name="stores" select="$stores"/>
            <xsl:with-param name="explode" select="$explode"/>
            <xsl:with-param name="position" select="position()"/>
          </xsl:apply-templates>          
          
          <!-- Create the legend entry for each store -->
          <xsl:apply-templates select="." mode="legend">
            <xsl:with-param name="color" select="$color"/>
            <xsl:with-param name="storeSales" select="$storeSales"/>
            <xsl:with-param name="y-legend-offset" 
              select="90 + (position() * 20)"/>
            <xsl:with-param name="position" select="position()"/>
          </xsl:apply-templates>
          
          <!-- Create the (initially hidden) sales details for -->
          <!-- each store -->
          <xsl:apply-templates select="." mode="details">
            <xsl:with-param name="color" select="$color"/>
            <xsl:with-param name="position" select="position()"/>
            <xsl:with-param name="y-legend-offset" select="110"/>
            <xsl:with-param name="storeSales" select="$storeSales"/>
            <xsl:with-param name="totalSales" select="$totalSales"/>
          </xsl:apply-templates>
          
        </xsl:for-each>
      </svg:svg>
  </xsl:template>

  <!-- For each store, create the pie slice (<svg:path>) and the -->
  <!-- onmouseover(), onmouseout(), and onclick() event handlers. -->
  <xsl:template match="store">
    <xsl:param name="color" select="'red'"/>
    <xsl:param name="runningTotal" select="'0'"/>
    <xsl:param name="totalSales" select="'0'"/>
    <xsl:param name="storeSales" select="'0'"/>
    <xsl:param name="stores" select="'5'"/>
    <xsl:param name="explode"/>
    <xsl:param name="position" select="'1'"/>

    <xsl:variable name="currentAngle">
      <xsl:choose>
        <xsl:when test="function-available('math:cos')">
          <xsl:value-of 
            select="($storeSales div $totalSales) * 
                     6.283185307179586476925286766559"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:message terminate="yes">
            <xsl:text>Sorry, this stylesheet can't generate any </xsl:text>
            <xsl:text>useful results &#xA;  without trigonometric </xsl:text>
            <xsl:text>functions available. </xsl:text>
          </xsl:message>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable>

    <svg:path fill="{$color}" stroke="black" stroke-width="2px" 
      fillrule="evenodd" stroke-linejoin="bevel">
      <xsl:attribute name="onmouseout">
        <xsl:text>mouse_out(</xsl:text>
        <xsl:value-of select="$stores"/>
        <xsl:text>);</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="transform">
        <xsl:choose>
          <xsl:when test="$explode">
            <xsl:text>translate(</xsl:text>
            <xsl:value-of 
              select="(math:cos($currentAngle div 2) * 20) + 100"/>
            <xsl:text>,</xsl:text>
            <xsl:value-of 
              select="(math:sin($currentAngle div 2) * -20) + 160"/>
            <xsl:text>) </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>translate(100,160) </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text> rotate(</xsl:text>
        <xsl:value-of select="-1 * (($runningTotal div $totalSales) * 360.0)"/>
        <xsl:text>)</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="onmouseover">
        <xsl:text>mouse_over(</xsl:text>
        <xsl:value-of select="$position"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$stores"/>
        <xsl:text>);</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="onclick">
        <xsl:text>click(</xsl:text>
        <xsl:value-of select="$position"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$stores"/>
        <xsl:text>);</xsl:text>
      </xsl:attribute>
      <xsl:attribute name="d">
        <xsl:text>M 80 0 A 80 80 0 </xsl:text>
        <xsl:choose>
          <xsl:when test="$currentAngle &gt; 3.14">
            <xsl:text>1 </xsl:text>
          </xsl:when>
          <xsl:otherwise>
            <xsl:text>0 </xsl:text>
          </xsl:otherwise>
        </xsl:choose>
        <xsl:text>0 </xsl:text>
        <xsl:value-of 
          select="math:cos($currentAngle) * 80"/>
        <xsl:text> </xsl:text>
        <xsl:value-of 
          select="math:sin($currentAngle) * -80"/>
        <xsl:text> L 0 0 Z </xsl:text>
      </xsl:attribute>
    </svg:path>
  </xsl:template>

  <!-- For each store, create an entry in the legend -->
  <xsl:template match="store" mode="legend">
    <xsl:param name="color" select="'red'"/>
    <xsl:param name="storeSales" select="'0'"/>
    <xsl:param name="y-legend-offset" select="'0'"/>
    <xsl:param name="position" select="'1'"/>

    <svg:g>
      <xsl:attribute name="id">
        <xsl:text>legend</xsl:text><xsl:value-of select="$position"/>
      </xsl:attribute>

      <svg:text font-size="12px" text-anchor="start" x="240">
        <xsl:attribute name="y">
          <xsl:value-of select="$y-legend-offset"/>
        </xsl:attribute>
        <xsl:value-of select="name"/>
        <xsl:text>: </xsl:text>
        <xsl:value-of select="format-number($storeSales, '#,###.#')"/>
      </svg:text>
      
      <svg:path stroke="black" stroke-width="2px" fill="{$color}">
        <xsl:attribute name="d">
          <xsl:text>M 220 </xsl:text> 
          <xsl:value-of select="$y-legend-offset - 10"/>
          <xsl:text> L 220 </xsl:text> 
          <xsl:value-of select="$y-legend-offset"/>
          <xsl:text> L 230 </xsl:text> 
          <xsl:value-of select="$y-legend-offset"/>
          <xsl:text> L 230 </xsl:text> 
          <xsl:value-of select="$y-legend-offset - 10"/>
          <xsl:text> Z</xsl:text> 
        </xsl:attribute>
      </svg:path>
    </svg:g>
  </xsl:template>

  <!-- For each store, create the hidden list of sales details -->
  <xsl:template match="store" mode="details">
    <xsl:param name="color" select="black"/>
    <xsl:param name="position" select="'0'"/>
    <xsl:param name="y-legend-offset"/>
    <xsl:param name="storeSales"/>
    <xsl:param name="totalSales"/>

    <svg:g visibility="hidden">
      <xsl:attribute name="id">
        <xsl:text>details</xsl:text><xsl:value-of select="$position"/>
      </xsl:attribute>
      <svg:text font-size="16px" font-weight="bold" text-anchor="start"
        fill="black" x="220.5">
        <xsl:attribute name="y">
          <xsl:value-of select="$y-legend-offset + .5"/>
        </xsl:attribute>
        <xsl:value-of select="name"/><xsl:text> Sales:</xsl:text>
      </svg:text>
      <svg:text font-size="16px" font-weight="bold" text-anchor="start"
        fill="{$color}" x="220">
        <xsl:attribute name="y">
          <xsl:value-of select="$y-legend-offset"/>
        </xsl:attribute>
        <xsl:value-of select="name"/><xsl:text> Sales:</xsl:text>
      </svg:text>
      <xsl:for-each select="brand">
        <svg:text font-size="12px" text-anchor="start" x="220">
          <xsl:attribute name="y">
            <xsl:value-of select="$y-legend-offset + (position() * 20)"/>
          </xsl:attribute>
          <xsl:value-of select="@name"/>
          <xsl:text>: </xsl:text>
          <xsl:value-of select="format-number(., '#,###.#')"/>
        </svg:text>
      </xsl:for-each>
      <svg:text font-size="14px" font-weight="bold" text-anchor="start"
        fill="black" x="220.5" 
        y="{$y-legend-offset + 20.5 + (count(brand) * 20)}">
        <xsl:value-of select="format-number($storeSales div $totalSales, '##%')"/>
        <xsl:text> of total</xsl:text>
      </svg:text>
      <svg:text font-size="14px" font-weight="bold" text-anchor="start"
        fill="{$color}" x="220" 
        y="{$y-legend-offset + 20 + (count(brand) * 20)}">
        <xsl:value-of select="format-number($storeSales div $totalSales, '##%')"/>

      </svg:text>
    </svg:g>
  </xsl:template>

</xsl:stylesheet>

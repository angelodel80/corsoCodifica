<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://www.tei-c.org/ns/1.0" exclude-result-prefixes="t" 
                version="2.0">

<!-- ****DEPRECATED**** -->
<!-- As far as I'm aware this stylesheet is not used anywhere any more.
      The matching of square brackets is now performed by  [htm|txt]-tpl-sqbrackets.xsl
      which is called after all other processing is completed, just prior to printing the output
      (and called in start-text.xsl or tpl-structure.xsl)
   -->

  <!-- Templates for opening and closing brackets for gap and supplied [@reason = 'lost'] -->
  
  
  <xsl:template name="lost-opener">
    <!-- Relationship: start at x going to y -->
    <xsl:choose>
      <!--1.1
        ````````__|__
        ```````|`````|
        ```````y`````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="preceding-sibling::t:*[1][@reason='lost']">
            <xsl:if test="preceding-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>


         <!--1.2
        ````````__|__
        ```````|`````|
        ```````y```__z__
        ``````````|`````|
        ``````````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::t:*)][not(preceding-sibling::text()) or
                                       translate(normalize-space(preceding-sibling::text()), ' ', '') = '']
                                   /parent::t:*[preceding-sibling::t:*[1][@reason='lost']]">
            <xsl:if test="parent::t:*[preceding-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>
      

         <!--1.3
        ````````______|______
        ```````|`````````````|
        ```````y```````````__z__
        ``````````````````|`````|
        ````````````````__z__
        ```````````````|`````|
        ```````````````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      
      <xsl:when test="current()[not(preceding-sibling::t:*)]
                                             [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                             [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                             /parent::t:*[not(preceding-sibling::t:*)] 
                                             [not(preceding-sibling::node()[1][self::text()]) or 
                                             preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
                                             /parent::t:*[preceding-sibling::t:*[1][@reason='lost']]">
            <xsl:if test="parent::t:*/parent::t:*[preceding-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>
      

         <!--2.1
        ````````__|__
        ```````|`````|
        `````__z__```x
        ````|`````|
        ``````````y
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                       [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                       /preceding-sibling::t:*[1]/t:*[@reason='lost'][not(following-sibling::t:*)]">
            <xsl:if test="preceding-sibling::t:*[1]/t:*[@reason='lost'][not(following-sibling::t:*)]
                                       [following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>

         <!--2.2
        ````````____|____
        ```````|`````````|
        `````__z__`````__z__
        ````|`````|```|`````|
        ``````````y```x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::t:*)]
                                       [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                       [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                       /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][preceding-sibling::t:*[1]]
                                       [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                       [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                       /preceding-sibling::t:*[1]/t:*[@reason='lost'][not(following-sibling::t:*)]">
            <xsl:if test="parent::t:*/preceding-sibling::t:*[1]
                                       /t:*[@reason='lost'][not(following-sibling::t:*)]
                                       [following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!--2.3
        ````````______|______
        ```````|`````````````|
        `````__z__`````````__z__
        ````|`````|```````|`````|
        ``````````y`````__z__
        ```````````````|`````|
        ```````````````x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::t:*)]
                                            [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                            [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                            /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][not(preceding-sibling::t:*)]
                                            [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                            [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                            /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][preceding-sibling::t:*[1]]
                                            [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                            [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                            /preceding-sibling::t:*[1]
                                            /t:*[@reason='lost'][not(following-sibling::t:*)]">
            <xsl:if test="parent::t:*/parent::t:*/preceding-sibling::t:*[1]
                                 /t:*[@reason='lost'][not(following-sibling::t:*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>


         <!--3.1
        ````````____|____
        ```````|`````````|
        `````__z__```````x
        ````|`````|
        ````````__z__
        ```````|`````|
        `````````````y
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]         /preceding-sibling::t:*[1]         /t:*[not(following-sibling::t:*)]         [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]         /t:*[@reason='lost'][not(following-sibling::t:*)]">
            <xsl:if test="preceding-sibling::t:*[1]/t:*           /t:*[@reason='lost'][not(following-sibling::t:*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!--3.2
        ````````_______|_______
        ```````|```````````````|
        `````__z__```````````__z__
        ````|`````|`````````|`````|
        ````````__z__```````x
        ```````|`````|
        `````````````y
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::t:*)]
                                            [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                            [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                            /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][preceding-sibling::t:*[1]]
                                            [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                            [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                            /preceding-sibling::t:*[1]
                                            /t:*[not(following-sibling::t:*)] 
                                            [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                            [self::text() and translate(normalize-space(.), ' ', '') = '']] 
                                            /t:*[@reason='lost'][not(following-sibling::t:*)]">
            <xsl:if test="parent::t:*/preceding-sibling::t:*[1]/t:*           /t:*[@reason='lost'][not(following-sibling::t:*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!--3.3 
        ````````______|______
        ```````|`````````````|
        `````__z__`````````__z__
        ````|`````|```````|`````|
        ````````__z__```__z__
        ```````|`````|`|`````|
        `````````````y`x
        If y is a text() then output '['
        If y is 'lost' then nothing
      -->
      <xsl:when test="current()[not(preceding-sibling::t:*)]
                                         [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                         [self::text() and translate(normalize-space(.), ' ', '') = '']]
                                         /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][not(preceding-sibling::t:*)]   
                                         [not(preceding-sibling::node()[1][self::text()]) or 
                                         preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]  
                                         /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][preceding-sibling::t:*[1]]   
                                         [not(preceding-sibling::node()[1][self::text()]) or preceding-sibling::node()[1]
                                         [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                         /preceding-sibling::t:*[1]   
                                         /t:*[not(following-sibling::t:*)]    
                                         [not(preceding-sibling::node()[1][self::text()]) or 
                                         preceding-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]   
                                         /t:*[@reason='lost'][not(following-sibling::t:*)]">
            <xsl:if test="parent::t:*/parent::t:*/preceding-sibling::t:*[1]/t:*
               /t:*[@reason='lost'][not(following-sibling::t:*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>[</xsl:text>
            </xsl:if>
         </xsl:when>
            
      
         <xsl:otherwise>
            <xsl:text>[</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>


  <xsl:template name="lost-closer">
    <!-- 
      In the diagrams above corresponding to the same number
      Relationship: start at y going to x
      And so the 'y' in the comments should be replaced with 'x' 
    -->
    <xsl:choose>
      <!-- 1.1 -->
      <xsl:when test="following-sibling::t:*[1][@reason='lost']">
            <xsl:if test="following-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!-- 1.2 -->
      <xsl:when test="current()[not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]
                                   /following-sibling::t:*[1]/t:*[@reason='lost'][not(preceding-sibling::t:*)]">
            <xsl:if test="following-sibling::t:*[1]/t:*[@reason='lost'][not(preceding-sibling::t:*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!-- 1.3 -->
      <xsl:when test="current()[not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]         /following-sibling::t:*[1]         /t:*[not(preceding-sibling::t:*)]         [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]         /t:*[@reason='lost'][not(preceding-sibling::t:*)]">
            <xsl:if test="following-sibling::t:*[1]/t:*           /t:*[@reason='lost'][not(preceding-sibling::t:*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!-- 2.1 -->
      <xsl:when test="current()[not(following-sibling::t:*)]
         [not(following-sibling::text()) or translate(normalize-space(following-sibling::text()[1]), ' ', '') = '']
         /parent::t:*[following-sibling::t:*[1][@reason='lost']]">
            <xsl:if test="parent::t:*[following-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>

      
         <!-- 2.2 -->
      <xsl:when test="current()[not(following-sibling::t:*)]   
                                          [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                          [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                          /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][following-sibling::t:*[1]]     
                                          [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                          [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                          /following-sibling::t:*[1]/t:*[@reason='lost'][not(preceding-sibling::t:*)]">
            <xsl:if test="parent::t:*/preceding-sibling::t:*[1]    
               /t:*[@reason='lost'][not(following-sibling::t:*)][following-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!-- 2.3 -->
      <xsl:when test="current()[not(following-sibling::t:*)]   
                                          [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                          [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                          /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][following-sibling::t:*[1]]    
                                          [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                          [self::text() and translate(normalize-space(.), ' ', '') = '']]   
                                          /following-sibling::t:*[1]   
                                          /t:*[not(preceding-sibling::t:*)]   
                                          [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                          [self::text() and translate(normalize-space(.), ' ', '') = '']]     
                                          /t:*[@reason='lost'][not(preceding-sibling::t:*)]">
            <xsl:if test="parent::t:*/following-sibling::t:*[1]/t:*    
               /t:*[@reason='lost'][not(preceding-sibling::t:*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!-- 3.1 -->
      <xsl:when test="current()[not(following-sibling::t:*)]     
         [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]         /parent::t:*[not(following-sibling::t:*)]         [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1][self::text() and translate(normalize-space(.), ' ', '') = '']]         /parent::t:*[following-sibling::t:*[1][@reason='lost']]">
            <xsl:if test="parent::t:*/parent::t:*[following-sibling::node()[1][self::text()][not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
         
      
         <!-- 3.2 -->
      <xsl:when test="current()[not(following-sibling::t:*)]    
                                           [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                           [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                           /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][not(following-sibling::t:*)]      
                                           [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                           [self::text() and translate(normalize-space(.), ' ', '') = '']]     
                                           /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][following-sibling::t:*[1]]    
                                           [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                           [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                           /following-sibling::t:*[1]     
                                           /t:*[@reason='lost'][not(preceding-sibling::t:*)]">
            <xsl:if test="parent::t:*/parent::t:*/following-sibling::t:*[1]      
               /t:*[@reason='lost'][not(preceding-sibling::t:*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <!-- 3.3 -->
      <xsl:when test="current()[not(following-sibling::t:*)]    
                                             [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                             [self::text() and translate(normalize-space(.), ' ', '') = '']]  
                                             /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][not(following-sibling::t:*)]     
                                             [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                             [self::text() and translate(normalize-space(.), ' ', '') = '']]     
                                             /parent::t:*[not(local-name() = ('ab','egXML','l','item'))][following-sibling::t:*[1]]      
                                             [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                             [self::text() and translate(normalize-space(.), ' ', '') = '']]     
                                             /following-sibling::t:*[1]     
                                             /t:*[not(preceding-sibling::t:*)]  
                                             [not(following-sibling::node()[1][self::text()]) or following-sibling::node()[1]
                                             [self::text() and translate(normalize-space(.), ' ', '') = '']]    
                                             /t:*[@reason='lost'][not(preceding-sibling::t:*)]">
            <xsl:if test="parent::t:*/parent::t:*/following-sibling::t:*[1]/t:*    
               /t:*[@reason='lost'][not(preceding-sibling::t:*)][preceding-sibling::text()[not(translate(normalize-space(.), ' ', '') = '')]]">
               <xsl:text>]</xsl:text>
            </xsl:if>
         </xsl:when>
      
      
         <xsl:otherwise>
            <xsl:text>]</xsl:text>
         </xsl:otherwise>
      </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
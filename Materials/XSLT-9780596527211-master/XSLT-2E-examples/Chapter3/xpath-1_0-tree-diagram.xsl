<?xml version="1.0" encoding="utf-8"?>
<!--xpath-1_0-tree-diagram.xsl -->
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:xs="http://www.w3.org/2001/XMLSchema">
  
  <xsl:output method="html"/>
  
  <xsl:template match="/">
    <html>
      <head>
        <title>XPath view of your document</title>
        <style type="text/css">
          <xsl:comment>
            .literal   { font-family: Courier, monospace; }
            .docroot   { background-color: #99CCCC; }
            .element   { background-color: #CCCC99; }
            .attribute { background-color: #FFFF99; }
            .text      { background-color: #FFCC99; }
            .comment   { background-color: #CCCCFF; }
            .pi        { background-color: #99FF99; }
            .namespace { background-color: #CC99CC; }
            .box       { border: solid black 3px; }
          </xsl:comment>
        </style>
      </head>
      <body style="font-family: sans-serif;">
        <h1>XPath view of your document</h1>
        <p>
          The structure of your document (as XPath sees it)        
          is outlined below.
        </p>
        <table cellspacing="5" cellpadding="2" border="0">
          <tr>
            <td colspan="7">
              <b>Node types:</b>
            </td>
          </tr>
          <tr>
            <td class="docroot"><b>document root</b></td>
            <td class="element"><b>element</b></td>
            <td class="attribute"><b>attribute</b></td>
            <td class="text"><b>text</b></td>
            <td class="comment"><b>comment</b></td>
            <td class="pi"><b>processing instruction</b></td>
            <td class="namespace"><b>namespace</b></td>
          </tr>
        </table>
        <br/>
        <table width="100%" class="box" bgcolor="#FFFFFF" 
          title="document root" alt="document root">
          <tr class="docroot">
            <td colspan="3">
              <b>document root:</b>
            </td>
          </tr>
          <tr>
            <td width="15" class="docroot"></td>
            <td>
              <table width="100%">
                <xsl:apply-templates 
                  select="*|comment()|processing-instruction()|text()"/>
              </table>
            </td>
            <td width="15" class="docroot"></td>
          </tr>
          <tr class="docroot">
            <td colspan="3">&#160;</td>
          </tr>
        </table>
      </body>
    </html>
  </xsl:template>
  
  <xsl:template match="comment()">
    <tr>
      <td class="comment">
        <b>comment: </b>
        <span class="literal">
          <xsl:value-of select="."/>
        </span>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="processing-instruction()">
    <tr>
      <td class="pi">
        <b>processing instruction: </b>
        <span class="literal">
          <xsl:text>&lt;?</xsl:text>
          <xsl:value-of select="name()"/>
          <xsl:text>?&gt;</xsl:text>
          <br/>
          <xsl:value-of select="."/>
        </span>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="text()">
    <xsl:if test="string-length(normalize-space(.))">
      <tr>
        <td class="text" width="100%">
          <b>text: </b>
          <span class="literal">
            <xsl:value-of select="."/>
          </span>
        </td>
      </tr>
    </xsl:if>
  </xsl:template>
  
  <xsl:template name="namespace-node">
    <tr>
      <td class="namespace">
        <b>namespace: </b>
        <span class="literal">
          <xsl:value-of select="name()"/>
        </span>
        <br/>
        <span class="literal">
          <xsl:value-of select="."/>
        </span>
      </td>
    </tr>
  </xsl:template>
  
  <xsl:template match="*">
    <xsl:variable name="title">
      <xsl:for-each select="ancestor-or-self::*">
        <xsl:text>/</xsl:text>
        <xsl:value-of select="name()"/>
      </xsl:for-each>
    </xsl:variable>
    <tr title="{$title}" alt="{$title}">
      <td>
        <table class="box" width="100%">
          <tr>
            <td class="element" colspan="3" valign="top">
              <b>element: </b>
              <span class="literal">
                <xsl:text>&lt;</xsl:text>
                <xsl:value-of select="name()"/>
                <xsl:text>&gt;</xsl:text>
              </span>
            </td>
          </tr>
          <tr>
            <td class="element" width="15">&#160;&#160;</td>
            <td>
              <table border="0" width="100%">
                <xsl:if test="count(@*) &gt; 0">
                  <tr>
                    <td>
                      <table width="100%">
                        <tr class="attribute"> 
                          <td width="20%">
                            <b>attribute name</b>
                          </td>
                          <td>
                            <b>value</b>
                          </td>
                        </tr>
                        <xsl:for-each select="@*">
                          <tr class="attribute">
                            <td width="20%">
                              <span class="literal">
                                <xsl:value-of select="name()"/>
                              </span>
                            </td>
                            <td>
                              <span class="literal">
                                <xsl:value-of select="."/>
                              </span>
                            </td>
                          </tr>
                        </xsl:for-each>
                      </table>
                    </td>
                  </tr>
                </xsl:if>
                <xsl:for-each select="namespace::*">
                  <xsl:if test="name() != 'xml'">
                    <xsl:call-template name="namespace-node"/>
                  </xsl:if> 
                </xsl:for-each>
                <xsl:apply-templates select="node()"/>
              </table>
            </td>
            <td class="element" width="15">&#160;</td>
          </tr>
          <tr>
            <td colspan="3" class="element">&#160;</td>
          </tr>
        </table>
      </td>
    </tr>
  </xsl:template>
  
</xsl:stylesheet>

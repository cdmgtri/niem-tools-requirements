<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xml="http://www.w3.org/XML/1998/namespace"
   xmlns:saxon="http://saxon.sf.net/"
   version="2.0">

  <xsl:output method="text" encoding="UTF-8"/>

  <xsl:template match="node[empty(ancestor::node)]" priority="1">
    <xsl:text>---&#10;</xsl:text>
    <xsl:text>title: </xsl:text>
    <xsl:value-of select="@TEXT"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="//node[@STYLE_REF = 'metadata']" mode="metadata"/>
    <xsl:text>---&#10;</xsl:text>
    <xsl:apply-templates select="node"/>
  </xsl:template>

  <xsl:template match="node[@STYLE_REF = 'metadata']" mode="metadata">
    <xsl:value-of select="@TEXT"/>
    <xsl:text>&#10;</xsl:text>
  </xsl:template>

  <xsl:template match="node[@STYLE_REF = 'metadata']" priority="1">
    <!-- ignore metadata -->
  </xsl:template>

  <xsl:template match="node[@STYLE_REF = 'heading']">
    <xsl:text>&#10;</xsl:text>
    <xsl:for-each select="1 to (count(ancestor-or-self::node[@STYLE_REF = 'heading']))">
      <xsl:text>#</xsl:text>
    </xsl:for-each>
    <xsl:text> </xsl:text>
    <xsl:value-of select="@TEXT"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="node"/>
  </xsl:template>

  <xsl:template match="node[empty(@STYLE_REF)]"
                priority="-1">
    <xsl:for-each select="1 to (count(ancestor-or-self::node[empty(@STYLE_REF)]) - 1)">
      <xsl:text>   </xsl:text>
    </xsl:for-each>
    <xsl:choose>
      <xsl:when test="empty(@STYLE_REF)">
        <xsl:text>- </xsl:text>
      </xsl:when>
    </xsl:choose>
    <xsl:value-of select="@TEXT"/>
    <xsl:text>&#10;</xsl:text>
    <xsl:apply-templates select="node"/>
  </xsl:template>

  <xsl:template match="text()" mode="#all"/>

</xsl:stylesheet>

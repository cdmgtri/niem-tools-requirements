<xsl:stylesheet
   xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
   xmlns:xs="http://www.w3.org/2001/XMLSchema"
   xmlns:xml="http://www.w3.org/XML/1998/namespace"
   xmlns:saxon="http://saxon.sf.net/"
   version="2.0">

  <xsl:output method="xml" encoding="UTF-8"/>

  <xsl:param name="title" select="()"/>

  <xsl:template match="/">
    <xsl:if test="empty($title)">
      <xsl:message terminate="yes">Parameter $title must be set.</xsl:message>
    </xsl:if>
    <xsl:variable name="matches" select="//node[@TEXT = $title]"/>
    <xsl:choose>
      <xsl:when test="count($matches) = 0">
        <xsl:message terminate="yes">No matches</xsl:message>
      </xsl:when>
      <xsl:when test="count($matches) = 1">
        <xsl:copy-of select="$matches"/>
      </xsl:when>
      <xsl:when test="count($matches) > 1">
        <xsl:message terminate="yes">Too many matches (<xsl:value-of select="count($matches)"/>)</xsl:message>
      </xsl:when>
    </xsl:choose>
  </xsl:template>

  <xsl:template match="text()" mode="#all"/>

</xsl:stylesheet>

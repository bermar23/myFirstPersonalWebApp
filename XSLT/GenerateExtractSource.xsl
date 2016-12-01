<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="xs ati xd" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xmlns:ati="http://www.asiatype.com/Hachette/EPubConversion/XSLT/Functions" version="2.0">
    <xd:doc scope="stylesheet">
        <xd:desc>
            <xd:p><xd:b>Created on:</xd:b> Nov 19, 2010</xd:p>
            <xd:p><xd:b>Author:</xd:b> jeffsese</xd:p>
            <xd:p>Used to create a source XML to be used to create exttract files for ePub Generation.</xd:p>
            <xd:p>The length of extract should follow the following rules:</xd:p>
            <xd:ul>
                <xd:li>The extract stop at the first chapter.</xd:li>
                <xd:li>The number of characters of the extract should not be greater than 5% of the total number of characters of the book. And should be cut at ongoing paragraph.</xd:li>
            </xd:ul>
        </xd:desc>
    </xd:doc>
    <xsl:variable name="charCount" as="xs:double" select="sum(for $i in (/DOCUMENT/*[position() > 2]//text()[not(matches(., '^$'))]) return string-length($i))"/>
    <xsl:variable name="targetID" as="xs:string+" select="ati:hachette.extract(/DOCUMENT/*[position() > 2]//*[text()[not(matches(., '^$'))]], 0)"/>
    <xsl:function name="ati:hachette.extract" as="xs:string+">
        <xsl:param name="nodes" as="node()*"/>
        <xsl:param name="curLength" as="xs:double"/>
        <xsl:variable name="newLength" as="xs:double" select="$curLength + string-length($nodes[1])"/>
        <!--<xsl:message select="$nodes[1]"/>-->
        <!--<xsl:message select="$newLength"/>-->
        <xsl:choose>
            <xsl:when test="$newLength lt (.05 * $charCount) and not(empty(remove($nodes, 1))) and exists($nodes[1][ancestor::CHAP[count(preceding-sibling::DOCUMENT) = 0] or ancestor::PREFACE[parent::DOCUMENT]]) and exists($nodes[2][ancestor::CHAP[count(preceding-sibling::CHAP) = 0] or ancestor::PREFACE[parent::DOCUMENT]])">
                <xsl:sequence select="generate-id($nodes[1])"/>
                <xsl:sequence select="ati:hachette.extract(remove($nodes, 1), $newLength)"/>
            </xsl:when>
            <xsl:otherwise>
                <xsl:sequence select="generate-id($nodes[1])"/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:function>
	
	
    <xsl:template match="element()">
        <xsl:copy>
            <xsl:apply-templates select="@*,node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="element()[text()[not(matches(., '^$'))]][generate-id(.) = $targetID]">
        <xsl:copy>
            <!--<xsl:attribute name="genid" select="generate-id(.)"/>-->
            <xsl:apply-templates select="@*,node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="attribute()|text()[not(matches(., '^$'))]|comment()|processing-instruction()">
        <xsl:copy/>
    </xsl:template>
	<xsl:template match="//PART/PARTBODY/CHAP[preceding-sibling::CHAP]"/>
  <xsl:template match="DOCINDEX"/>
	<xsl:template match="PARTSN"/>
	<xsl:template match="CHAPSN"/>
	<xsl:template match="EPILOGUE"/>
	<xsl:template match="BIB"/>
		<xsl:template match="ANNEXES"/>
</xsl:stylesheet>

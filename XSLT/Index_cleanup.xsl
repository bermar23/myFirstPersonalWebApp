<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl" xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml" exclude-result-prefixes="#all" version="2.0">
    <!--<xsl:character-map name="mycharmap">
        <xsl:output-character character="" string=""/>
    </xsl:character-map>-->
    <xsl:output encoding="UTF-8" method="xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" version="1.0" indent="no"/>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="html">

        <html>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </html>
    </xsl:template>
    <xsl:template match="head | title | link | body | p | div">
        <xsl:text>&#xa;</xsl:text>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>


    <xsl:template match="span[@class='link']">
<xsl:variable name="link">
<xsl:number select="." level="any" from="p"></xsl:number>
</xsl:variable>[<xsl:value-of select="$link"/>]</xsl:template>

<xsl:template match="//p[@class='idx1'][not(descendant::a)][descendant::text()=preceding::text()[ancestor::p]]"/>
<xsl:template match="//p[@class='idx2'][text()[1]=preceding::text()]"/>



</xsl:stylesheet>

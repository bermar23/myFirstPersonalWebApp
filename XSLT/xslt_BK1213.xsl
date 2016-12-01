<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
    xpath-default-namespace="http://www.w3.org/1999/xhtml" xmlns="http://www.w3.org/1999/xhtml"
    exclude-result-prefixes="#all" version="2.0">
    <xsl:output encoding="UTF-8" method="xhtml" doctype-public="-//W3C//DTD XHTML 1.1//EN"
        doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd" version="1.0" indent="no"/>
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

    
    
    <xsl:template match="p[@class='zoom']">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <span class="body-justify">
                <xsl:apply-templates/>
            </span>
        </xsl:copy>
    </xsl:template>
    
    
    
    
</xsl:stylesheet>
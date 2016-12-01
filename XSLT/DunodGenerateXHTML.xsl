<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns="http://www.w3.org/1999/xhtml"
    xmlns:opf="http://www.idpf.org/2007/opf" xmlns:ncx="http://www.daisy.org/z3986/2005/ncx/"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    xmlns:ati="http://www.asiatype.com/Hachette/EPubConversion/XSLT/Functions" exclude-result-prefixes="#all">
    <xsl:param name="outputFolder" as="xs:string" select="'tmp'"/>
    <xsl:character-map name="map">
        
        <xsl:output-character character="&#x2002;" string="&#xA0;"/>
        <xsl:output-character character="&#x2009;" string=""/>
    </xsl:character-map>
    <xsl:output method="xml" encoding="UTF-8" indent="yes"/>
    <xsl:output method="xhtml" encoding="UTF-8" name="epub" omit-xml-declaration="yes"
        doctype-public="-//W3C//DTD XHTML 1.1//EN" doctype-system="http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd"
        exclude-result-prefixes="opf" use-character-maps="map"/>
    <xsl:variable name="ean" as="xs:string" select="DOCUMENT/RDF/EAN13"/>
    <xsl:key name="folio" match="@folio[not(parent::corps)]" use="."/>
    
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxSTART DOCUMENTxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="DOCUMENT">
        <xsl:result-document href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_opf.opf'), base-uri())}">
            <xsl:element name="package" namespace="http://www.idpf.org/2007/opf">
                <xsl:attribute name="unique-identifier" select="'ean'"/>
                <xsl:attribute name="version" select="'2.0'"/>
                <xsl:element name="metadata" namespace="http://www.idpf.org/2007/opf"
                    xmlns:dc="http://purl.org/dc/elements/1.1/">
                    <xsl:namespace name="dc" select="'http://purl.org/dc/elements/1.1/'"/>
                    <dc:title>
                        <xsl:value-of select="replace(RDF/TITRE, '&#x00a0;', '&#x0020;')"/>
                    </dc:title>
                    <dc:creator>
                        <xsl:value-of select="RDF/AUTEUR"/>
                    </dc:creator>
                    <dc:publisher>
                        <xsl:text>Dunod</xsl:text>
                    </dc:publisher>
                    <dc:identifier id="ean">
                        <xsl:value-of select="RDF/EAN13"/>
                    </dc:identifier>
                    <dc:language>fr</dc:language>
                    <xsl:element name="meta" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="name" select="'cover'"/>
                        <!--<xsl:attribute name="content" select="generate-id(RDF/TITRE/descendant::img)"/>-->
                        <xsl:attribute name="content" select="'cover-image'"/>
                    </xsl:element>
                    <xsl:element name="meta" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="name" select="'DTD'"/>
                        <xsl:attribute name="content" select="'-//HACHETTE-LIVRE//DTD Litterature Generale V4//FR'"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="manifest" namespace="http://www.idpf.org/2007/opf">
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id" select="'cover-image'"/>
                        <xsl:attribute name="href" select="'images/cover.jpg'"/>
                        <xsl:attribute name="media-type" select="'image/jpeg'"/>
                    </xsl:element>
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id" select="'stylesheet'"/>
                        <xsl:attribute name="href" select="'DunodEpubV1.0.css'"/>
                        <xsl:attribute name="media-type" select="'text/css'"/>
                    </xsl:element>
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id" select="'ncx'"/>
                        <xsl:attribute name="href" select="'toc.ncx'"/>
                        <xsl:attribute name="media-type" select="'application/x-dtbncx+xml'"/>
                    </xsl:element>
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                            <xsl:attribute name="id" select="'toc'"/>
                            <xsl:attribute name="href" select="concat($ean, '_toc.xhtml')"/>
                            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
                    </xsl:element>
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id" select="'tp'"/>
                        <xsl:attribute name="href" select="concat($ean, '_tp.xhtml')"/>
                        <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
                    </xsl:element>
                    <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id" select="'coverpage'"/>
                        <xsl:attribute name="href" select="concat($ean, '_coverpage.xhtml')"/>
                        <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
                    </xsl:element>
                           <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="id" select="'copyright-image'"/>
                        <xsl:attribute name="href" select="'images/PIV-002-V.jpg'"/>
                        <xsl:attribute name="media-type" select="'image/jpeg'"/>
                    </xsl:element>

                    <xsl:apply-templates mode="manifest"/>
            <xsl:apply-templates select="descendant::INCLUDEGRAPHIC" mode="manifest"/>
                  
                </xsl:element>
                <xsl:element name="spine" namespace="http://www.idpf.org/2007/opf">
                    <xsl:attribute name="toc" select="'ncx'"/>
                    <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="idref" select="'coverpage'"/>
                    </xsl:element>
                    <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                        <xsl:attribute name="idref" select="'tp'"/>
                    </xsl:element>
                        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                            <xsl:attribute name="idref" select="'cop'"/>
                        </xsl:element>
                        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
                            <xsl:attribute name="idref" select="'toc'"/>
                        </xsl:element>
                    <xsl:apply-templates mode="spine"/>
                </xsl:element>
            </xsl:element>
        </xsl:result-document>
        
        <xsl:result-document format="epub" href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_tp.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="tp"/>
                    </p>
                    <h1 class="book-titre"><xsl:apply-templates select="RDF/TITRE"/></h1>
                    <h3 class="book-auteur"><xsl:apply-templates select="RDF/AUTEUR"/></h3>
                </body>
            </html>
        </xsl:result-document>
        <xsl:result-document format="epub" href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_coverpage.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>                    
                        
                    <div id="coverpage"><img src="images/cover.jpg" alt="001" id="coverpage1" class="imgpp" /></div>
                </body>
            </html>
        </xsl:result-document>


 <xsl:result-document format="epub" href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_toc.xhtml'), base-uri())}">
      <html>
        <head>
          <title>Table des Matières</title>
          <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
         </head>
        <body>
          <p><a id="toc"/></p>
          <h2 class="chapter-title">Table des Matières</h2>
         <xsl:apply-templates mode="toc"/>
        </body>
      </html>
    </xsl:result-document>

        <xsl:result-document href="{resolve-uri(concat($outputFolder, '/OEBPS/', 'toc.ncx'), base-uri())}">
            <xsl:element name="ncx" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="version" select="'2005-1'"/>
                <xsl:element name="head" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:element name="meta" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="name" select="'dtb:uid'"/>
                        <xsl:attribute name="content" select="$ean"/>
                    </xsl:element>
                    <xsl:element name="meta" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="name" select="'dc:Title'"/>
                        <xsl:attribute name="content" select="DOCUMENT/RDF/TITRE"/>
                    </xsl:element>
                    <xsl:element name="meta" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="name" select="'dtb:depth'"/>
                        <xsl:attribute name="content" select="'7'"/>
                    </xsl:element>
                    <xsl:element name="meta" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="name" select="'dtb:totalPageCount'"/>
                        <xsl:attribute name="content" select="'1'"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="docTitle" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:value-of select="//DOCUMENT/RDF/TITRE"/>
                    </xsl:element>
                </xsl:element>
                <xsl:element name="navMap" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="id" select="'coverpage'"/>
                        <xsl:attribute name="playOrder" select="'1'"/>
                        <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                <xsl:text>Couverture</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:attribute name="src" select="concat($ean, '_coverpage.xhtml')"/>
                        </xsl:element>
                    </xsl:element>
                    <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="id" select="'tp'"/>
                        <xsl:attribute name="playOrder" select="'2'"/>
                        <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                <xsl:text>Page de Titre</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:attribute name="src" select="concat($ean, '_tp.xhtml')"/>
                        </xsl:element>



                    </xsl:element>
                        
                    <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
                        <xsl:attribute name="id" select="'cop'"/>
                        <xsl:attribute name="playOrder" select="'3'"/>
                        <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                <xsl:text>Page de Copyright</xsl:text>
                            </xsl:element>
                        </xsl:element>
                        <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:attribute name="src" select="concat($ean, '_cp.xhtml')"/>
                        </xsl:element>
                    </xsl:element>




           <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
                            <xsl:attribute name="id" select="'toc'"/>
                            <xsl:attribute name="playOrder" select="'4'"/>
                            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                    <xsl:text>Table des Mati&#x00E8;res</xsl:text>
                                </xsl:element>
                            </xsl:element>
                            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                <xsl:attribute name="src" select="concat($ean, '_toc.xhtml')"/>
                            </xsl:element>
                        </xsl:element>
		                    <xsl:apply-templates select="TDM" mode="ncx"/>

        <xsl:apply-templates mode="ncx"/>
                </xsl:element>
               
                </xsl:element>
           </xsl:result-document>

        <xsl:result-document href="{resolve-uri(concat($outputFolder, '/META-INF/container.xml'), base-uri())}">
            <container version="1.0" xmlns="urn:oasis:names:tc:opendocument:xmlns:container">
                <rootfiles>
                    <rootfile full-path="OEBPS/{$ean}_opf.opf" media-type="application/oebps-package+xml"/>
                </rootfiles>
            </container>
        </xsl:result-document>
        <xsl:apply-templates select="node()[not(self::TDM)]"/>
            <xsl:if test="$outputFolder = 'extract'">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="DOCUMENT/RDF/TITRE"/>
                    </title>
<style type="text/css">
INSERT HEAD STYLE HERE
                   
</style>
                </head>
                <body>
                     <p>
                        <a id="coverpage"/>
                    </p>
                    <div><img src="images/cover.jpg" alt="001" id="coverpage1" class="imgpp" /></div>
                    <xsl:apply-templates select="TDM"/>
                    
                    <p>
                        <a id="tp"/>
                    </p>
                    <h1 class="book-titre"><xsl:apply-templates select="RDF/TITRE"/></h1>
                    <h3 class="book-auteur"><xsl:apply-templates select="RDF/AUTEUR"/></h3>
                    <xsl:apply-templates select="*[self::RDF or self::DEDICACE or self::INTRODUCTION 
                    															or self::AVANTPROPOS or self::PREFACE
                    															or self::PART]" mode="extract"/>
                </body>
            </html>
        </xsl:if>
   
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx COPYRIGHT xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <!--<xsl:template match="RDF" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'cop'"/>
        </xsl:element>
    </xsl:template>-->
<xsl:template match="RDF" mode="spine"/>
    <xsl:variable name="additivePlayOrder" as="xs:integer" select="if (exists(//TDM)) then 3 else 2"/>

<xsl:template match="DOCUMENT/RDF" mode="ncx"/>
<xsl:template match="DOCUMENT/RDF" mode="toc"/>
   
<!-- 
    <xsl:template match="DOCUMENT/RDF" mode="ncx">
        <xsl:variable name="play.order" as="xs:string" select="xs:string($additivePlayOrder)"/>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'cop'"/>
            <xsl:attribute name="playOrder" select="$play.order"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:text>Page de Copyright</xsl:text>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_cp.xhtml')"/>
            </xsl:element>
        </xsl:element>
    </xsl:template>-->
    
    <xsl:template match="DOCUMENT/RDF" mode="manifest">


        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'cop'"/>
            <xsl:attribute name="href" select="concat($ean, '_cp.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="DOCUMENT/RDF" mode="extract">
        <div class="cop">
           
       <p class="cop" id="cop"> </p>
         <p class="cop"> </p>
         <p class="cop">Consultez nos parutions sur <a href="http://www.dunod.com" shape="rect"><span class="hyperlink-url">www.dunod.com</span></a></p>
         <p class="cop"> </p>
         <p class="cop"><xsl:value-of select="RDF/COPYRIGHT"/></p>
         <p class="cop">ISBN <xsl:call-template name="isbnformat"><xsl:with-param name="value" select="//EAN13EPUB"/></xsl:call-template></p>
       
            <p class="cop">Consultez le <a href="insertURLhere" shape="rect">site web de cet ouvrage</a></p>
         <p class="cop"> </p>
         <div class="figure"><img src="images/PIV-002-V.jpg" alt="PIV-002-V.jpg" class="image-copyright" /></div>
      
        </div>
    </xsl:template>


<xsl:template name="isbnformat">
<xsl:param name="value"/>
<xsl:choose>
<xsl:when test="string-length(EAN13) = 13">
<xsl:value-of select="substring($value,1,3)"/>-<xsl:value-of select="substring($value,4,1)"/>-<xsl:value-of select="substring($value,5,2)"/>-<xsl:value-of select="substring($value,6,6)"/>-<xsl:value-of select="substring($value,13,1)"/>
</xsl:when>
<xsl:otherwise>
<xsl:value-of select="$value"/>
</xsl:otherwise>
</xsl:choose>
</xsl:template>


 <xsl:template match="DOCUMENT/RDF">

        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_cp.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="DOCUMENT/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                      <div class="cop">
           
       <p class="cop" id="cop"> </p>
         <p class="cop"> </p>
         <p class="cop">Consultez nos parutions sur <a href="http://www.dunod.com" shape="rect"><span class="bold"><span class="hyperlink-url">www.dunod.com</span></span></a></p>
         <p class="cop"> </p>
         <p class="cop"><xsl:value-of select="//RDF/COPYRIGHT"/></p>
         <p class="cop">ISBN <xsl:call-template name="isbnformat"><xsl:with-param name="value" select="//EAN13"/></xsl:call-template></p>
       
                          <p class="cop">Consultez le <a href="insertURLhere" shape="rect">site web de cet ouvrage</a></p>
         <p class="cop"> </p>
         <div class="figure"><img src="images/PIV-002-V.jpg" alt="PIV-002-V.jpg" class="image-copyright" /></div>
      
        </div>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>
 
   <xsl:template match="COPYRIGHT" mode="cp">
        <div class="cop">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
   <xsl:template match="TITRE" mode="cp">
        <div class="fmtit">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
<xsl:template match="SOUSTITRE" mode="cp">
        <div class="fmstit">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="EAN13" mode="cp">
        <div class="bkcopy">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="SUJET" mode="cp">
        <div class="bkcopy">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="DESCRIPTION" mode="cp">
        <div class="fmp-j">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="MAQUETTE" mode="cp">
        <div class="fmp-j">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
    <xsl:template match="NUMERO" mode="cp">
        <div class="fmp-j">
            <xsl:apply-templates/>
        </div>
    </xsl:template>
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DEDICACE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="DEDICACE" mode="ncx ncx_oui"/>
<xsl:template match="DEDICACE" mode="toc"/>


    <xsl:template match="//DEDICACE" mode="manifest">
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'ded'"/>
            <xsl:attribute name="href" select="concat($ean, '_ded', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

  <xsl:template match="//DEDICACE" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'ded'"/>
        </xsl:element>
    </xsl:template>
 
 
     <xsl:template match="//DEDICACE" mode="#default">
        <xsl:result-document format="epub" href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_ded.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="ded"/>
                    </p>
                    <xsl:apply-templates select="//DEDICACE"  mode="ded"/>
                </body>
            </html>
        </xsl:result-document>
</xsl:template>

<xsl:template match="//DEDICACE" mode="ded">
        <div class="ded">
            <xsl:apply-templates/>
        </div>
    </xsl:template>



<xsl:template match="//DEDICACE/PARA" mode="extract #default">
        <p class="dedicace-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/GENERICPARA" mode="extract #default">
        <p class="dedicace-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="//DEDICACE/PARALIBRE" mode="extract #default">
        <p class="dedicace-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/PARAPLUS" mode="extract #default">
        <p class="dedicace-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/PARASIGNATURE" mode="extract #default">
        <p class="dedicace-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="//DEDICACE/PARAGRAPHIQUE" mode="extract #default">
        <p class="dedicace-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="dedicace-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/LISTE" mode="extract #default">
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="dedicace-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="dedicace-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="dedicace-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="dedicace-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="dedicace-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="dedicace-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="//DEDICACE/RENVOI" mode="extract #default">
        <p class="dedicace-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="//DEDICACE/FORMULE" mode="extract #default">
        <p class="dedicace-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/NEWPAGE" mode="extract #default">
        <p class="dedicace-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="//DEDICACE/NOTETAB" mode="extract #default">
        <p class="dedicace-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="//DEDICACE/NOTEFIG" mode="extract #default">
        <p class="dedicace-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx INTRODUCTION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="INTRODUCTION" mode="toc">
    
  <p class="fmtoc"><a href="{concat($ean, '_intro', '.xhtml')}">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::INTODUCTION]][not(ancestor::INDEX)]"/>
            </xsl:variable>
                    <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Introduction'"/></a></p>
    <xsl:apply-templates select="descendant::chapter" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_intro', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>
  



<xsl:template match="INTRODUCTION" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
            <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM]"
                level="any"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'intro'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                                   <xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::INTODUCTION]][not(ancestor::INDEX)]"/>
            </xsl:variable>
                    <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Introduction'"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_intro', '.xhtml')"/>
            </xsl:element>
            <xsl:apply-templates select="descendant::SECT1 | descendant::dev" mode="ncx">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_intro', '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>    
        </xsl:element>
    </xsl:template>

<xsl:template match="INTRODUCTION" mode="manifest">
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'intro'"/>
            <xsl:attribute name="href" select="concat($ean, '_intro', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>
<xsl:template match="INTRODUCTION" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'intro'"/>
        </xsl:element>
    </xsl:template>

  <xsl:template match="INTRODUCTION" mode="extract">
        <p>
            <a id="intro"/>
        </p>
            <xsl:apply-templates select="INTRODUCTION"/>
       </xsl:template>


 <xsl:template match="INTRODUCTION" mode="#default">
<xsl:result-document format="epub" href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_intro.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                <p class="courant-texte"><a id="intro"></a></p>
                <table width="100%" cellpadding="0" cellspacing="0" class="chapitre">
                    <colgroup>
                        <col width="25%"/>
                        <col width="75%"/>
                    </colgroup>
                    <tr>
                        <td class="chap-num"> </td>
                        <td class="chap-titre">
                            <h2 class="fm-titre">Introduction</h2></td>
                    </tr></table>
                    
       <div class="intro">
                     <xsl:apply-templates/>
    </div>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-intro"/>
                        </div>
                        </xsl:if>
</body>
            </html>
        </xsl:result-document>
     </xsl:template>  

<xsl:template match="//FOOTNOTE/PARA" mode="fnote-intro">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="INTRODUCTION" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>

</xsl:template>





 
<xsl:template match="INTRODUCTION/TITRE">
        <h2 class="fm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<xsl:template match="INTRODUCTION/SOUSTITRE">
        <h2 class="fm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="INTRODUCTION/AUTEUR">
        <h3 class="fm-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="INTRODUCTION/PARA">
    <p class="courant-texte"><xsl:apply-templates/></p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TDM xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

   

    <xsl:template match="TDM" mode="manifest spine"/>
		<xsl:template match="TDM" mode="ncx">
			<xsl:apply-templates mode="ncx_oui"/>
		</xsl:template>

    
    <xsl:key name="nonTDM" match="*[not(ancestor::tdm-oui)]" use="@id"/>
    <xsl:function name="ati:getTocLink" as="xs:string">
        <xsl:param name="id"/>
        <xsl:variable name="appennum" as="xs:string">
            <xsl:number level="any" format="01"
                select="if ($id[self::schap]) then $id/ancestor::chap[1] else
                                                      if ($id[self::SECT1 or self::niv2 or self::niv3 or self::niv4 or self::niv5]) then $id/ancestor::dev/parent::* else
                                                        $id"
            />
        </xsl:variable>
        <xsl:sequence
            select="if ($id[self::appen]) then concat($ean, '_appen', $appennum, '.xhtml') else
                              if ($id[self::CHAP]) then concat($ean, '_ch', $appennum, '.xhtml') else
                              if ($id[self::part]) then concat($ean, '_p', $appennum, '.xhtml') else
                              if ($id[self::PREFACE]) then concat($ean, '_pre', $appennum, '.xhtml') else
                              if ($id[self::schap]) then concat($ean, '_ch', $appennum, '.xhtml#', ($id/@id, generate-id($id))[1]) else
                              if ($id[self::SECT1 or self::niv2 or self::niv3 or self::niv4 or self::niv5] and $id[ancestor::chap]) then concat($ean, '_ch', $appennum, '.xhtml#', ($id/@id, generate-id($id))[1]) else
                              if ($id[self::SECT1 or self::niv2 or self::niv3 or self::niv4 or self::niv5] and $id[ancestor::pre]) then concat($ean, '_pre', $appennum, '.xhtml#', ($id/@id, generate-id($id))[1]) else
                              if ($id[self::SECT1 or self::niv2 or self::niv3 or self::niv4 or self::niv5] and $id[ancestor::appen]) then concat($ean, '_appen', $appennum, '.xhtml#', ($id/@id, generate-id($id))[1]) else
                               concat($id/name(), $id/@id)"
        />
    </xsl:function>
    
<xsl:template match="TDM/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
 

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PREFACE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PREFACE" mode="toc">
            <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
  <p class="fmtoc"><a href="{concat($ean, '_pre', $prenum, '.xhtml')}">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PREFACE]][not(ancestor::INDEX)]"/>
            </xsl:variable>
                    <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Préface'"/></a></p>
    <xsl:apply-templates select="descendant::SECT1" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_pre', $prenum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>


    <xsl:template match="PREFACE" mode="spine">
        <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="concat('pre', $prenum)"/>
        </xsl:element>
    </xsl:template>
    <xsl:function name="ati:navLabelNormalize" as="xs:string">
        <xsl:param name="input" as="node()*"/>
        <xsl:value-of select="replace(replace(replace(replace(replace(replace(replace($input, '&#xa;', ' '), '&#x2009;', ''), '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' '), '  ', ' ')"/>
    </xsl:function>
    <xsl:template match="PREFACE" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
            <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('pre', $prenum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
               <xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PREFACE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
<xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Préface'"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_pre', $prenum, '.xhtml')"/>
            </xsl:element>
            <xsl:apply-templates select="descendant::SECT1 | descendant::dev" mode="ncx">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_pre', $prenum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>

    <xsl:template match="PREFACE" mode="manifest">
        <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('pre', $prenum)"/>
            <xsl:attribute name="href" select="concat($ean, '_pre', $prenum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="PREFACE" mode="extract">
        <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <p>
            <a id="pre{$prenum}"/>
        </p>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="PREFACE">
        <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_pre', $prenum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="pre{$prenum}"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-pre"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


<xsl:template match="//FOOTNOTE/PARA" mode="fnote-pre">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PREFACE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


    <xsl:template match="PREFACE/TITRE" mode="extract #default">
        <h2 class="fm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

    <xsl:template match="PREFACE/SOUSTITRE" mode="extract #default">
        <h2 class="fm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


    <xsl:template match="PREFACE/AUTEUR" mode="extract #default">
        <h3 class="fm-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PART xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PART" mode="toc">
            <xsl:variable name="ptnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
  <p class="pttoc"><a href="{concat($ean, '_p', $ptnum, '.xhtml')}">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PART]][not(ancestor::INDEX)]"/>
            </xsl:variable>
                    <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
    <xsl:apply-templates select="if (descendant::CHAP) then descendant::CHAP else descendant::SECT1" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_p', $ptnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>


    <xsl:template match="PART" mode="spine">
        <xsl:variable name="partnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="concat('p', $partnum)"/>
        </xsl:element>
        <xsl:apply-templates select="descendant::*[self::ARTICLE or self::CHAP or self::PREFACE or self::AVANTPROPOS or self::INTRODUCTION or
                                     self::PROLOGUE or self::BIB or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or
                                     self::CONCLUSION or self::COMPTERENDUS or self::LECTURES]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_p', $partnum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="PART" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
            <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="partnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('p', $partnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
               <xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PART]][not(ancestor::INDEX)]"/>
            </xsl:variable>
                    <xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_p', $partnum, '.xhtml')"/>
            </xsl:element>
            <xsl:apply-templates select="descendant::*[self::ARTICLE or self::CHAP or self::PREFACE or self::AVANTPROPOS or self::INTRODUCTION or
                                     self::PROLOGUE or self::BIB or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or
                                     self::CONCLUSION or self::COMPTERENDUS or self::LECTURES]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_p', $partnum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
<xsl:template match="PART" mode="manifest">
        <xsl:variable name="partnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('p', $partnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_p', $partnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
        <xsl:apply-templates select="descendant::*[self::ARTICLE or self::CHAP or self::PREFACE or self::AVANTPROPOS or self::INTRODUCTION or
                                     self::PROLOGUE or self::BIB or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or
                                     self::CONCLUSION or self::COMPTERENDUS or self::LECTURES]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_p', $partnum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
    </xsl:template>
    <xsl:template match="PART" mode="extract">
        <xsl:variable name="partnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <p>
            <a id="p{$partnum}"/>
        </p>
        <xsl:apply-templates select="descendant::CHAP[1]" mode="extract"/>
    </xsl:template>
    <xsl:template match="PART">
        <xsl:variable name="partnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_p', $partnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="p{$partnum}"/>
                    </p>
                    <xsl:apply-templates/>
                    <xsl:if test="descendant::FOOTNOTE[not(ancestor::CHAP or ancestor::CHAPSN or ancestor::CHAPSNP or ancestor::CHAPDIV or ancestor::ARTICLE or ancestor::DICODIVISION or ancestor::ANNEXES or ancestor::ANN or ancestor::ANNSN 
                            or ancestor::PREFACE or ancestor::AVANTPROPOS or ancestor::INTRODUCTION or ancestor::PROLOGUE or ancestor::BIB or ancestor::GLOSSAIRE or ancestor::EPILOGUE or ancestor::POSTFACE or ancestor::PRELUDE 
                            or ancestor::CONCLUSION or ancestor::COMPTERENDUS or ancestor::LECTURES)]">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-pt"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

<xsl:template match="//FOOTNOTE/PARA" mode="fnote-pt">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PART" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<xsl:template match="PART/TITRE" mode="extract #default">
        <h2 class="part-titre">
            <xsl:apply-templates mode="#current"/>
        </h2>
    </xsl:template>

<xsl:template match="PART/SOUSTITRE" mode="extract #default">
        <h2 class="part-soustitre">
            <xsl:apply-templates mode="#current"/>
        </h2>
    </xsl:template>



<xsl:template match="PART/AUTEUR" mode="extract #default">
        <h3 class="part-auteur">
            <xsl:apply-templates mode="#current"/>
        </h3>
    </xsl:template>

<xsl:template match="PART/EXERGUE" mode="extract #default">
        <div class="part-exergue">
            <xsl:apply-templates mode="#current"/>
        </div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CHAP xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="CHAP" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="CHAP" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_ch', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::CHAP]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_ch', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>




    <xsl:template match="CHAP" mode="spine">
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="concat('ch', $chapnum)"/>
        </xsl:element>
    </xsl:template>
    <!--<xsl:template match="corps/chap" mode="ncx">-->
    <xsl:template match="CHAP" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('ch', $chapnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::CHAP]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
<xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_ch', $chapnum, '.xhtml')"/>
            </xsl:element>
            <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_ch', $chapnum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
   <xsl:template match="CHAP" mode="manifest">
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('ch', $chapnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_ch', $chapnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>
<xsl:template match="CHAP[preceding-sibling::CHAP]" mode="extract"/>

<xsl:template match="CHAP" mode="extract">
	      <xsl:variable name="prenum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <p>
            <a id="chap{$prenum}"/>
        </p>
        <xsl:apply-templates mode="#current"/>
	<xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-chap"/>
                        </div>
	</xsl:if>
	</xsl:template>

    <!--<xsl:template match="corps/chap">-->
    <xsl:template match="CHAP">
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_ch', $chapnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="ch{$chapnum}"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-chap"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

<xsl:template match="CHAP/TITRE" mode="extract #default">
    <table width="100%" cellpadding="0" cellspacing="0" class="chap">
        <colgroup>
            <col width="25%"/>
            <col width="75%"/>
            
        </colgroup>
        
        <tr>
            <td class="chap-num">
                <h1 class="chap-num"><span class="chap-num">Chapitre</span><br/>#</h1></td>
            <td class="chap-titre">
                <h2 class="chap-titre">
            <xsl:apply-templates/>
                </h2></td>
        </tr></table>
        
    </xsl:template>



<xsl:template match="CHAP/SOUSTITRE" mode="extract #default">
        <h2 class="chap-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<xsl:template match="CHAP/AUTEUR" mode="extract #default">
        <h3 class="chap-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="CHAP/EXERGUE" mode="extract #default">
        <div class="chap-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-chap">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="CHAP" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FOOTNOTE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="//FOOTNOTE">

<xsl:if test="ancestor::CHAP">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="CHAP" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::PREFACE">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PREFACE" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::INTRODUCTION">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="INTRODUCTION" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>



<xsl:if test="ancestor::AVANTPROPOS">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="AVANTPROPOS" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::CHAPSN">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="CHAPSN" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::PARTSN and not(ancestor::ANNEXES or ancestor::ANN or ancestor::CHAP or ancestor::CHAPSNP or ancestor::CHAPSN)">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PARTSN" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

    
<xsl:if test="ancestor::PROLOGUE">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PROLOGUE" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::BIB[not(ancestor::CHAP)]">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="BIB" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::GLOSSAIRE">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="GLOSSAIRE" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::POSTFACE">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="POSTFACE" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::PRELUDE">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PRELUDE" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::CONCLUSION">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="CONCLUSION" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::COMPTERENDUS">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="COMPTERENDUS" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::LECTURES">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="LECTURES" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>

<xsl:if test="ancestor::EPILOGUE">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="EPILOGUE" level="any"></xsl:number>
</xsl:variable>
<a href="#footnote{$footnote}" id="footnoteref{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>
</xsl:if>


</xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CHAPSN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="CHAPSN" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="CHAPSN" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_chsn', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::CHAPSN]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_chsn', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



    <xsl:template match="CHAPSN" mode="spine">
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="concat('chsn', $chapnum)"/>
        </xsl:element>
    </xsl:template>
    <!--<xsl:template match="corps/chap" mode="ncx">-->
    <xsl:template match="CHAPSN" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="chapsnnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('chsn', $chapsnnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::CHAPSN]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
<xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_chsn', $chapsnnum, '.xhtml')"/>
            </xsl:element>
            <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_chsn', $chapsnnum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
   <xsl:template match="CHAPSN" mode="manifest">
        <xsl:variable name="chapsnnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('chsn', $chapsnnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_chsn', $chapsnnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>
    <!--<xsl:template match="corps/chap">-->
    <xsl:template match="CHAPSN">
        <xsl:variable name="chapsnnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_chsn', $chapsnnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="chsn{$chapsnnum}"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-chsn"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


<xsl:template match="//FOOTNOTE/PARA" mode="fnote-chsn">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="CHAPSN" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<xsl:template match="CHAPSN/TITRE" mode="extract #default">
    
    
    <table width="100%" cellpadding="0" cellspacing="0" class="chap">
        <colgroup>
            <col width="25%"/>
            <col width="75%"/>
            
        </colgroup>
        
        <tr>
            <td class="chap-num">
                <h1 class="chap-num"> </h1></td>
            <td class="chap-titre">
                <h2 class="chapsn-titre">
                    <xsl:apply-templates/>
                </h2></td>
        </tr></table>
        </xsl:template>



<xsl:template match="CHAPSN/SOUSTITRE" mode="extract #default">
        <h2 class="chapsn-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<xsl:template match="CHAPSN/AUTEUR" mode="extract #default">
        <h3 class="chapsn-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="CHAPSN/EXERGUE" mode="extract #default">
        <div class="chapsn-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARTSN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PARTSN" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="PARTSN" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_ptsn', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PARTSN]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::DICOENTREE or self::ANNEXES or self::ANN or self::CHAP or self::CHAPSNP or self::CHAPSN]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_ptsn', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



    <xsl:template match="PARTSN" mode="spine">
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="concat('ptsn', $chapnum)"/>
        </xsl:element>
<xsl:apply-templates select="descendant::CHAPSN" mode="spine"/>
    </xsl:template>
    <!--<xsl:template match="corps/chap" mode="ncx">-->
    <xsl:template match="PARTSN" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="chapsnnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('ptsn', $chapsnnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PARTSN]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
<xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_ptsn', $chapsnnum, '.xhtml')"/>
            </xsl:element>
            <xsl:apply-templates select="descendant::*[self::SECT1[not(ancestor::*[self::CHAPSN or self::ANNEXES or self::ANN or self::CHAP or self::CHAPSNP])] or self::CHAPSN or self::ANNEXES or self::ANN or self::CHAP or self::CHAPSNP]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_ptsn', $chapsnnum, '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
    </xsl:template>
   <xsl:template match="PARTSN" mode="manifest">
        <xsl:variable name="chapsnnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('ptsn', $chapsnnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_ptsn', $chapsnnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
        <xsl:apply-templates select="descendant::*[self::DICOENTREE or self::ANNEXES or self::ANN or self::CHAP or self::CHAPSNP or self::CHAPSN]" mode="#current"/>
     
    </xsl:template>
    <!--<xsl:template match="corps/chap">-->
    <xsl:template match="PARTSN">
        <xsl:variable name="chapsnnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_ptsn', $chapsnnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="ptsn{$chapsnnum}"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE[not(ancestor::ANNEXES or ancestor::ANN or ancestor::CHAP or ancestor::CHAPSNP or ancestor::CHAPSN)]">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-ptsn"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA[not(ancestor::CHAPSN)]" mode="fnote-ptsn">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PARTSN" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>



<xsl:template match="PARTSN/TITRE" mode="extract #default">
        <h2 class="partsn-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<xsl:template match="PARTSN/SOUSTITRE" mode="extract #default">
        <h2 class="partsn-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<xsl:template match="PARTSN/AUTEUR" mode="extract #default">
        <h3 class="partsn-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="PARTSN/EXERGUE" mode="extract #default">
        <div class="partsn-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SOMMAIRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="SOMMAIRE" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="SOMMAIRE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_somm', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::SOMMAIRE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_somm', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



  
<xsl:template match="SOMMAIRE" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'somm'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::SOMMAIRE]][not(ancestor::INDEX)]"/>
            </xsl:variable> 
<xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_somm', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="SOMMAIRE" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'somm'"/>
            <xsl:attribute name="href" select="concat($ean, '_somm', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>
  <xsl:template match="SOMMAIRE" mode="spine">
          <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'somm'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="SOMMAIRE">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_somm', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="som"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-som"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

<xsl:template match="//FOOTNOTE/PARA" mode="fnote-som">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="SOMMAIRE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


  
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx AVANT PROPOS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="AVANTPROPOS" mode="toc">
          <p class="fmtoc"><a href="{concat($ean, '_ap', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::AVANTPROPOS]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Avant Propos'"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_ap', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



  
<xsl:template match="AVANTPROPOS" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
        <xsl:variable name="chapnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'ap'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::AVANTPROPOS]][not(ancestor::INDEX)]"/>
            </xsl:variable>                     
<xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Avant Propos'"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_ap', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="AVANTPROPOS" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'ap'"/>
            <xsl:attribute name="href" select="concat($ean, '_ap', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

 <xsl:template match="AVANTPROPOS" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'ap'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="AVANTPROPOS">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_ap', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    
                    <p><a id="ap"/></p>
                    <table width="100%" cellpadding="0" cellspacing="0" class="chapitre">
                        <colgroup>
                            <col width="25%"/>
                            <col width="75%"/>
                        </colgroup>
                        <tr>
                            <td class="chap-num"> </td>
                            <td class="chap-titre">
                                <h2 class="fm-titre">Avant-propos</h2></td>
                        </tr></table>
                    
                    
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-ap"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-ap">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="AVANTPROPOS" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>



<xsl:template match="AVANTPROPOS/TITRE" mode="extract #default">
        <h2 class="fm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
  
<xsl:template match="AVANTPROPOS/SOUSTITRE" mode="extract #default">
        <h2 class="fm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

 
<xsl:template match="AVANTPROPOS/AUTEUR" mode="extract #default">
        <h2 class="fm-auteur">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
  
  

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PROLOGUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->



<xsl:template match="PROLOGUE" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="PROLOGUE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_pro', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PROLOGUE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_pro', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  
<xsl:template match="PROLOGUE" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'pro'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PROLOGUE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                         
<xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_pro', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="PROLOGUE" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'pro'"/>
            <xsl:attribute name="href" select="concat($ean, '_pro', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

<xsl:template match="PROLOGUE" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'pro'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="PROLOGUE">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_pro', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="pro"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-pro"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-pro">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PROLOGUE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<xsl:template match="PROLOGUE/TITRE" mode="extract #default">
        <h2 class="fm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="PROLOGUE/SOUSTITRE" mode="extract #default">
        <h2 class="fm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ARTICLE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="ARTICLE" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="ARTICLE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_art', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::ARTICLE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_art', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  
<xsl:template match="ARTICLE" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      <xsl:variable name="artnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('art', $artnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
<xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::ARTICLE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                                             
<xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_art', $artnum, '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="ARTICLE" mode="manifest">
      <xsl:variable name="artnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('art', $artnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_art', $artnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="ARTICLE" mode="spine">
<xsl:variable name="artnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
      
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
           <xsl:attribute name="idref" select="concat('art', $artnum)"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="ARTICLE">
      <xsl:variable name="artnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_art', $artnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="art{$artnum}"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-art"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>




<xsl:template match="//FOOTNOTE/PARA" mode="fnote-art">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="ARTICLE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<xsl:template match="ARTICLE/TITRE" mode="extract #default">
        <h2 class="art-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="ARTICLE/SOUSTITRE" mode="extract #default">
        <h3 class="art-soustitre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>


<xsl:template match="ARTICLE/TITREEN" mode="extract #default">
        <p class="art-titreen">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ARTICLE/SOUSTITREEN" mode="extract #default">
        <p class="art-soustitreen">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ARTICLE/AUTEUR" mode="extract #default">
        <p class="art-auteur">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ARTICLE/AUTEURREF" mode="extract #default">
        <p class="art-auteurref">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ARTICLE/EXERGUE" mode="extract #default">
        <div class="art-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="ARTICLE/ARTICLEBODY" mode="extract #default">
        <div class="articlebody">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LECTURES xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="LECTURES" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="LECTURES" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_lect', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::LECTURES]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_lect', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>


  
<xsl:template match="LECTURES" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      <xsl:variable name="lectnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('lect', $lectnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::LECTURES]][not(ancestor::INDEX)]"/>
            </xsl:variable>                      
            <xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_lect', $lectnum, '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="LECTURES" mode="manifest">
      <xsl:variable name="lectnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('lect', $lectnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_lect', $lectnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="LECTURES" mode="spine">
   <xsl:variable name="lectnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
         
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
         <xsl:attribute name="idref" select="concat('lect', $lectnum)"/>
            
        </xsl:element>
    </xsl:template>



    <xsl:template match="LECTURES">
      <xsl:variable name="lectnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_lect', $lectnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="lect{$lectnum}"/>
                    </p>
                    <xsl:apply-templates/>
                         <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-lect"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>




<xsl:template match="//FOOTNOTE/PARA" mode="fnote-lect">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="LECTURES" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<xsl:template match="LECTURES/TITRE" mode="extract #default">
        <h2 class="lect-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<xsl:template match="LECTURES/SOUSTITRE" mode="extract #default">
        <h3 class="lect-soustitre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>


<xsl:template match="LECTURES/SOUSTITRE" mode="extract #default">
        <h2 class="lect-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ANNEXES xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->



<xsl:template match="ANNEXES" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="ANNEXES" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_annex', $chapnum, '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::ANNEXES]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_annex', $chapnum, '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  
<xsl:template match="ANNEXES" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      <xsl:variable name="annexnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="concat('annex', $annexnum)"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                  
<xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_annex', $annexnum, '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="ANNEXES" mode="manifest">
      <xsl:variable name="annexnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="concat('annex', $annexnum)"/>
            <xsl:attribute name="href" select="concat($ean, '_annex', $annexnum, '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>



<xsl:template match="ANNEXES" mode="spine">
   <xsl:variable name="annexnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
      
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
         <xsl:attribute name="idref" select="concat('annex', $annexnum)"/>
               
        </xsl:element>
    </xsl:template>



    <xsl:template match="ANNEXES">
      <xsl:variable name="annexnum" as="xs:string">
            <xsl:number level="any" format="01"/>
        </xsl:variable>
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_annex', $annexnum, '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="annex{$annexnum}"/>
                    </p>
                    <xsl:apply-templates/>
                         <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-annex"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>




<xsl:template match="//FOOTNOTE/PARA" mode="fnote-annex">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="ANNEXES" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<xsl:template match="ANNEXES/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="ANNEXES/SOUSTITRE" mode="extract #default">
        <h3 class="bm-soustitre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>


<xsl:template match="ANNEXES/AUTEUR" mode="extract #default">
        <h3 class="annexes-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="ANNEXES/EXERGUE" mode="extract #default">
        <div class="annexes-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx BIB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->





<xsl:template match="BIB[parent::DOCUMENT]" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="BIB" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_bib', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::BIB]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize($title) else 'Bibliographie'"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_bib', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>


  
<xsl:template match="BIB[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'bib'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize(TITRE) else 'Bibliographie'"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_bib', '.xhtml')"/>
            </xsl:element>
<xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
                <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_bib', '.xhtml')"
                    tunnel="yes"/>
            </xsl:apply-templates>
        </xsl:element>
   </xsl:template>

<xsl:template match="BIB[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'bib'"/>
            <xsl:attribute name="href" select="concat($ean, '_bib', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="BIB[parent::DOCUMENT]" mode="spine">
   
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
         <xsl:attribute name="idref" select="'bib'"/>
                  
        </xsl:element>
    </xsl:template>




    <xsl:template match="BIB[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_bib', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="bib"/>
                    </p>
                    <xsl:apply-templates/>
                          <xsl:if test="descendant::FOOTNOTE[not(ancestor::CHAP)]">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-bib"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-bib">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="BIB" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<xsl:template match="BIB/TITRE" mode="extract #default">
    <table width="100%" cellpadding="0" cellspacing="0" class="chapitre">
        <colgroup>
            <col width="25%"/>
            <col width="75%"/>
            
        </colgroup>
        <tr>
            <td class="chap-num"> </td>
            <td class="chap-titre">
                <h2 class="bm-titre">
        
            <xsl:apply-templates/>
        </h2></td>
        </tr></table>
    </xsl:template>
<xsl:template match="BIB/SOUSTITRE" mode="extract #default">
        <h3 class="bm-soustitre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>


<xsl:template match="BIB/AUTEUR" mode="extract #default">
        <h3 class="bib-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="BIB/EXERGUE" mode="extract #default">
        <div class="bib-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ANN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->





<xsl:template match="ANN[parent::DOCUMENT]" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="ANN" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_ann', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::ANN]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_ann', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



  
<xsl:template match="ANN[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'ann'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_ann', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="ANN[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'ann'"/>
            <xsl:attribute name="href" select="concat($ean, '_ann', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


    <xsl:template match="ANN[parent::DOCUMENT]" mode="spine">
     <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
         <xsl:attribute name="idref" select="'ann'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="ANN[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_ann', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="ann"/>
                    </p>
                    <xsl:apply-templates/>
                           <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-ann"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>





<xsl:template match="//FOOTNOTE/PARA" mode="fnote-ann">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="ANN" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<xsl:template match="ANN/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<xsl:template match="ANN/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<xsl:template match="ANN/AUTEUR" mode="extract #default">
        <h3 class="ann-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="ANN/EXERGUE" mode="extract #default">
        <div class="ann-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ANNSN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->





<xsl:template match="ANNSN[parent::DOCUMENT]" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="ANNSN" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_annsn', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::ANNSN]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_annsn', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



  
<xsl:template match="ANNSN[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'annsn'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_annsn', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="ANNSN[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'annsn'"/>
            <xsl:attribute name="href" select="concat($ean, '_annsn', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="ANNSN[parent::DOCUMENT]" mode="spine">
     <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
         <xsl:attribute name="idref" select="'annsn'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="ANNSN[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_annsn', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="annsn"/>
                    </p>
                    <xsl:apply-templates/>
                          <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-annsn"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-annsn">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="ANNSN" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<xsl:template match="ANNSN/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<xsl:template match="ANNSN/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<xsl:template match="ANNSN/AUTEUR" mode="extract #default">
        <h3 class="annsn-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="ANNSN/EXERGUE" mode="extract #default">
        <div class="annsn-exergue">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx GLOSSAIRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->



<xsl:template match="GLOSSAIRE[parent::DOCUMENT]" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="GLOSSAIRE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_glo', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::GLOSSAIRE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_glo', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  
<xsl:template match="GLOSSAIRE[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'glo'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_glo', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="GLOSSAIRE[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'glo'"/>
            <xsl:attribute name="href" select="concat($ean, '_glo', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="GLOSSAIRE[parent::DOCUMENT]" mode="spine">
     <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
         <xsl:attribute name="idref" select="'glo'"/>
        </xsl:element>
    </xsl:template>




    <xsl:template match="GLOSSAIRE[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_glo', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="glo"/>
                    </p>
                    <xsl:apply-templates/>
                          <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-glo"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>





<xsl:template match="//FOOTNOTE/PARA" mode="fnote-glo">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="GLOSSAIRE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<xsl:template match="GLOSSAIRE/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<xsl:template match="GLOSSAIRE/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EPILOGUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="EPILOGUE[parent::DOCUMENT]" mode="toc">
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="EPILOGUE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_epi', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::EPILOGUE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize(TITRE) else 'Épilogue'"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_epi', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  

<xsl:template match="EPILOGUE[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or  self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'epi'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="if (child::TITRE) then ati:navLabelNormalize(TITRE) else 'Épilogue'"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_epi', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="EPILOGUE[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'epi'"/>
            <xsl:attribute name="href" select="concat($ean, '_epi', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

<xsl:template match="EPILOGUE[parent::DOCUMENT]" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'epi'"/>
        </xsl:element>
    </xsl:template>
 
    <xsl:template match="EPILOGUE[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_epi', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="epi"/>
                    </p>
                    <xsl:apply-templates/>

        <xsl:if test="descendant::FOOTNOTE">
                    <div class="fnote">
                    <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-epi"/>
                    </div>
        </xsl:if>

                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


<xsl:template match="EPILOGUE/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="EPILOGUE/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="EPILOGUE/AUTEUR" mode="extract #default">
        <h3 class="bm-auteur">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<xsl:template match="//FOOTNOTE/PARA" mode="fnote-epi">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="EPILOGUE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx POSTFACE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="POSTFACE[parent::DOCUMENT]" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="POSTFACE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_pf', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::POSTFACE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_pf', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  

<xsl:template match="POSTFACE[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'pf'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_pf', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="POSTFACE[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'pf'"/>
            <xsl:attribute name="href" select="concat($ean, '_pf', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>

<xsl:template match="POSTFACE[parent::DOCUMENT]" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'pf'"/>
        </xsl:element>
    </xsl:template>
 


    <xsl:template match="POSTFACE[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_pf', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="pf"/>
                    </p>
                    <xsl:apply-templates/>
                         <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-pf"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


<xsl:template match="//FOOTNOTE/PARA" mode="fnote-pf">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="POSTFACE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<xsl:template match="POSTFACE/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>
<xsl:template match="POSTFACE/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PRELUDE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

 
<xsl:template match="PRELUDE[parent::DOCUMENT]" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="PRELUDE" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_pl', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::PRELUDE]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_pl', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>



  
<xsl:template match="PRELUDE[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'pl'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_pl', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="PRELUDE[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'pl'"/>
            <xsl:attribute name="href" select="concat($ean, '_pl', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="PRELUDE[parent::DOCUMENT]" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'pl'"/>
        </xsl:element>
    </xsl:template>
 


    <xsl:template match="PRELUDE[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_pl', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="pl"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-pl"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-pl">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="PRELUDE" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>
<xsl:template match="PRELUDE/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="PRELUDE/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CONCLUSION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="CONCLUSION[parent::DOCUMENT]" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="CONCLUSION" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_con', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::CONCLUSION]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_con', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>




<xsl:template match="CONCLUSION[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'con'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_con', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>


<xsl:template match="CONCLUSION[parent::DOCUMENT]" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'con'"/>
        </xsl:element>
    </xsl:template>
 



   <xsl:template match="CONCLUSION[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'con'"/>
            <xsl:attribute name="href" select="concat($ean, '_con', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="CONCLUSION[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_con', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="con"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-con"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


<xsl:template match="//FOOTNOTE/PARA" mode="fnote-con">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="CONCLUSION" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>



<xsl:template match="CONCLUSION/TITRE" mode="extract #default">
    <table width="100%" cellpadding="0" cellspacing="0" class="chapitre">
        <colgroup>
            <col width="25%"/>
            <col width="75%"/>
            
        </colgroup>
        <tr>
            <td class="chap-num"> </td>
            <td class="chap-titre">
                <h2 class="bm-titre">
            <xsl:apply-templates/>
                </h2></td>
        </tr></table>
    </xsl:template>

<xsl:template match="CONCLUSION/SOUSTITRE" mode="extract #default">
        <h2 class="bm-soustitre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx COMPTERENDUS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="COMPTERENDUS[parent::DOCUMENT]" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="chapnum" as="xs:string">
      <xsl:number level="any" count="COMPTERENDUS" format="01"/>
    </xsl:variable>
          <p class="chtoc"><a href="{concat($ean, '_comp', '.xhtml')}"><xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::COMPTERENDUS]][not(ancestor::INDEX)]"/>
            </xsl:variable>                    
       <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
	 <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_comp', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>




  
<xsl:template match="COMPTERENDUS[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'comp'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_comp', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="COMPTERENDUS[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'comp'"/>
            <xsl:attribute name="href" select="concat($ean, '_comp', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="COMPTERENDUS[parent::DOCUMENT]" mode="spine">
        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'comp'"/>
        </xsl:element>
    </xsl:template>
 


    <xsl:template match="COMPTERENDUS[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_comp', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="comp"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-comp"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-comp">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="COMPTERENDUS" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>


<xsl:template match="COMPTERENDUS/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<xsl:template match="COMPTERENDUS/SOUSTITRE" mode="extract #default">
        <h3 class="bm-soustitre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DOCINDEX xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="DOCINDEX" mode="toc">
    
  <p class="bmtoc"><a href="{concat($ean, '_idx', '.xhtml')}">Index</a></p>
    <xsl:apply-templates select="descendant::chapter" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_idx', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>




<xsl:template match="DOCINDEX[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="'idx'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                  <xsl:text>Index</xsl:text>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_idx', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>

    </xsl:template>
   <xsl:template match="DOCINDEX[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'idx'"/>
            <xsl:attribute name="href" select="concat($ean, '_idx', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="DOCINDEX[parent::DOCUMENT]" mode="spine">

        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'idx'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="DOCINDEX[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_idx', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="idx"/>
                    </p>
 
<xsl:call-template name="doc.index"></xsl:call-template>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-idx"/>
                        </div>
                        </xsl:if>

                    </body>
            </html>
        </xsl:result-document>


    </xsl:template>



<xsl:template match="//FOOTNOTE/PARA" mode="fnote-idx">
<xsl:variable name="footnote">
<xsl:number count="//FOOTNOTE" from="DOCINDEX" level="any"></xsl:number>
</xsl:variable>
<xsl:if test="not(preceding-sibling::PARA)[current()]">
<p class="footnote"><a href="#footnoteref{$footnote}" id="footnote{$footnote}"><span class="footnote">[<xsl:value-of select="$footnote"/>]</span></a>&#x00A0;&#x00A0;<xsl:apply-templates/></p>
</xsl:if>
<xsl:if test=".[preceding-sibling::PARA][current()]">
<p class="footnote1"><xsl:apply-templates/></p>
</xsl:if>
</xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx INDEX xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->




 <xsl:template name="idx-id" 
        match="INDEX"> <a 
                id="{generate-id(.)}"></a>
        
    </xsl:template>
    
     <xsl:template match="DOCINDEX" name="doc.index">
        <xsl:call-template name="book.index"/>
    </xsl:template>
    
    
    <xsl:template name="book.index">
        <div class="index">
            <h2>Index</h2>
            <a id="index"></a>
            <div class="idx">

                <xsl:apply-templates select="//INDEX[not(descendant::text()[parent::IDXITEM]=following::text()[parent::IDXITEM]) or child::IDXSUBITEM]" mode="index.mode">
<!--//INDEX[not(child::IDXITEM[child::text()]=preceding::INDEX[child::IDXITEM[child::text()]])]-->
<xsl:sort select="IDXITEM" lang="fr"/>
</xsl:apply-templates>
            </div>
        </div>
    </xsl:template>

    
<xsl:template match="INDEX" mode="index.mode">
<p class="idx1"><xsl:apply-templates select="IDXITEM">
<xsl:sort select="IDXITEM" case-order="#default"></xsl:sort>
</xsl:apply-templates>
<xsl:if test="not(descendant::IDXSUBITEM|IDXSUBSUBITEM)">
<xsl:apply-templates mode="index.link" select="//INDEX[child::IDXITEM=current() and not(child::IDXSUBITEM|IDXSUBSUBITEM)]"/>
</xsl:if>
</p>

<xsl:if test=".[child::IDXSUBITEM and not(descendant::IDXSUBSUBITEM)]">
<xsl:apply-templates select="child::IDXSUBITEM" mode="index.mode2">
<xsl:sort select="IDXSUBITEM" lang="fr"></xsl:sort>
</xsl:apply-templates>
</xsl:if>

<xsl:if test=".[child::IDXSUBITEM and descendant::IDXSUBSUBITEM]">
<xsl:apply-templates select="child::IDXSUBITEM" mode="index.mode3">
<xsl:sort select="IDXSUBSUBITEM"></xsl:sort>
</xsl:apply-templates>
</xsl:if>



</xsl:template>



    
    
    <xsl:template match="IDXSUBITEM" mode="index.mode2">
        <p class="idx2"><xsl:apply-templates/>
            <xsl:apply-templates 
                mode="index.link" 
                select="//INDEX[child::IDXSUBITEM=current()  and not(following-sibling::IDXSUBSUBITEM)]"/>
        </p>
    </xsl:template>

   <xsl:template match="IDXSUBSUBITEM" mode="index.mode3">
        <p class="idx3"><xsl:apply-templates/>
            <xsl:apply-templates 
                mode="index.link" 
                select="//INDEX[child::IDXSUBSUBITEM=current()]"/>
        </p>
    </xsl:template>


    
<xsl:template match="INDEX" mode="index.link">
<xsl:if test="position()=1">&#x2002;</xsl:if>
<xsl:if test="ancestor::CHAP">
<xsl:variable name="chapnum">
<xsl:number select="ancestor::CHAP" level="any" format="01"/>
</xsl:variable>
        <a href="{$ean}_ch{$chapnum}.xhtml#{generate-id(.)}" class="link"><span class="link">:)</span></a>
</xsl:if> 
<xsl:if test="ancestor::PREFACE">
<xsl:variable name="chapnum">
<xsl:number select="ancestor::PREFACE" level="any" format="01"/>
</xsl:variable>
        <a href="{$ean}_pre{$chapnum}.xhtml#{generate-id(.)}"  class="link"><span class="link">:)</span></a>
</xsl:if> 
<xsl:if test="ancestor::INTRODUCTION">
        <a href="{$ean}_intro.xhtml#{generate-id(.)}"  class="link"><span class="link">:)</span></a>
</xsl:if> 

<xsl:if test="position()!=last()">, </xsl:if> 


</xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DOCLISTEINDEX xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


  <xsl:template match="DOCLISTEINDEX" mode="toc">
    
  <p class="bmtoc"><a href="{concat($ean, '_idx-list', '.xhtml')}">Index</a></p>
    <xsl:apply-templates select="descendant::chapter" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_idx-list', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>


  
<xsl:template match="DOCLISTEINDEX[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="idx-list" select="'comp'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_idx-list', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="DOCLISTEINDEX[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'idx-list'"/>
            <xsl:attribute name="href" select="concat($ean, '_idx-list', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="DOCLISTEINDEX[parent::DOCUMENT]" mode="spine">

        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'idx-list'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="DOCLISTEINDEX[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_idx-list', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="idx-list"/>
                    </p>
                    <xsl:apply-templates/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>


<xsl:template match="DOCLISTEINDEX/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DOCTABLEINDEX xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


  <xsl:template match="DOCTABLEINDEX" mode="toc">
    
  <p class="bmtoc"><a href="{concat($ean, '_idx-tab', '.xhtml')}">Index</a></p>
    <xsl:apply-templates select="descendant::chapter" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_idx-tab', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>

  
<xsl:template match="DOCTABLEINDEX[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="idx-tab" select="'comp'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_idx-tab', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="DOCTABLEINDEX[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'idx-tab'"/>
            <xsl:attribute name="href" select="concat($ean, '_idx-tab', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="DOCTABLEINDEX[parent::DOCUMENT]" mode="spine">

        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'idx-tab'"/>
        </xsl:element>
    </xsl:template>



    <xsl:template match="DOCTABLEINDEX[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_idx-tab', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="idx-tab"/>
                    </p>
                    <xsl:apply-templates/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>



<xsl:template match="DOCTABLEINDEX/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LISTEDES xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  
  <xsl:template match="LISTEDES" mode="toc">
    
  <p class="bmtoc"><a href="{concat($ean, '_list', '.xhtml')}"><xsl:value-of select="ati:navLabelNormalize(TITRE)"/></a></p>
    <xsl:apply-templates select="descendant::chapter" mode="#current">
      <xsl:with-param name="parent.id" as="xs:string" select="concat($ean, '_list', '.xhtml')" tunnel="yes"/>
    </xsl:apply-templates>
  </xsl:template>




<xsl:template match="LISTEDES[parent::DOCUMENT]" mode="ncx ncx_oui">
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::DEDICACE or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM or self::SECT1]"
                level="any"/>
        </xsl:variable>
      
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="list" select="'comp'"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">
                    <xsl:value-of select="ati:navLabelNormalize(TITRE)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($ean, '_list', '.xhtml')"/>
            </xsl:element>
           
        </xsl:element>
    </xsl:template>
   <xsl:template match="LISTEDES[parent::DOCUMENT]" mode="manifest">

        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="id" select="'list'"/>
            <xsl:attribute name="href" select="concat($ean, '_list', '.xhtml')"/>
            <xsl:attribute name="media-type" select="'application/xhtml+xml'"/>
        </xsl:element>
    </xsl:template>


<xsl:template match="LISTEDES[parent::DOCUMENT]" mode="spine">

        <xsl:element name="itemref" namespace="http://www.idpf.org/2007/opf">
            <xsl:attribute name="idref" select="'list'"/>
        </xsl:element>
    </xsl:template>




    <xsl:template match="LISTEDES[parent::DOCUMENT]">
        <xsl:result-document format="epub"
            href="{resolve-uri(concat($outputFolder, '/OEBPS/', $ean, '_list', '.xhtml'), base-uri())}">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="/DOCUMENT/RDF/TITRE"/>
                    </title>
                    <link href="DunodEpubV1.0.css" type="text/css" rel="stylesheet"/>
                </head>
                <body>
                    <p>
                        <a id="list"/>
                    </p>
                    <xsl:apply-templates/>
                        <xsl:if test="descendant::FOOTNOTE">
                        <div class="fnote">
                        <xsl:apply-templates select="descendant::FOOTNOTE" mode="fnote-list"/>
                        </div>
                        </xsl:if>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

<xsl:template match="LISTEDES/TITRE" mode="extract #default">
        <h2 class="bm-titre">
            <xsl:apply-templates/>
        </h2>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT1 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="SECT1" mode="toc">
<xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
    <xsl:variable name="prenum" as="xs:string">
      <xsl:number level="any" format="01"/>
    </xsl:variable>
  <p class="sectoc"><a href="{$parent.id}#{ (@id, generate-id())[1]}">   <xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::SECT1]][not(ancestor::INDEX)]"/>
            </xsl:variable>
           <xsl:value-of select="ati:navLabelNormalize($title)"/></a></p>
  </xsl:template>
  

    <xsl:template match="SECT1" mode="ncx ncx_oui">
        <xsl:param name="parent.id" as="xs:string" tunnel="yes"/>
        <xsl:variable name="play.order" as="xs:string">
             <xsl:number
                count="*[self::CHAP or self::CHAPSN or self::PARTSN   or self::PART or self::PREFACE or self::SOMMAIRE or self::AVANTPROPOS or self::INTRODUCTION or self::PROLOGUE or self::ARTICLE or self::SECT1 or
                        self::BIB or self::ANNEXES or self::ANN or self::ANNSN or self::GLOSSAIRE or self::EPILOGUE or self::POSTFACE or self::PRELUDE or self::CONCLUSION or self::COMPTERENDUS or
                        self::LECTURES or self::DOCINDEX or self::DOCLISTEINDEX or self::DOCTABLEINDEX or self::LISTEDES or self::TDM]"
                level="any"/>
        </xsl:variable>
        <xsl:element name="navPoint" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:attribute name="id" select="(@id, generate-id())[1]"/>
            <xsl:attribute name="playOrder" select="xs:integer($play.order) + $additivePlayOrder"/>
            <xsl:element name="navLabel" namespace="http://www.daisy.org/z3986/2005/ncx/">
            <xsl:element name="text" namespace="http://www.daisy.org/z3986/2005/ncx/">             
               <xsl:variable name="title">
            <xsl:value-of select="descendant::text()[ancestor::TITRE[parent::SECT1]][not(ancestor::INDEX)]"/>
            </xsl:variable>
           <xsl:value-of select="ati:navLabelNormalize($title)"/>
                </xsl:element>
            </xsl:element>
            <xsl:element name="content" namespace="http://www.daisy.org/z3986/2005/ncx/">
                <xsl:attribute name="src" select="concat($parent.id, '#', (@id, generate-id())[1])"/>
            </xsl:element>
           <!-- <xsl:apply-templates select="descendant::*[self::SECT1]" mode="#current"/>-->
        </xsl:element>
    </xsl:template>
    <xsl:template match="SECT1" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>


<xsl:template match="SECT1/TITRE" mode="extract #default">
    <div class="courant-section-section">
        <h3 class="courant-section-section"><span class="section-titre">Section</span> <span class="section-titre-num">#</span></h3>
    </div>
    <h3 class="sect1-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT2 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->



    <xsl:template match="SECT2" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="SECT2/TITRE" mode="extract #default">
        <h3 class="sect2-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT3 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SECT3" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="SECT3/TITRE" mode="extract #default">
        <h3 class="sect3-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT4 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SECT4" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="SECT4/TITRE" mode="extract #default">
        <h3 class="sect4-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT5 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SECT5" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="SECT5/TITRE" mode="extract #default">
        <h3 class="sect5-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT6 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SECT6" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>


<xsl:template match="SECT6/TITRE" mode="extract #default">
        <h3 class="sect6-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SECT7 xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="SECT7" mode="extract #default">
        <div>
            <xsl:if test="not(tit)">
                <xsl:attribute name="id" select="(@id, generate-id(.))[1]"/>
            </xsl:if>
            <xsl:apply-templates/>
        </div>
    </xsl:template>




<xsl:template match="SECT7/TITRE" mode="extract #default">
        <h3 class="sect7-titre">
            <xsl:apply-templates/>
        </h3>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARA xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="LISTE/ITEM/PARA" mode="extract #default">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    <xsl:template match="PARA" mode="extract #default">
        <p class="courant-texte"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx GENERICPARA xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->
    
    <xsl:template match="GENERICPARA" mode="extract #default">
        <p class="genericpara"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARALIBRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->
    
<xsl:template match="PARALIBRE" mode="extract #default">
        
        <p class="paralibre"><xsl:call-template name="attrib"/><xsl:apply-templates/></p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARAPLUS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PARAPLUS" mode="extract #default">
        <p class="paraplus"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARASIGNATURE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="PARASIGNATURE" mode="extract #default">
        <p class="parasignature"><xsl:apply-templates/></p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARAGRAPHIQUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="PARAGRAPHIQUE" mode="extract #default">
        <p class="paragraphique"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARATABLEAUGRAPHIQUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="paratableaugraphique"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LISTE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="LISTE" mode="extract #default">
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
        
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ITEM xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="ITEM" mode="extract #default">
        <li><xsl:apply-templates/></li>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx RENVOI xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="RENVOI" mode="extract #default">
        <div class="renvoi"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="RENVOI/TITRE" mode="extract #default">
        <h4 class="renvoi-titre"><xsl:apply-templates/></h4>
    </xsl:template>


<xsl:template match="RENVOI/PARA" mode="extract #default">
        <p class="renvoi-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/GENERICPARA" mode="extract #default">
        <p class="renvoi-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="RENVOI/PARALIBRE" mode="extract #default">
        <p class="renvoi-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/PARAPLUS" mode="extract #default">
        <p class="renvoi-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/PARASIGNATURE" mode="extract #default">
        <p class="renvoi-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="RENVOI/PARAGRAPHIQUE" mode="extract #default">
        <p class="renvoi-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="renvoi-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="renvoi-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="renvoi-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="renvoi-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="renvoi-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="renvoi-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="renvoi-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="RENVOI/RENVOI" mode="extract #default">
        <p class="renvoi-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="RENVOI/FORMULE" mode="extract #default">
        <p class="renvoi-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/NEWPAGE" mode="extract #default">
        <p class="renvoi-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RENVOI/NOTETAB" mode="extract #default">
        <p class="renvoi-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="RENVOI/NOTEFIG" mode="extract #default">
        <p class="renvoi-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>




<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FORMULE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="FORMULE" mode="extract #default">
        <p class="formule"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx NEWPAGE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="NEWPAGE" mode="extract #default">
        <p class="newpage"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx NOTETAB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="NOTETAB" mode="extract #default">
        <p class="notetab"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx NOTEFIG xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="NOTEFIG" mode="extract #default">
        <p class="notefig"><xsl:apply-templates/></p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TITREUNCOL xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="TITREUNCOL" mode="extract #default">
        <h6 class="titreuncol"><xsl:apply-templates/></h6>
    </xsl:template>
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TITREDEUXCOL xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="TITREDEUXCOL" mode="extract #default">
        <h6 class="titredeuxcol"><xsl:apply-templates/></h6>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TITRETROISCOL xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="TITRETROISCOL" mode="extract #default">
        <h6 class="titretroiscol"><xsl:apply-templates/></h6>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TITREQUATRECOL xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="TITREQUATRECOL" mode="extract #default">
        <h6 class="titrequatrecol"><xsl:apply-templates/></h6>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx GENERICCAR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="GENERICCAR" mode="extract #default">
        <span class="genericcar"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EMPH xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="EMPH" mode="extract #default">
        <span class="emph"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CADRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="CADRE" mode="extract #default">
        <span class="cadre"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx B xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="B" mode="extract #default">
        <span class="b"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx I xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="I" mode="extract #default">
        <span class="i"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SC xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="SC" mode="extract #default">
        <span class="sc"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SUB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="SUB" mode="extract #default">
        <span class="sub"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SUP xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="SUP" mode="extract #default">
        <span class="sup"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx RM xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="RM" mode="extract #default">
        <span class="rm"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx MD xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="MD" mode="extract #default">
        <span class="md"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx GREC xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="GREC" mode="extract #default">
        <span class="grec"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx AC xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="AC" mode="extract #default">
        <span class="ac"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LOWER xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="LOWER" mode="extract #default">
        <span class="lower"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx RAISE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="RAISE" mode="extract #default">
        <span class="raise"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx XSCALE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="XSCALE" mode="extract #default">
        <span class="xscale"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LETTERSPACING xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="LETTERSPACING" mode="extract #default">
        <span class="letterspacing"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx UNDERLINED xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="UNDERLINED" mode="extract #default">
        <span class="underlined"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CARCOULEUR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="CARCOULEUR" mode="extract #default">
        <span class="carcouleur" style="color:{@Valeur}"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CARCOULEURMAIGRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="CARCOULEURMAIGRE" mode="extract #default">
        <span class="carcouleurmaigre"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FONTSIZE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="FONTSIZE" mode="extract #default">
        <span class="fontsize"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FONT xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="FONT" mode="extract #default">
        <span class="font"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGEREF xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="PAGEREF" mode="extract #default">
        <span class="pageref"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx XMLAREF xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="XMLAREF" mode="extract #default">
        <span class="xmlaref"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EQUATION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="EQUATION" mode="extract #default">
        <span class="equation"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx INSECABLE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="INSECABLE" mode="extract #default">
        <span class="insecable"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx HYPERLINK xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="HYPERLINK" mode="extract #default">
<xsl:variable name="hyperlink">


<xsl:if test=".[contains(text()[ancestor::HYPERLINK], 'http://')]">
<xsl:value-of select="."/>
</xsl:if>

<xsl:if test="not(.[contains(text()[ancestor::HYPERLINK], 'http://')])">
<xsl:text>http://</xsl:text><xsl:value-of select="."/>
</xsl:if>


<xsl:if test=".[contains(text()[ancestor::HYPERLINK], '@')]">
<xsl:text>mailto://</xsl:text><xsl:value-of select="."/>
</xsl:if>
</xsl:variable>

<xsl:if test="not(@target)">
        <a class="HYPERLINK" href="{$hyperlink}"><xsl:apply-templates/></a>
</xsl:if>
<xsl:if test="@target">
        <a class="HYPERLINK" href="{@target}"><xsl:apply-templates/></a>
</xsl:if>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARTABS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="PARTABS" mode="extract #default">
        <span class="partabs"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TAB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="TAB" mode="extract #default">
        <span class="tab"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx AUTOTEXT xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="AUTOTEXT" mode="extract #default">
        <span class="autotext"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CODECAR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="CODECAR" mode="extract #default">
        <span class="codecar"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LETTRINE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="LETTRINE" mode="extract #default">
        <span class="lettrine"><xsl:apply-templates/></span>
    </xsl:template>




<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SIGLE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="SIGLE" mode="extract #default">
        <span class="sigle"><xsl:apply-templates/></span>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx REFERENCE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="REFERENCE" mode="extract #default">
        <span class="reference"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx VOIR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="VOIR" mode="extract #default">
        <span class="voir"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx VOIRAUSSI xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="VOIRAUSSI" mode="extract #default">
        <span class="voiraussi"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DICOHYPERLIEN xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="DICOHYPERLIEN" mode="extract #default">
        <span class="dicohyperlien"><xsl:apply-templates/></span>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx VOIRENTREECAR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="VOIRENTREECAR" mode="extract #default">
        <span class="voirentreecar"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx VOIRENTREECAR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="VOIRENTREECAR" mode="extract #default">
        <span class="voirentreecar"><xsl:apply-templates/></span>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx BL xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="BL" mode="extract #default">
        <br/>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DICOENTREE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="DICOENTREE" mode="extract #default">
        <div class="dicoentree"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="DICOMOT" mode="extract #default">
        <h6 class="dicomot">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="DOMAINE" mode="extract #default">
        <p class="domaine">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CONTRAIRE" mode="extract #default">
        <p class="contraire">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LIEN" mode="extract #default">
        <p class="lien">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="COMPLEMENT" mode="extract #default">
        <p class="complement">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="VOIRENTREE" mode="extract #default">
        <p class="voirentree">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx NOTE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="NOTE" mode="extract #default">
        <div class="note"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="NOTE/TITRE" mode="extract #default">
        <h4 class="note-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="NOTE/SOUSTITRE" mode="extract #default">
        <h5 class="note-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="NOTE/SSOUSTITRE" mode="extract #default">
        <h6 class="note-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="NOTE/SSSOUSTITRE" mode="extract #default">
        <h6 class="note-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="NOTE/PARA" mode="extract #default">
        <p class="note-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/GENERICPARA" mode="extract #default">
        <p class="note-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="NOTE/PARALIBRE" mode="extract #default">
        <p class="note-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/PARAPLUS" mode="extract #default">
        <p class="note-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/PARASIGNATURE" mode="extract #default">
        <p class="note-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="NOTE/PARAGRAPHIQUE" mode="extract #default">
        <p class="note-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="note-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/LISTE" mode="extract #default">
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="note-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="note-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="note-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="note-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="note-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="note-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="NOTE/RENVOI" mode="extract #default">
        <p class="note-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="NOTE/FORMULE" mode="extract #default">
        <p class="note-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/NEWPAGE" mode="extract #default">
        <p class="note-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTE/NOTETAB" mode="extract #default">
        <p class="note-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="NOTE/NOTEFIG" mode="extract #default">
        <p class="note-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>




<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CONSEILS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="CONSEILS" mode="extract #default">
        <div class="conseils"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="CONSEILS/TITRE" mode="extract #default">
        <h4 class="conseils-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="CONSEILS/SOUSTITRE" mode="extract #default">
        <h5 class="conseils-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="CONSEILS/SSOUSTITRE" mode="extract #default">
        <h6 class="conseils-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="CONSEILS/SSSOUSTITRE" mode="extract #default">
        <h6 class="conseils-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="CONSEILS/PARA" mode="extract #default">
        <p class="conseils-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/GENERICPARA" mode="extract #default">
        <p class="conseils-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CONSEILS/PARALIBRE" mode="extract #default">
        <p class="conseils-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/PARAPLUS" mode="extract #default">
        <p class="conseils-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/PARASIGNATURE" mode="extract #default">
        <p class="conseils-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CONSEILS/PARAGRAPHIQUE" mode="extract #default">
        <p class="conseils-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="conseils-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/LISTE" mode="extract #default">
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="conseils-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="conseils-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="conseils-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="conseils-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="conseils-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="conseils-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="CONSEILS/RENVOI" mode="extract #default">
        <p class="conseils-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CONSEILS/FORMULE" mode="extract #default">
        <p class="conseils-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/NEWPAGE" mode="extract #default">
        <p class="conseils-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CONSEILS/NOTETAB" mode="extract #default">
        <p class="conseils-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CONSEILS/NOTEFIG" mode="extract #default">
        <p class="conseils-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ATTENTION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="ATTENTION" mode="extract #default">
        <div class="attention"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="ATTENTION/TITRE" mode="extract #default">
        <h4 class="attention-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="ATTENTION/SOUSTITRE" mode="extract #default">
        <h5 class="attention-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="ATTENTION/SSOUSTITRE" mode="extract #default">
        <h6 class="attention-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="ATTENTION/SSSOUSTITRE" mode="extract #default">
        <h6 class="attention-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="ATTENTION/PARA" mode="extract #default">
        <p class="attention-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/GENERICPARA" mode="extract #default">
        <p class="attention-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ATTENTION/PARALIBRE" mode="extract #default">
        <p class="attention-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/PARAPLUS" mode="extract #default">
        <p class="attention-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/PARASIGNATURE" mode="extract #default">
        <p class="attention-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ATTENTION/PARAGRAPHIQUE" mode="extract #default">
        <p class="attention-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="attention-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="attention-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="attention-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="attention-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="attention-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="attention-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="attention-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="ATTENTION/RENVOI" mode="extract #default">
        <p class="attention-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ATTENTION/FORMULE" mode="extract #default">
        <p class="attention-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/NEWPAGE" mode="extract #default">
        <p class="attention-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ATTENTION/NOTETAB" mode="extract #default">
        <p class="attention-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ATTENTION/NOTEFIG" mode="extract #default">
        <p class="attention-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SOLUTIONSEXO xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SOLUTIONSEXO" mode="extract #default">
        <div class="solutionsexo"><xsl:apply-templates/></div>
    </xsl:template>



<xsl:template match="SOLUTIONSEXO/PARA" mode="extract #default">
        <p class="solutionsexo-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/GENERICPARA" mode="extract #default">
        <p class="solutionsexo-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="SOLUTIONSEXO/PARALIBRE" mode="extract #default">
        <p class="solutionsexo-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/PARAPLUS" mode="extract #default">
        <p class="solutionsexo-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/PARASIGNATURE" mode="extract #default">
        <p class="solutionsexo-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTIONSEXO/PARAGRAPHIQUE" mode="extract #default">
        <p class="solutionsexo-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="solutionsexo-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="solutionsexo-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="solutionsexo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="solutionsexo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="solutionsexo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="solutionsexo-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="solutionsexo-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="SOLUTIONSEXO/RENVOI" mode="extract #default">
        <p class="solutionsexo-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTIONSEXO/FORMULE" mode="extract #default">
        <p class="solutionsexo-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/NEWPAGE" mode="extract #default">
        <p class="solutionsexo-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/NOTETAB" mode="extract #default">
        <p class="solutionsexo-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="SOLUTIONSEXO/NOTEFIG" mode="extract #default">
        <p class="solutionsexo-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT1" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT2" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT3" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT4" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT5" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT6" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT7" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT1/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect1-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT2/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect2-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT3/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect3-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT4/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect4-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT5/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect5-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT6/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect6-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="SOLUTIONSEXO/SECT7/TITRE" mode="extract #default">
            <h6 class="solutionsexo-sect7-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LECT xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="LECT" mode="extract #default">
        <div class="lect"><xsl:apply-templates/></div>
    </xsl:template>



<xsl:template match="LECT/PARA" mode="extract #default">
        <p class="lect-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/GENERICPARA" mode="extract #default">
        <p class="lect-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LECT/PARALIBRE" mode="extract #default">
        <p class="lect-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/PARAPLUS" mode="extract #default">
        <p class="lect-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/PARASIGNATURE" mode="extract #default">
        <p class="lect-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LECT/PARAGRAPHIQUE" mode="extract #default">
        <p class="lect-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="lect-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="lect-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="lect-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="lect-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="lect-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="lect-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="lect-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="LECT/RENVOI" mode="extract #default">
        <p class="lect-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LECT/FORMULE" mode="extract #default">
        <p class="lect-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/NEWPAGE" mode="extract #default">
        <p class="lect-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/NOTETAB" mode="extract #default">
        <p class="lect-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LECT/NOTEFIG" mode="extract #default">
        <p class="lect-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LECT/SECT1" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT2" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT3" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT4" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT5" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT6" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT7" mode="extract #default">
            <xsl:apply-templates/>
       
    </xsl:template>

<xsl:template match="LECT/SECT1/TITRE" mode="extract #default">
            <h6 class="lect-sect1-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="LECT/SECT2/TITRE" mode="extract #default">
            <h6 class="lect-sect2-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="LECT/SECT3/TITRE" mode="extract #default">
            <h6 class="lect-sect3-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="LECT/SECT4/TITRE" mode="extract #default">
            <h6 class="lect-sect4-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="LECT/SECT5/TITRE" mode="extract #default">
            <h6 class="lect-sect5-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="LECT/SECT6/TITRE" mode="extract #default">
            <h6 class="lect-sect6-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<xsl:template match="LECT/SECT7/TITRE" mode="extract #default">
            <h6 class="lect-sect7-titre"><xsl:apply-templates/></h6>
       
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EXERCICE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="EXERCICE" mode="extract #default">
        <div class="exercice"><xsl:apply-templates/></div>
    </xsl:template>


    <xsl:template match="EXERCICE/TITRE" mode="extract #default">
        <h4 class="exercice-titre"><xsl:apply-templates/></h4>
    </xsl:template>


<xsl:template match="EXERCICE/SOUSTITRE" mode="extract #default">
        <h5 class="exercice-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="EXERCICE/SSOUSTITRE" mode="extract #default">
        <h6 class="exercice-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="EXERCICE/SSSOUSTITRE" mode="extract #default">
        <h6 class="exercice-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="EXERCICE/PARA" mode="extract #default">
        <p class="exercice-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/GENERICPARA" mode="extract #default">
        <p class="exercice-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXERCICE/PARALIBRE" mode="extract #default">
        <p class="exercice-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/PARAPLUS" mode="extract #default">
        <p class="exercice-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/PARASIGNATURE" mode="extract #default">
        <p class="exercice-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXERCICE/PARAGRAPHIQUE" mode="extract #default">
        <p class="exercice-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="exercice-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="exercice-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="exercice-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="exercice-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="exercice-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="exercice-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="exercice-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="EXERCICE/RENVOI" mode="extract #default">
        <p class="exercice-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXERCICE/FORMULE" mode="extract #default">
        <p class="exercice-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/NEWPAGE" mode="extract #default">
        <p class="exercice-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICE/NOTETAB" mode="extract #default">
        <p class="exercice-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXERCICE/NOTEFIG" mode="extract #default">
        <p class="exercice-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx BIB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

   

<xsl:template match="PARA[ancestor::BIB]" mode="extract #default">
        <p class="bib-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICPARA[ancestor::BIB]" mode="extract #default">
        <p class="bib-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PARALIBRE[ancestor::BIB]" mode="extract #default">
        <p class="bib-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PARAPLUS[ancestor::BIB]" mode="extract #default">
        <p class="bib-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PARASIGNATURE[ancestor::BIB]" mode="extract #default">
        <p class="bib-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PARAGRAPHIQUE[ancestor::BIB]" mode="extract #default">
        <p class="bib-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PARATABLEAUGRAPHIQUE[ancestor::BIB]" mode="extract #default">
        <p class="bib-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTE[ancestor::BIB]" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="bib-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="bib-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="bib-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="bib-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="bib-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="bib-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="RENVOI[ancestor::BIB]" mode="extract #default">
        <p class="bib-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="FORMULE[ancestor::BIB]" mode="extract #default">
        <p class="bib-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NEWPAGE[ancestor::BIB]" mode="extract #default">
        <p class="bib-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="NOTETAB[ancestor::BIB]" mode="extract #default">
        <p class="bib-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="NOTEFIG[ancestor::BIB]" mode="extract #default">
        <p class="bib-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EXERCICES xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="EXERCICES" mode="extract #default">
        <div class="exercices"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="EXERCICES/TITRE" mode="extract #default">
        <h4 class="exercices-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="EXERCICES/SOUSTITRE" mode="extract #default">
        <h5 class="exercices-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="EXERCICES/SSOUSTITRE" mode="extract #default">
        <h6 class="exercices-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="EXERCICES/SSSOUSTITRE" mode="extract #default">
        <h6 class="exercices-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="EXERCICES/PARA" mode="extract #default">
        <p class="exercices-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/GENERICPARA" mode="extract #default">
        <p class="exercices-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXERCICES/PARALIBRE" mode="extract #default">
        <p class="exercices-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/PARAPLUS" mode="extract #default">
        <p class="exercices-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/PARASIGNATURE" mode="extract #default">
        <p class="exercices-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXERCICES/PARAGRAPHIQUE" mode="extract #default">
        <p class="exercices-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="exercices-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="exercices-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="exercices-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="exercices-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="exercices-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="exercices-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="exercices-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
    </xsl:template>

<xsl:template match="EXERCICES/RENVOI" mode="extract #default">
        <p class="exercices-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXERCICES/FORMULE" mode="extract #default">
        <p class="exercices-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/NEWPAGE" mode="extract #default">
        <p class="exercices-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERCICES/NOTETAB" mode="extract #default">
        <p class="exercices-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXERCICES/NOTEFIG" mode="extract #default">
        <p class="exercices-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PROBLEME xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="PROBLEME" mode="extract #default">
        <div class="probleme"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="PROBLEME/TITRE" mode="extract #default">
        <h4 class="probleme-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="PROBLEME/SOUSTITRE" mode="extract #default">
        <h5 class="probleme-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="PROBLEME/SSOUSTITRE" mode="extract #default">
        <h6 class="probleme-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PROBLEME/SSSOUSTITRE" mode="extract #default">
        <h6 class="probleme-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PROBLEME/PARA" mode="extract #default">
        <p class="probleme-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/GENERICPARA" mode="extract #default">
        <p class="probleme-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROBLEME/PARALIBRE" mode="extract #default">
        <p class="probleme-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/PARAPLUS" mode="extract #default">
        <p class="probleme-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/PARASIGNATURE" mode="extract #default">
        <p class="probleme-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROBLEME/PARAGRAPHIQUE" mode="extract #default">
        <p class="probleme-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="probleme-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/LISTE" mode="extract #default">
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="probleme-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="probleme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="probleme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="probleme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="probleme-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="probleme-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="PROBLEME/RENVOI" mode="extract #default">
        <p class="probleme-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROBLEME/FORMULE" mode="extract #default">
        <p class="probleme-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/NEWPAGE" mode="extract #default">
        <p class="probleme-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEME/NOTETAB" mode="extract #default">
        <p class="probleme-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROBLEME/NOTEFIG" mode="extract #default">
        <p class="probleme-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PROBLEMES xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="PROBLEMES" mode="extract #default">
        <div class="problemes"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="PROBLEMES/TITRE" mode="extract #default">
        <h4 class="problemes-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="PROBLEMES/SOUSTITRE" mode="extract #default">
        <h5 class="problemes-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="PROBLEMES/SSOUSTITRE" mode="extract #default">
        <h6 class="problemes-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PROBLEMES/SSSOUSTITRE" mode="extract #default">
        <h6 class="problemes-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PROBLEMES/PARA" mode="extract #default">
        <p class="problemes-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/GENERICPARA" mode="extract #default">
        <p class="problemes-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROBLEMES/PARALIBRE" mode="extract #default">
        <p class="problemes-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/PARAPLUS" mode="extract #default">
        <p class="problemes-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/PARASIGNATURE" mode="extract #default">
        <p class="problemes-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROBLEMES/PARAGRAPHIQUE" mode="extract #default">
        <p class="problemes-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="problemes-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/LISTE" mode="extract #default">
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="problemes-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="problemes-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="problemes-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="problemes-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="problemes-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="problemes-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="PROBLEMES/RENVOI" mode="extract #default">
        <p class="problemes-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROBLEMES/FORMULE" mode="extract #default">
        <p class="problemes-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/NEWPAGE" mode="extract #default">
        <p class="problemes-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROBLEMES/NOTETAB" mode="extract #default">
        <p class="problemes-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROBLEMES/NOTEFIG" mode="extract #default">
        <p class="problemes-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SOLUTIONS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SOLUTIONS" mode="extract #default">
        <div class="solutions"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="SOLUTIONS/TITRE" mode="extract #default">
        <h4 class="solutions-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="SOLUTIONS/SOUSTITRE" mode="extract #default">
        <h5 class="solutions-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="SOLUTIONS/SSOUSTITRE" mode="extract #default">
        <h6 class="solutions-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="SOLUTIONS/SSSOUSTITRE" mode="extract #default">
        <h6 class="solutions-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SOLUTION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SOLUTION" mode="extract #default">
        <div class="solution"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="SOLUTION/TITRE" mode="extract #default">
        <h4 class="solution-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



    <xsl:template match="SOLUTION" mode="extract #default">
        <div class="solution"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="SOLUTION/TITRE" mode="extract #default">
        <h4 class="solution-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="SOLUTION/SOUSTITRE" mode="extract #default">
        <h5 class="solution-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="SOLUTION/SSOUSTITRE" mode="extract #default">
        <h6 class="solution-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="SOLUTION/SSSOUSTITRE" mode="extract #default">
        <h6 class="solution-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="SOLUTION/PARA" mode="extract #default">
        <p class="solution-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/GENERICPARA" mode="extract #default">
        <p class="solution-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="SOLUTION/PARALIBRE" mode="extract #default">
        <p class="solution-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/PARAPLUS" mode="extract #default">
        <p class="solution-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/PARASIGNATURE" mode="extract #default">
        <p class="solution-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTION/PARAGRAPHIQUE" mode="extract #default">
        <p class="solution-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="solution-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/LISTE" mode="extract #default">
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="solution-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="solution-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="solution-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="solution-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="solution-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="solution-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="SOLUTION/RENVOI" mode="extract #default">
        <p class="solution-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTION/FORMULE" mode="extract #default">
        <p class="solution-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/NEWPAGE" mode="extract #default">
        <p class="solution-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTION/NOTETAB" mode="extract #default">
        <p class="solution-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="SOLUTION/NOTEFIG" mode="extract #default">
        <p class="solution-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SOLUTIONPB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SOLUTIONPB" mode="extract #default">
        <div class="solutionpb"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/TITRE" mode="extract #default">
        <h4 class="solutionspb-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



    <xsl:template match="SOLUTIONSPB" mode="extract #default">
        <div class="solutionspb"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/TITRE" mode="extract #default">
        <h4 class="solutionspb-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/SOUSTITRE" mode="extract #default">
        <h5 class="solutionspb-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/SSOUSTITRE" mode="extract #default">
        <h6 class="solutionspb-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/SSSOUSTITRE" mode="extract #default">
        <h6 class="solutionspb-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/PARA" mode="extract #default">
        <p class="solutionspb-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSPB/GENERICPARA" mode="extract #default">
        <p class="solutionspb-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="SOLUTIONSPB/PARALIBRE" mode="extract #default">
        <p class="solutionspb-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSPB/PARAPLUS" mode="extract #default">
        <p class="solutionspb-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSPB/PARASIGNATURE" mode="extract #default">
        <p class="solutionspb-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/PARAGRAPHIQUE" mode="extract #default">
        <p class="solutionspb-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSPB/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="solutionspb-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/LISTE" mode="extract #default">
        
        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="solutionspb-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="solutionspb-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="solutionspb-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="solutionspb-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="solutionspb-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="solutionspb-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="SOLUTIONSPB/RENVOI" mode="extract #default">
        <p class="solutionspb-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/FORMULE" mode="extract #default">
        <p class="solutionspb-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSPB/NEWPAGE" mode="extract #default">
        <p class="solutionspb-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="SOLUTIONSPB/NOTETAB" mode="extract #default">
        <p class="solutionspb-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="SOLUTIONSPB/NOTEFIG" mode="extract #default">
        <p class="solutionspb-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SOLUTIONSPB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="SOLUTIONSPB" mode="extract #default">
        <div class="solutionspb"><xsl:apply-templates/></div>
    </xsl:template>



<xsl:template match="SOLUTIONSPB/TITRE" mode="extract #default">
        <h4 class="solutionspb-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/SOUSTITRE" mode="extract #default">
        <h5 class="solutionspb-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/SSOUSTITRE" mode="extract #default">
        <h6 class="solutionspb-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="SOLUTIONSPB/SSSOUSTITRE" mode="extract #default">
        <h6 class="solutionspb-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>




<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DIALOGUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="DIALOGUE" mode="extract #default">
        <div class="dialogue"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="DIALOGUE/TITRE" mode="extract #default">
        <h4 class="dialogue-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="DIALOGUE/SOUSTITRE" mode="extract #default">
        <h5 class="dialogue-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="DIALOGUE/SSOUSTITRE" mode="extract #default">
        <h6 class="dialogue-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="DIALOGUE/SSSOUSTITRE" mode="extract #default">
        <h6 class="dialogue-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="DIALOGUE/PARA" mode="extract #default">
        <p class="dialogue-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/GENERICPARA" mode="extract #default">
        <p class="dialogue-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DIALOGUE/PARALIBRE" mode="extract #default">
        <p class="dialogue-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/PARAPLUS" mode="extract #default">
        <p class="dialogue-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/PARASIGNATURE" mode="extract #default">
        <p class="dialogue-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DIALOGUE/PARAGRAPHIQUE" mode="extract #default">
        <p class="dialogue-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="dialogue-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/LISTE" mode="extract #default">


        
<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="dialogue-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="dialogue-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="dialogue-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="dialogue-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="dialogue-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="dialogue-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
    </xsl:template>

<xsl:template match="DIALOGUE/RENVOI" mode="extract #default">
        <p class="dialogue-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DIALOGUE/FORMULE" mode="extract #default">
        <p class="dialogue-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/NEWPAGE" mode="extract #default">
        <p class="dialogue-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DIALOGUE/NOTETAB" mode="extract #default">
        <p class="dialogue-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DIALOGUE/NOTEFIG" mode="extract #default">
        <p class="dialogue-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx OBJECTIFS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="OBJECTIFS" mode="extract #default">
        <div class="objectifs"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="OBJECTIFS/TITRE" mode="extract #default">
        <h4 class="objectifs-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="OBJECTIFS/SOUSTITRE" mode="extract #default">
        <h5 class="objectifs-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="OBJECTIFS/SSOUSTITRE" mode="extract #default">
        <h6 class="objectifs-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="OBJECTIFS/SSSOUSTITRE" mode="extract #default">
        <h6 class="objectifs-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="OBJECTIFS/PARA" mode="extract #default">
        <p class="objectifs-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/GENERICPARA" mode="extract #default">
        <p class="objectifs-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="OBJECTIFS/PARALIBRE" mode="extract #default">
        <p class="objectifs-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/PARAPLUS" mode="extract #default">
        <p class="objectifs-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/PARASIGNATURE" mode="extract #default">
        <p class="objectifs-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="OBJECTIFS/PARAGRAPHIQUE" mode="extract #default">
        <p class="objectifs-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="objectifs-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/LISTE" mode="extract #default">


<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="objectifs-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="objectifs-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="objectifs-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="objectifs-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="objectifs-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="objectifs-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="OBJECTIFS/RENVOI" mode="extract #default">
        <p class="objectifs-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="OBJECTIFS/FORMULE" mode="extract #default">
        <p class="objectifs-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/NEWPAGE" mode="extract #default">
        <p class="objectifs-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="OBJECTIFS/NOTETAB" mode="extract #default">
        <p class="objectifs-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="OBJECTIFS/NOTEFIG" mode="extract #default">
        <p class="objectifs-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx RETENIR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="RETENIR" mode="extract #default">
        <div class="retenir"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="RETENIR/TITRE" mode="extract #default">
        <h4 class="retenir-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="RETENIR/SOUSTITRE" mode="extract #default">
        <h5 class="retenir-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="RETENIR/SSOUSTITRE" mode="extract #default">
        <h6 class="retenir-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="RETENIR/SSSOUSTITRE" mode="extract #default">
        <h6 class="retenir-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="RETENIR/PARA" mode="extract #default">
        <p class="retenir-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/GENERICPARA" mode="extract #default">
        <p class="retenir-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="RETENIR/PARALIBRE" mode="extract #default">
        <p class="retenir-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/PARAPLUS" mode="extract #default">
        <p class="retenir-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/PARASIGNATURE" mode="extract #default">
        <p class="retenir-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="RETENIR/PARAGRAPHIQUE" mode="extract #default">
        <p class="retenir-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="retenir-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="retenir-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="retenir-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="retenir-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="retenir-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="retenir-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="retenir-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
    </xsl:template>

<xsl:template match="RETENIR/RENVOI" mode="extract #default">
        <p class="retenir-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="RETENIR/FORMULE" mode="extract #default">
        <p class="retenir-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/NEWPAGE" mode="extract #default">
        <p class="retenir-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RETENIR/NOTETAB" mode="extract #default">
        <p class="retenir-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="RETENIR/NOTEFIG" mode="extract #default">
        <p class="retenir-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PREREQUIS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="PREREQUIS" mode="extract #default">
        <div class="prerequis"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="PREREQUIS/TITRE" mode="extract #default">
        <h4 class="prerequis-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="PREREQUIS/SOUSTITRE" mode="extract #default">
        <h5 class="prerequis-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="PREREQUIS/SSOUSTITRE" mode="extract #default">
        <h6 class="prerequis-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PREREQUIS/SSSOUSTITRE" mode="extract #default">
        <h6 class="prerequis-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PREREQUIS/PARA" mode="extract #default">
        <p class="prerequis-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/GENERICPARA" mode="extract #default">
        <p class="prerequis-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PREREQUIS/PARALIBRE" mode="extract #default">
        <p class="prerequis-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/PARAPLUS" mode="extract #default">
        <p class="prerequis-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/PARASIGNATURE" mode="extract #default">
        <p class="prerequis-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PREREQUIS/PARAGRAPHIQUE" mode="extract #default">
        <p class="prerequis-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="prerequis-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="prerequis-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="prerequis-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="prerequis-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="prerequis-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="prerequis-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="prerequis-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="PREREQUIS/RENVOI" mode="extract #default">
        <p class="prerequis-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PREREQUIS/FORMULE" mode="extract #default">
        <p class="prerequis-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/NEWPAGE" mode="extract #default">
        <p class="prerequis-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PREREQUIS/NOTETAB" mode="extract #default">
        <p class="prerequis-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PREREQUIS/NOTEFIG" mode="extract #default">
        <p class="prerequis-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx MOTSCLES xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="MOTSCLES" mode="extract #default">
        <div class="motscles"><xsl:apply-templates/></div>
    </xsl:template>


   <xsl:template match="MOTSCLES/TITRE" mode="extract #default">
        <h4 class="motscles/titre"><xsl:apply-templates/></h4>
    </xsl:template>


<xsl:template match="MOTSCLES/SOUSTITRE" mode="extract #default">
        <h5 class="motscles-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="MOTSCLES/SSOUSTITRE" mode="extract #default">
        <h6 class="motscles-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="MOTSCLES/SSSOUSTITRE" mode="extract #default">
        <h6 class="motscles-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="MOTSCLES/PARA" mode="extract #default">
        <p class="motscles-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/GENERICPARA" mode="extract #default">
        <p class="motscles-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="MOTSCLES/PARALIBRE" mode="extract #default">
        <p class="motscles-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/PARAPLUS" mode="extract #default">
        <p class="motscles-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/PARASIGNATURE" mode="extract #default">
        <p class="motscles-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="MOTSCLES/PARAGRAPHIQUE" mode="extract #default">
        <p class="motscles-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="motscles-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="motscles-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="motscles-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="motscles-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="motscles-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="motscles-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="motscles-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
    </xsl:template>

<xsl:template match="MOTSCLES/RENVOI" mode="extract #default">
        <p class="motscles-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="MOTSCLES/FORMULE" mode="extract #default">
        <p class="motscles-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/NEWPAGE" mode="extract #default">
        <p class="motscles-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="MOTSCLES/NOTETAB" mode="extract #default">
        <p class="motscles-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="MOTSCLES/NOTEFIG" mode="extract #default">
        <p class="motscles-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx RESUME xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="RESUME" mode="extract #default">
        <div class="resume"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="RESUME/TITRE" mode="extract #default">
        <h4 class="resume-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="RESUME/SOUSTITRE" mode="extract #default">
        <h5 class="resume-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="RESUME/SSOUSTITRE" mode="extract #default">
        <h6 class="resume-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="RESUME/SSSOUSTITRE" mode="extract #default">
        <h6 class="resume-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="RESUME/PARA" mode="extract #default">
        <p class="resume-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/GENERICPARA" mode="extract #default">
        <p class="resume-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="RESUME/PARALIBRE" mode="extract #default">
        <p class="resume-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/PARAPLUS" mode="extract #default">
        <p class="resume-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/PARASIGNATURE" mode="extract #default">
        <p class="resume-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="RESUME/PARAGRAPHIQUE" mode="extract #default">
        <p class="resume-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="resume-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="resume-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="resume-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="resume-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="resume-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="resume-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="resume-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="RESUME/RENVOI" mode="extract #default">
        <p class="resume-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="RESUME/FORMULE" mode="extract #default">
        <p class="resume-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/NEWPAGE" mode="extract #default">
        <p class="resume-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="RESUME/NOTETAB" mode="extract #default">
        <p class="resume-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="RESUME/NOTEFIG" mode="extract #default">
        <p class="resume-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CAS xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="CAS" mode="extract #default">
        <div class="cas"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="CAS/TITRE" mode="extract #default">
        <h4 class="cas-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="CAS/SOUSTITRE" mode="extract #default">
        <h5 class="cas-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="CAS/SSOUSTITRE" mode="extract #default">
        <h6 class="cas-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="CAS/SSSOUSTITRE" mode="extract #default">
        <h6 class="cas-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="CAS/PARA" mode="extract #default">
        <p class="cas-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/GENERICPARA" mode="extract #default">
        <p class="cas-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CAS/PARALIBRE" mode="extract #default">
        <p class="cas-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/PARAPLUS" mode="extract #default">
        <p class="cas-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/PARASIGNATURE" mode="extract #default">
        <p class="cas-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CAS/PARAGRAPHIQUE" mode="extract #default">
        <p class="cas-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="cas-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="cas-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="cas-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="cas-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="cas-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="cas-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="cas-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
    </xsl:template>

<xsl:template match="CAS/RENVOI" mode="extract #default">
        <p class="cas-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CAS/FORMULE" mode="extract #default">
        <p class="cas-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/NEWPAGE" mode="extract #default">
        <p class="cas-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CAS/NOTETAB" mode="extract #default">
        <p class="cas-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CAS/NOTEFIG" mode="extract #default">
        <p class="cas-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ENCADRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="ENCADRE" mode="extract #default">
        <div class="encadre"><xsl:apply-templates/></div>
    </xsl:template>


 <xsl:template match="ENCADRE/TITRE" mode="extract #default">
        <h4 class="encadre-titre"><xsl:apply-templates/></h4>
    </xsl:template>



<xsl:template match="ENCADRE/SOUSTITRE" mode="extract #default">
        <h5 class="encadre-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="ENCADRE/SSOUSTITRE" mode="extract #default">
        <h6 class="encadre-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="ENCADRE/SSSOUSTITRE" mode="extract #default">
        <h6 class="encadre-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="ENCADRE/PARA" mode="extract #default">
        <p class="encadre-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/GENERICPARA" mode="extract #default">
        <p class="encadre-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ENCADRE/PARALIBRE" mode="extract #default">
        <p class="encadre-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/PARAPLUS" mode="extract #default">
        <p class="encadre-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/PARASIGNATURE" mode="extract #default">
        <p class="encadre-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ENCADRE/PARAGRAPHIQUE" mode="extract #default">
        <p class="encadre-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="encadre-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="encadre-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="encadre-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="encadre-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="encadre-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="encadre-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="encadre-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="ENCADRE/RENVOI" mode="extract #default">
        <p class="encadre-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ENCADRE/FORMULE" mode="extract #default">
        <p class="encadre-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/NEWPAGE" mode="extract #default">
        <p class="encadre-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRE/NOTETAB" mode="extract #default">
        <p class="encadre-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ENCADRE/NOTEFIG" mode="extract #default">
        <p class="encadre-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CITATION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="CITATION" mode="extract #default">
        <div class="citation"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="CITATION/PARA" mode="extract #default">
        <p class="citation-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/GENERICPARA" mode="extract #default">
        <p class="citation-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CITATION/PARALIBRE" mode="extract #default">
        <p class="citation-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/PARAPLUS" mode="extract #default">
        <p class="citation-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/PARASIGNATURE" mode="extract #default">
        <p class="citation-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CITATION/PARAGRAPHIQUE" mode="extract #default">
        <p class="citation-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="citation-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="citation-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="citation-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="citation-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="citation-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="citation-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="citation-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="CITATION/RENVOI" mode="extract #default">
        <p class="citation-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CITATION/FORMULE" mode="extract #default">
        <p class="citation-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/NEWPAGE" mode="extract #default">
        <p class="citation-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATION/NOTETAB" mode="extract #default">
        <p class="citation-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CITATION/NOTEFIG" mode="extract #default">
        <p class="citation-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CITATIONLOGO xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="CITATIONLOGO" mode="extract #default">
        <div class="citationlogo"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="CITATIONLOGO/PARA" mode="extract #default">
        <p class="citationlogo-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/GENERICPARA" mode="extract #default">
        <p class="citationlogo-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CITATIONLOGO/PARALIBRE" mode="extract #default">
        <p class="citationlogo-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/PARAPLUS" mode="extract #default">
        <p class="citationlogo-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/PARASIGNATURE" mode="extract #default">
        <p class="citationlogo-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CITATIONLOGO/PARAGRAPHIQUE" mode="extract #default">
        <p class="citationlogo-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="citationlogo-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="citationlogo-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="citationlogo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="citationlogo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="citationlogo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="citationlogo-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="citationlogo-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="CITATIONLOGO/RENVOI" mode="extract #default">
        <p class="citationlogo-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CITATIONLOGO/FORMULE" mode="extract #default">
        <p class="citationlogo-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/NEWPAGE" mode="extract #default">
        <p class="citationlogo-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CITATIONLOGO/NOTETAB" mode="extract #default">
        <p class="citationlogo-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CITATIONLOGO/NOTEFIG" mode="extract #default">
        <p class="citationlogo-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ENCADRECITATION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="ENCADRECITATION/PARA" mode="extract #default">
        <p class="encadrecitation-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/GENERICPARA" mode="extract #default">
        <p class="encadrecitation-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ENCADRECITATION/PARALIBRE" mode="extract #default">
        <p class="encadrecitation-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/PARAPLUS" mode="extract #default">
        <p class="encadrecitation-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/PARASIGNATURE" mode="extract #default">
        <p class="encadrecitation-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ENCADRECITATION/PARAGRAPHIQUE" mode="extract #default">
        <p class="encadrecitation-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="encadrecitation-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="encadrecitation-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="encadrecitation-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="encadrecitation-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="encadrecitation-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="encadrecitation-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="encadrecitation-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="ENCADRECITATION/RENVOI" mode="extract #default">
        <p class="encadrecitation-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ENCADRECITATION/FORMULE" mode="extract #default">
        <p class="encadrecitation-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/NEWPAGE" mode="extract #default">
        <p class="encadrecitation-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ENCADRECITATION/ENCADRECITATIONTAB" mode="extract #default">
        <p class="encadrecitation-encadrecitationtab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ENCADRECITATION/ENCADRECITATIONFIG" mode="extract #default">
        <p class="encadrecitation-encadrecitationfig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LISTING xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="LISTING" mode="extract #default">
        <div class="listing"><xsl:apply-templates/></div>
    </xsl:template>



<xsl:template match="LISTING/TITRE" mode="extract #default">
        <h4 class="listing-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="LISTING/PARA" mode="extract #default">
        <p class="listing-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/GENERICPARA" mode="extract #default">
        <p class="listing-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LISTING/PARALIBRE" mode="extract #default">
        <p class="listing-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/PARAPLUS" mode="extract #default">
        <p class="listing-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/PARASIGNATURE" mode="extract #default">
        <p class="listing-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LISTING/PARAGRAPHIQUE" mode="extract #default">
        <p class="listing-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="listing-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="listing-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="listing-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="listing-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="listing-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="listing-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="listing-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="LISTING/RENVOI" mode="extract #default">
        <p class="listing-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LISTING/FORMULE" mode="extract #default">
        <p class="listing-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/NEWPAGE" mode="extract #default">
        <p class="listing-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LISTING/LISTINGTAB" mode="extract #default">
        <p class="listing-listingtab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LISTING/LISTINGFIG" mode="extract #default">
        <p class="listing-listingfig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx REMARQUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="REMARQUE" mode="extract #default">
        <div class="remarque"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="REMARQUE/TITRE" mode="extract #default">
        <h4 class="remarque-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="REMARQUE/SOUSTITRE" mode="extract #default">
        <h5 class="remarque-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="REMARQUE/SSOUSTITRE" mode="extract #default">
        <h6 class="remarque-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="REMARQUE/SSSOUSTITRE" mode="extract #default">
        <h6 class="remarque-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="REMARQUE/PARA" mode="extract #default">
        <p class="remarque-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/GENERICPARA" mode="extract #default">
        <p class="remarque-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="REMARQUE/PARALIBRE" mode="extract #default">
        <p class="remarque-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/PARAPLUS" mode="extract #default">
        <p class="remarque-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/PARASIGNATURE" mode="extract #default">
        <p class="remarque-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="REMARQUE/PARAGRAPHIQUE" mode="extract #default">
        <p class="remarque-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="remarque-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="remarque-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="remarque-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="remarque-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="remarque-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="remarque-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="remarque-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="REMARQUE/RENVOI" mode="extract #default">
        <p class="remarque-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="REMARQUE/FORMULE" mode="extract #default">
        <p class="remarque-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/NEWPAGE" mode="extract #default">
        <p class="remarque-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="REMARQUE/NOTETAB" mode="extract #default">
        <p class="remarque-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="REMARQUE/NOTEFIG" mode="extract #default">
        <p class="remarque-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EXEMPLE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="EXEMPLE" mode="extract #default">
        <div class="exemple"><xsl:apply-templates/></div>
    </xsl:template>

 <xsl:template match="EXEMPLE/TITRE" mode="extract #default">
        <h4 class="exemple-titre"><xsl:apply-templates/></h4>
    </xsl:template>


<xsl:template match="EXEMPLE/SOUSTITRE" mode="extract #default">
        <h5 class="exemple-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="EXEMPLE/SSOUSTITRE" mode="extract #default">
        <h6 class="exemple-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="EXEMPLE/SSSOUSTITRE" mode="extract #default">
        <h6 class="exemple-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="EXEMPLE/PARA" mode="extract #default">
        <p class="exemple-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/GENERICPARA" mode="extract #default">
        <p class="exemple-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXEMPLE/PARALIBRE" mode="extract #default">
        <p class="exemple-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/PARAPLUS" mode="extract #default">
        <p class="exemple-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/PARASIGNATURE" mode="extract #default">
        <p class="exemple-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXEMPLE/PARAGRAPHIQUE" mode="extract #default">
        <p class="exemple-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="exemple-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="exemple-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="exemple-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="exemple-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="exemple-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="exemple-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="exemple-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="EXEMPLE/RENVOI" mode="extract #default">
        <p class="exemple-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXEMPLE/FORMULE" mode="extract #default">
        <p class="exemple-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/NEWPAGE" mode="extract #default">
        <p class="exemple-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXEMPLE/NOTETAB" mode="extract #default">
        <p class="exemple-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXEMPLE/NOTEFIG" mode="extract #default">
        <p class="exemple-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ZOOM xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="ZOOM" mode="extract #default">
        <div class="zoom"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="ZOOM/TITRE" mode="extract #default">
        <h4 class="zoom-titre"><xsl:apply-templates/></h4>
    </xsl:template>



<xsl:template match="ZOOM/SOUSTITRE" mode="extract #default">
        <h5 class="zoom-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="ZOOM/SSOUSTITRE" mode="extract #default">
        <h6 class="zoom-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="ZOOM/SSSOUSTITRE" mode="extract #default">
        <h6 class="zoom-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="ZOOM/PARA" mode="extract #default">
        <p class="zoom-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/GENERICPARA" mode="extract #default">
        <p class="zoom-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ZOOM/PARALIBRE" mode="extract #default">
        <p class="zoom-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/PARAPLUS" mode="extract #default">
        <p class="zoom-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/PARASIGNATURE" mode="extract #default">
        <p class="zoom-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ZOOM/PARAGRAPHIQUE" mode="extract #default">
        <p class="zoom-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="zoom-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/LISTE" mode="extract #default">

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="zoom-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="zoom-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="zoom-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="zoom-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="zoom-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="zoom-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
   
    </xsl:template>

<xsl:template match="ZOOM/RENVOI" mode="extract #default">
        <p class="zoom-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="ZOOM/FORMULE" mode="extract #default">
        <p class="zoom-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/NEWPAGE" mode="extract #default">
        <p class="zoom-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="ZOOM/NOTETAB" mode="extract #default">
        <p class="zoom-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="ZOOM/NOTEFIG" mode="extract #default">
        <p class="zoom-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx EXERGUE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="EXERGUE" mode="extract #default">
        <div class="exergue"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="EXERGUE/PARA" mode="extract #default">
        <p class="exergue-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/GENERICPARA" mode="extract #default">
        <p class="exergue-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXERGUE/PARALIBRE" mode="extract #default">
        <p class="exergue-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/PARAPLUS" mode="extract #default">
        <p class="exergue-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/PARASIGNATURE" mode="extract #default">
        <p class="exergue-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXERGUE/PARAGRAPHIQUE" mode="extract #default">
        <p class="exergue-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="exergue-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="exergue-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="exergue-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="exergue-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="exergue-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="exergue-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="exergue-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="EXERGUE/RENVOI" mode="extract #default">
        <p class="exergue-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="EXERGUE/FORMULE" mode="extract #default">
        <p class="exergue-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/NEWPAGE" mode="extract #default">
        <p class="exergue-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="EXERGUE/NOTETAB" mode="extract #default">
        <p class="exergue-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="EXERGUE/NOTEFIG" mode="extract #default">
        <p class="exergue-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx BIBDIV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="BIBDIV" mode="extract #default">
        <div class="bibdiv"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="BIBDIV/PARA" mode="extract #default">
        <p class="bibdiv-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/GENERICPARA" mode="extract #default">
        <p class="bibdiv-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="BIBDIV/PARALIBRE" mode="extract #default">
        <p class="bibdiv-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/PARAPLUS" mode="extract #default">
        <p class="bibdiv-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/PARASIGNATURE" mode="extract #default">
        <p class="bibdiv-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="BIBDIV/PARAGRAPHIQUE" mode="extract #default">
        <p class="bibdiv-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="bibdiv-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="bibdiv-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="bibdiv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="bibdiv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="bibdiv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="bibdiv-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="bibdiv-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="BIBDIV/RENVOI" mode="extract #default">
        <p class="bibdiv-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="BIBDIV/FORMULE" mode="extract #default">
        <p class="bibdiv-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/NEWPAGE" mode="extract #default">
        <p class="bibdiv-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="BIBDIV/NOTETAB" mode="extract #default">
        <p class="bibdiv-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="BIBDIV/NOTEFIG" mode="extract #default">
        <p class="bibdiv-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx AUTEURADRESSE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="AUTEURADRESSE" mode="extract #default">
        <div class="auteuradresse"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="AUTEURADRESSE/PARA" mode="extract #default">
        <p class="auteuradresse-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/GENERICPARA" mode="extract #default">
        <p class="auteuradresse-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="AUTEURADRESSE/PARALIBRE" mode="extract #default">
        <p class="auteuradresse-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/PARAPLUS" mode="extract #default">
        <p class="auteuradresse-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/PARASIGNATURE" mode="extract #default">
        <p class="auteuradresse-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="AUTEURADRESSE/PARAGRAPHIQUE" mode="extract #default">
        <p class="auteuradresse-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="auteuradresse-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="auteuradresse-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="auteuradresse-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="auteuradresse-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="auteuradresse-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="auteuradresse-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="auteuradresse-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="AUTEURADRESSE/RENVOI" mode="extract #default">
        <p class="auteuradresse-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="AUTEURADRESSE/FORMULE" mode="extract #default">
        <p class="auteuradresse-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/NEWPAGE" mode="extract #default">
        <p class="auteuradresse-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="AUTEURADRESSE/NOTETAB" mode="extract #default">
        <p class="auteuradresse-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="AUTEURADRESSE/NOTEFIG" mode="extract #default">
        <p class="auteuradresse-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LOI xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="LOI" mode="extract #default">
        <div class="loi"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="LOI/TITRE" mode="extract #default">
        <h4 class="loi-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="LOI/SOUSTITRE" mode="extract #default">
        <h5 class="loi-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="LOI/SSOUSTITRE" mode="extract #default">
        <h6 class="loi-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="LOI/SSSOUSTITRE" mode="extract #default">
        <h6 class="loi-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="LOI/PARA" mode="extract #default">
        <p class="loi-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/GENERICPARA" mode="extract #default">
        <p class="loi-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LOI/PARALIBRE" mode="extract #default">
        <p class="loi-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/PARAPLUS" mode="extract #default">
        <p class="loi-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/PARASIGNATURE" mode="extract #default">
        <p class="loi-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LOI/PARAGRAPHIQUE" mode="extract #default">
        <p class="loi-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="loi-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="loi-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="loi-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="loi-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="loi-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="loi-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="loi-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="LOI/RENVOI" mode="extract #default">
        <p class="loi-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LOI/FORMULE" mode="extract #default">
        <p class="loi-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/NEWPAGE" mode="extract #default">
        <p class="loi-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LOI/NOTETAB" mode="extract #default">
        <p class="loi-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LOI/NOTEFIG" mode="extract #default">
        <p class="loi-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>




<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx JURISPRUDENCE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="JURISPRUDENCE" mode="extract #default">
        <div class="jurisprudence"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="JURISPRUDENCE/TITRE" mode="extract #default">
        <h4 class="juri-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="JURISPRUDENCE/SOUSTITRE" mode="extract #default">
        <h5 class="jurisprudence-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="JURISPRUDENCE/SSOUSTITRE" mode="extract #default">
        <h6 class="jurisprudence-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="JURISPRUDENCE/SSSOUSTITRE" mode="extract #default">
        <h6 class="jurisprudence-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="JURISPRUDENCE/PARA" mode="extract #default">
        <p class="jurisprudence-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/GENERICPARA" mode="extract #default">
        <p class="jurisprudence-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="JURISPRUDENCE/PARALIBRE" mode="extract #default">
        <p class="jurisprudence-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/PARAPLUS" mode="extract #default">
        <p class="jurisprudence-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/PARASIGNATURE" mode="extract #default">
        <p class="jurisprudence-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="JURISPRUDENCE/PARAGRAPHIQUE" mode="extract #default">
        <p class="jurisprudence-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="jurisprudence-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/LISTE" mode="extract #default">



<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="jurisprudence-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="jurisprudence-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="jurisprudence-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="jurisprudence-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="jurisprudence-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="jurisprudence-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="JURISPRUDENCE/RENVOI" mode="extract #default">
        <p class="jurisprudence-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="JURISPRUDENCE/FORMULE" mode="extract #default">
        <p class="jurisprudence-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/NEWPAGE" mode="extract #default">
        <p class="jurisprudence-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="JURISPRUDENCE/NOTETAB" mode="extract #default">
        <p class="jurisprudence-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="JURISPRUDENCE/NOTEFIG" mode="extract #default">
        <p class="jurisprudence-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DOC xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="DOC" mode="extract #default">
        <div class="doc"><xsl:apply-templates/></div>
    </xsl:template>



<xsl:template match="DOC/TITRE" mode="extract #default">
        <h4 class="doc-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>





<xsl:template match="DOC/SOUSTITRE" mode="extract #default">
        <h5 class="doc-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="DOC/SSOUSTITRE" mode="extract #default">
        <h6 class="doc-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="DOC/SSSOUSTITRE" mode="extract #default">
        <h6 class="doc-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="DOC/PARA" mode="extract #default">
        <p class="doc-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/GENERICPARA" mode="extract #default">
        <p class="doc-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DOC/PARALIBRE" mode="extract #default">
        <p class="doc-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/PARAPLUS" mode="extract #default">
        <p class="doc-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/PARASIGNATURE" mode="extract #default">
        <p class="doc-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DOC/PARAGRAPHIQUE" mode="extract #default">
        <p class="doc-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="doc-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/LISTE" mode="extract #default">
        


<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="doc-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="doc-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="doc-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="doc-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="doc-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="doc-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="DOC/RENVOI" mode="extract #default">
        <p class="doc-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DOC/FORMULE" mode="extract #default">
        <p class="doc-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/NEWPAGE" mode="extract #default">
        <p class="doc-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DOC/NOTETAB" mode="extract #default">
        <p class="doc-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DOC/NOTEFIG" mode="extract #default">
        <p class="doc-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx GENERICNUMENV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="GENERICNUMENV" mode="extract #default">
        <div class="genericnumenv"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="GENERICNUMENV/TITRE" mode="extract #default">
        <h4 class="genericnumenv-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="GENERICNUMENV/SOUSTITRE" mode="extract #default">
        <h5 class="genericnumenv-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="GENERICNUMENV/SSOUSTITRE" mode="extract #default">
        <h6 class="genericnumenv-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="GENERICNUMENV/SSSOUSTITRE" mode="extract #default">
        <h6 class="genericnumenv-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="GENERICNUMENV/PARA" mode="extract #default">
        <p class="genericnumenv-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/GENERICPARA" mode="extract #default">
        <p class="genericnumenv-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="GENERICNUMENV/PARALIBRE" mode="extract #default">
        <p class="genericnumenv-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/PARAPLUS" mode="extract #default">
        <p class="genericnumenv-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/PARASIGNATURE" mode="extract #default">
        <p class="genericnumenv-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="GENERICNUMENV/PARAGRAPHIQUE" mode="extract #default">
        <p class="genericnumenv-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="genericnumenv-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="genericnumenv-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="genericnumenv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="genericnumenv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="genericnumenv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="genericnumenv-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="genericnumenv-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="GENERICNUMENV/RENVOI" mode="extract #default">
        <p class="genericnumenv-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="GENERICNUMENV/FORMULE" mode="extract #default">
        <p class="genericnumenv-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/NEWPAGE" mode="extract #default">
        <p class="genericnumenv-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNUMENV/NOTETAB" mode="extract #default">
        <p class="genericnumenv-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="GENERICNUMENV/NOTEFIG" mode="extract #default">
        <p class="genericnumenv-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx GENERICNONUMENV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

    <xsl:template match="GENERICNONUMENV" mode="extract #default">
        <div class="genericnonumenv"><xsl:apply-templates/></div>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/TITRE" mode="extract #default">
        <h4 class="genericnonumenv-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/SOUSTITRE" mode="extract #default">
        <h5 class="genericnonumenv-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/SSOUSTITRE" mode="extract #default">
        <h6 class="genericnonumenv-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/SSSOUSTITRE" mode="extract #default">
        <h6 class="genericnonumenv-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/PARA" mode="extract #default">
        <p class="genericnonumenv-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/GENERICPARA" mode="extract #default">
        <p class="genericnonumenv-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="GENERICNONUMENV/PARALIBRE" mode="extract #default">
        <p class="genericnonumenv-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/PARAPLUS" mode="extract #default">
        <p class="genericnonumenv-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/PARASIGNATURE" mode="extract #default">
        <p class="genericnonumenv-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/PARAGRAPHIQUE" mode="extract #default">
        <p class="genericnonumenv-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="genericnonumenv-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="genericnonumenv-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="genericnonumenv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="genericnonumenv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="genericnonumenv-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="genericnonumenv-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="genericnonumenv-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="GENERICNONUMENV/RENVOI" mode="extract #default">
        <p class="genericnonumenv-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="GENERICNONUMENV/FORMULE" mode="extract #default">
        <p class="genericnonumenv-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/NEWPAGE" mode="extract #default">
        <p class="genericnonumenv-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="GENERICNONUMENV/NOTETAB" mode="extract #default">
        <p class="genericnonumenv-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="GENERICNONUMENV/NOTEFIG" mode="extract #default">
        <p class="genericnonumenv-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx THEOREME xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="THEOREME" mode="extract #default">
        <div class="theoreme">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


<xsl:template match="THEOREME/TITRE" mode="extract #default">
        <h4 class="theoreme-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="THEOREME/PARA" mode="extract #default">
        <p class="theoreme-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/GENERICPARA" mode="extract #default">
        <p class="theoreme-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="THEOREME/PARALIBRE" mode="extract #default">
        <p class="theoreme-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/PARAPLUS" mode="extract #default">
        <p class="theoreme-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/PARASIGNATURE" mode="extract #default">
        <p class="theoreme-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="THEOREME/PARAGRAPHIQUE" mode="extract #default">
        <p class="theoreme-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="theoreme-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/LISTE" mode="extract #default">


<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="theoreme-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="theoreme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="theoreme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="theoreme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="theoreme-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="theoreme-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="THEOREME/RENVOI" mode="extract #default">
        <p class="theoreme-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="THEOREME/FORMULE" mode="extract #default">
        <p class="theoreme-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/NEWPAGE" mode="extract #default">
        <p class="theoreme-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="THEOREME/NOTETAB" mode="extract #default">
        <p class="theoreme-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="THEOREME/NOTEFIG" mode="extract #default">
        <p class="theoreme-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LEMME xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="LEMME" mode="extract #default">
        <dv class="lemme">
            <xsl:apply-templates/>
        </dv>
    </xsl:template>

<xsl:template match="LEMME/TITRE" mode="extract #default">
        <h4 class="lemme-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="LEMME/PARA" mode="extract #default">
        <p class="lemme-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/GENERICPARA" mode="extract #default">
        <p class="lemme-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LEMME/PARALIBRE" mode="extract #default">
        <p class="lemme-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/PARAPLUS" mode="extract #default">
        <p class="lemme-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/PARASIGNATURE" mode="extract #default">
        <p class="lemme-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LEMME/PARAGRAPHIQUE" mode="extract #default">
        <p class="lemme-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="lemme-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="lemme-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="lemme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="lemme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="lemme-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="lemme-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="lemme-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="LEMME/RENVOI" mode="extract #default">
        <p class="lemme-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="LEMME/FORMULE" mode="extract #default">
        <p class="lemme-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/NEWPAGE" mode="extract #default">
        <p class="lemme-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="LEMME/NOTETAB" mode="extract #default">
        <p class="lemme-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="LEMME/NOTEFIG" mode="extract #default">
        <p class="lemme-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DEMONSTRATION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="DEMONSTRATION" mode="extract #default">
        <div class="demonstration">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="DEMONSTRATION/TITRE" mode="extract #default">
        <h4 class="demonstration-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="DEMONSTRATION/PARA" mode="extract #default">
        <p class="demonstration-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/GENERICPARA" mode="extract #default">
        <p class="demonstration-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DEMONSTRATION/PARALIBRE" mode="extract #default">
        <p class="demonstration-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/PARAPLUS" mode="extract #default">
        <p class="demonstration-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/PARASIGNATURE" mode="extract #default">
        <p class="demonstration-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DEMONSTRATION/PARAGRAPHIQUE" mode="extract #default">
        <p class="demonstration-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="demonstration-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="demonstration-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="demonstration-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="demonstration-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="demonstration-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="demonstration-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="demonstration-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="DEMONSTRATION/RENVOI" mode="extract #default">
        <p class="demonstration-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DEMONSTRATION/FORMULE" mode="extract #default">
        <p class="demonstration-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/NEWPAGE" mode="extract #default">
        <p class="demonstration-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEMONSTRATION/NOTETAB" mode="extract #default">
        <p class="demonstration-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DEMONSTRATION/NOTEFIG" mode="extract #default">
        <p class="demonstration-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx COROLLAIRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="COROLLAIR" mode="extract #default">
        <div class="corollaire">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


<xsl:template match="COROLLAIRE/TITRE" mode="extract #default">
        <h4 class="corollaire-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="COROLLAIRE/PARA" mode="extract #default">
        <p class="corollaire-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/GENERICPARA" mode="extract #default">
        <p class="corollaire-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="COROLLAIRE/PARALIBRE" mode="extract #default">
        <p class="corollaire-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/PARAPLUS" mode="extract #default">
        <p class="corollaire-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/PARASIGNATURE" mode="extract #default">
        <p class="corollaire-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="COROLLAIRE/PARAGRAPHIQUE" mode="extract #default">
        <p class="corollaire-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="corollaire-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="corollaire-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="corollaire-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="corollaire-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="corollaire-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="corollaire-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="corollaire-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="COROLLAIRE/RENVOI" mode="extract #default">
        <p class="corollaire-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="COROLLAIRE/FORMULE" mode="extract #default">
        <p class="corollaire-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/NEWPAGE" mode="extract #default">
        <p class="corollaire-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="COROLLAIRE/NOTETAB" mode="extract #default">
        <p class="corollaire-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="COROLLAIRE/NOTEFIG" mode="extract #default">
        <p class="corollaire-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx DEFINITION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="DEFINITION" mode="extract #default">
        <div class="definition">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="DEFINITION/TITRE" mode="extract #default">
        <h4 class="definition-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>



<xsl:template match="DEFINITION/PARA" mode="extract #default">
        <p class="definition-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/GENERICPARA" mode="extract #default">
        <p class="definition-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DEFINITION/PARALIBRE" mode="extract #default">
        <p class="definition-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/PARAPLUS" mode="extract #default">
        <p class="definition-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/PARASIGNATURE" mode="extract #default">
        <p class="definition-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DEFINITION/PARAGRAPHIQUE" mode="extract #default">
        <p class="definition-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="definition-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="definition-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="definition-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="definition-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="definition-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="definition-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="definition-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="DEFINITION/RENVOI" mode="extract #default">
        <p class="definition-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="DEFINITION/FORMULE" mode="extract #default">
        <p class="definition-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/NEWPAGE" mode="extract #default">
        <p class="definition-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="DEFINITION/NOTETAB" mode="extract #default">
        <p class="definition-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="DEFINITION/NOTEFIG" mode="extract #default">
        <p class="definition-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PROPOSITION xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="PROPOSITION" mode="extract #default">
        <div class="proposition">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="PROPOSITION/TITRE" mode="extract #default">
        <h4 class="proposition-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="PROPOSITION/PARA" mode="extract #default">
        <p class="proposition-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/GENERICPARA" mode="extract #default">
        <p class="proposition-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROPOSITION/PARALIBRE" mode="extract #default">
        <p class="proposition-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/PARAPLUS" mode="extract #default">
        <p class="proposition-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/PARASIGNATURE" mode="extract #default">
        <p class="proposition-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROPOSITION/PARAGRAPHIQUE" mode="extract #default">
        <p class="proposition-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="proposition-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/LISTE" mode="extract #default">
        

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="proposition-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="proposition-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="proposition-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="proposition-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="proposition-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="proposition-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>


    </xsl:template>

<xsl:template match="PROPOSITION/RENVOI" mode="extract #default">
        <p class="proposition-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROPOSITION/FORMULE" mode="extract #default">
        <p class="proposition-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/NEWPAGE" mode="extract #default">
        <p class="proposition-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPOSITION/NOTETAB" mode="extract #default">
        <p class="proposition-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROPOSITION/NOTEFIG" mode="extract #default">
        <p class="proposition-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PROPRIETE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PROPRIETE" mode="extract #default">
        <div class="propriete">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

<xsl:template match="PROPRIETE/TITRE" mode="extract #default">
        <h4 class="propriete-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="PROPRIETE/SOUSTITRE" mode="extract #default">
        <h5 class="propriete-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="PROPRIETE/SSOUSTITRE" mode="extract #default">
        <h6 class="propriete-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PROPRIETE/SSSOUSTITRE" mode="extract #default">
        <h6 class="propriete-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="PROPRIETE/PARA" mode="extract #default">
        <p class="propriete-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/GENERICPARA" mode="extract #default">
        <p class="propriete-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROPRIETE/PARALIBRE" mode="extract #default">
        <p class="propriete-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/PARAPLUS" mode="extract #default">
        <p class="propriete-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/PARASIGNATURE" mode="extract #default">
        <p class="propriete-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROPRIETE/PARAGRAPHIQUE" mode="extract #default">
        <p class="propriete-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="propriete-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/LISTE" mode="extract #default">
        


<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="propriete-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="propriete-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="propriete-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="propriete-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="propriete-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="propriete-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>

    </xsl:template>

<xsl:template match="PROPRIETE/RENVOI" mode="extract #default">
        <p class="propriete-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="PROPRIETE/FORMULE" mode="extract #default">
        <p class="propriete-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/NEWPAGE" mode="extract #default">
        <p class="propriete-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="PROPRIETE/NOTETAB" mode="extract #default">
        <p class="propriete-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="PROPRIETE/NOTEFIG" mode="extract #default">
        <p class="propriete-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CHAPO xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="CHAPO" mode="extract #default">
        <div class="chapo">
            <xsl:apply-templates/>
        </div>
    </xsl:template>



<xsl:template match="CHAPO/TITRE" mode="extract #default">
        <h4 class="chapo-titre">
            <xsl:apply-templates/>
        </h4>
    </xsl:template>


<xsl:template match="CHAPO/SOUSTITRE" mode="extract #default">
        <h5 class="chapo-soustitre">
            <xsl:apply-templates/>
        </h5>
    </xsl:template>


<xsl:template match="CHAPO/SSOUSTITRE" mode="extract #default">
        <h6 class="chapo-ssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="CHAPO/SSSOUSTITRE" mode="extract #default">
        <h6 class="chapo-sssoustitre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>


<xsl:template match="CHAPO/PARA" mode="extract #default">
        <p class="chapo-para">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/GENERICPARA" mode="extract #default">
        <p class="chapo-genericpara">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CHAPO/PARALIBRE" mode="extract #default">
        <p class="chapo-paralibre">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/PARAPLUS" mode="extract #default">
        <p class="chapo-paraplus">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/PARASIGNATURE" mode="extract #default">
        <p class="chapo-parasignature">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CHAPO/PARAGRAPHIQUE" mode="extract #default">
        <p class="chapo-paragraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/PARATABLEAUGRAPHIQUE" mode="extract #default">
        <p class="chapo-paratableaugraphique">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/LISTE" mode="extract #default">

<xsl:choose>
    <xsl:when test="@class='puce'">
        <ul class="chapo-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:when test="@class='num'">
        <ol class="chapo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numa'">
        <ol class="chapo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='numi'">
        <ol class="chapo-liste-{@class}"><xsl:apply-templates/></ol>
</xsl:when>
<xsl:when test="@class='tiret'">
        <ul class="chapo-liste-{@class}"><xsl:apply-templates/></ul>
</xsl:when>
<xsl:otherwise>
        <ul class="chapo-liste"><xsl:apply-templates/></ul>
</xsl:otherwise>
</xsl:choose>
        
    </xsl:template>

<xsl:template match="CHAPO/RENVOI" mode="extract #default">
        <p class="chapo-renvoi">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<xsl:template match="CHAPO/FORMULE" mode="extract #default">
        <p class="chapo-formule">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/NEWPAGE" mode="extract #default">
        <p class="chapo-newpage">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

<xsl:template match="CHAPO/NOTETAB" mode="extract #default">
        <p class="chapo-notetab">
            <xsl:apply-templates/>
        </p>
    </xsl:template>



<xsl:template match="CHAPO/NOTEFIG" mode="extract #default">
        <p class="chapo-notefig">
            <xsl:apply-templates/>
        </p>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LIVREBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="LIVREBODY" mode="extract #default">
        <div class="livrebody"><xsl:apply-templates/></div>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARTBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="PARTBODY" mode="extract #default">
        <div class="partbody"><xsl:apply-templates mode="#current"/></div>
    </xsl:template>



<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ANNEXESBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="ANNEXESBODY" mode="extract #default">
        <div class="annexesbody"><xsl:apply-templates/></div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CHAPBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="CHAPBODY" mode="extract #default">
        <div class="chapbody"><xsl:apply-templates/></div>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx ANNBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="ANNBODY" mode="extract #default">
        <div class="annbody"><xsl:apply-templates/></div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FRONTBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="FRONTBODY" mode="extract #default">
        <div class="frontbody"><xsl:apply-templates/></div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CPTR xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="CPTR" mode="extract #default">
        <div class="cptr"><xsl:apply-templates/></div>
    </xsl:template>


  <xsl:template match="CPTR/TITRE" mode="extract #default">
        <h2 class="cptr-titre"><xsl:apply-templates/></h2>
    </xsl:template>

  <xsl:template match="CPTR/CPTRREF" mode="extract #default">
        <p class="cptr-cptrref"><xsl:apply-templates/></p>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx CPTRBODY xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="CPTRBODY" mode="extract #default">
        <div class="cptrbody"><xsl:apply-templates/></div>
    </xsl:template>


  <xsl:template match="CPTRBODY/TITRE" mode="extract #default">
        <h2 class="cptrbody-titre"><xsl:apply-templates/></h2>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LIVRE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="LIVRE" mode="extract #default">
        <div class="livre"><xsl:apply-templates/></div>
    </xsl:template>


  <xsl:template match="LIVRE/TITRE" mode="extract #default">
        <h1 class="livre-titre"><xsl:apply-templates/></h1>
    </xsl:template>


  <xsl:template match="LIVRE/SOUSTITRE" mode="extract #default">
        <h2 class="livre-soustitre"><xsl:apply-templates/></h2>
    </xsl:template>



  <xsl:template match="LIVRE/AUTEUR" mode="extract #default">
        <h3 class="livre-auteur"><xsl:apply-templates/></h3>
    </xsl:template>


  <xsl:template match="LIVRE/EXERGUE" mode="extract #default">
        <div class="livre-exergue"><xsl:apply-templates/></div>
    </xsl:template>


  <xsl:template match="LIVRE/LIVREBODY" mode="extract #default">
        <div class="livrebody"><xsl:apply-templates/></div>
    </xsl:template>


<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx LIVREDIV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

  <xsl:template match="LIVREDIV" mode="extract #default">
        <div class="livrediv"><xsl:apply-templates/></div>
    </xsl:template>


  <xsl:template match="LIVREDIV/TITRE" mode="extract #default">
        <h1 class="livrediv-titre"><xsl:apply-templates/></h1>
    </xsl:template>


  <xsl:template match="LIVREDIV/SOUSTITRE" mode="extract #default">
        <h2 class="livrediv-soustitre"><xsl:apply-templates/></h2>
    </xsl:template>



  <xsl:template match="LIVREDIV/AUTEUR" mode="extract #default">
        <h3 class="livrediv-auteur"><xsl:apply-templates/></h3>
    </xsl:template>



  <xsl:template match="LIVREDIV/EXERGUE" mode="extract #default">
        <div class="livrediv-exergue"><xsl:apply-templates/></div>
    </xsl:template>

  <xsl:template match="LIVREDIV/LIVREBODY" mode="extract #default">
        <div class="livrebody"><xsl:apply-templates/></div>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARTDIV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PARTDIV" mode="extract #default">
        <div class="partdiv"><xsl:apply-templates/></div>
    </xsl:template>

<xsl:template match="PARTDIV/SOUSTITRE" mode="extract #default">
        <h3 class="partdiv/soustitre"><xsl:apply-templates/></h3>
    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx TABLE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


   <xsl:template match="TABLEAU" mode="extract #default">
        <div class="table">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

   <xsl:template match="TABLEAU/LEGENDE" mode="extract #default">
        <h6 class="table-titre">
            <xsl:apply-templates/>
        </h6>
    </xsl:template>
    <xsl:template match="tableau/stab" mode="extract #default">
        <div class="fig">
            <xsl:variable name="alt" as="xs:string">
                <xsl:number count="img | stab" format="001" level="any"/>
            </xsl:variable>
            <img src="images/{@src}" alt="{$alt}" id="{(@id, generate-id(.))[1]}"
                class="{if (ancestor::pagetitre) then 'imgpp' else 'img'}"/>
        </div>
    </xsl:template>
    <xsl:template match="TABLE" mode="extract #default">
        
        <table>
            <xsl:apply-templates/>
        </table>
    </xsl:template>
  
  <xsl:template match="TABLE/LEGENDE" mode="extract #default">
<caption><xsl:apply-templates/></caption>
  </xsl:template>
  
  <xsl:template match="tgroup" mode="extract #default">
        <xsl:apply-templates select="thead"/>
        <xsl:apply-templates select="tbody"/>
        <xsl:apply-templates select="tfoot"/>
    </xsl:template>
    <xsl:template match="row" mode="extract #default">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

    <xsl:template match="CELL" mode="extract #default">
<td>
<xsl:if test="@valign">
<xsl:attribute name="valign">
<xsl:value-of select="@valign"></xsl:value-of>
</xsl:attribute>
</xsl:if>

<xsl:if test="@span">
<xsl:attribute name="colspan">
<xsl:value-of select="@span"></xsl:value-of>
</xsl:attribute>
</xsl:if>

<xsl:if test="@vspan">
<xsl:attribute name="rowspan">
<xsl:value-of select="@vspan"></xsl:value-of>
</xsl:attribute>
</xsl:if>

<xsl:apply-templates/>
</td>
    </xsl:template>

    <xsl:template match="ROW" mode="extract #default">
        <tr>
            <xsl:apply-templates/>
        </tr>
    </xsl:template>

 
<xsl:template match="tbody" mode="rowspan">
 <tbody>
    <xsl:copy>
      <xsl:copy-of select="row[1]" />
      <xsl:apply-templates select="row[2]" mode="rowspan">
        <xsl:with-param name="previousRow" select="tr[1]" />
      </xsl:apply-templates>
    </xsl:copy>
 </tbody>
  </xsl:template>
  <xsl:template match="thead" mode="rowspan">
    <thead>
    <xsl:copy>
      <xsl:copy-of select="row[1]" />
      <xsl:apply-templates select="row[2]" mode="rowspan">
        <xsl:with-param name="previousRow" select="tr[1]" />
      </xsl:apply-templates>
    </xsl:copy>
    </thead>
  </xsl:template>
  
  <xsl:template match="thead">
    <thead>
     
        <xsl:apply-templates/>
   
    </thead>
  </xsl:template>
  
  <xsl:template match="tbody">
    <tbody>
      
      <xsl:apply-templates/>
      
    </tbody>
  </xsl:template>
  
  <xsl:template match="table">
    
    <table width="100%">
      <xsl:apply-templates select="descendant::*[self::title or self::tgroup]"/></table>
  </xsl:template>
  
  
  <xsl:template match="entry">
    <td>
<xsl:if test="@valign">
<xsl:attribute name="valign">
<xsl:value-of select="@valign"/>
</xsl:attribute>
</xsl:if>

<xsl:if test="@align">
<xsl:attribute name="align">
<xsl:value-of select="@align"/>
</xsl:attribute>
</xsl:if>


      <xsl:apply-templates/>
    </td>
  </xsl:template>


  <xsl:template match="title[parent::table]">
    <caption><xsl:apply-templates/></caption>
  </xsl:template>
  

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx FIGURE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


    <xsl:template match="FIGURE" mode="extract #default">
        <div class="figure">
            <xsl:apply-templates/>
        </div>
    </xsl:template>


    <xsl:template match="FIGURE/LEGENDE" mode="extract #default">
        <p class="legende">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="INCLUDEGRAPHIC" mode="extract #default">

  <xsl:variable name="src">
                    <xsl:analyze-string select="@name" regex="(eps)|(psd)|(tiff)|(tif)">
                        <xsl:matching-substring>
                            <xsl:value-of select="replace(regex-group(1), '(eps)', 'jpg')"/>
                            <xsl:value-of select="replace(regex-group(2), '(psd)', 'jpg')"/>
                            <xsl:value-of select="replace(regex-group(3), '(tiff)', 'jpg')"/>
                            <xsl:value-of select="replace(regex-group(4), '(tif)', 'jpg')"/>
                            
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:sequence select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:variable>


<xsl:element name="img">

<xsl:if test="@height">
<xsl:attribute name="height">
<xsl:value-of select="@height"/>
</xsl:attribute>
</xsl:if>

<xsl:if test="@width">
<xsl:attribute name="width">
<xsl:value-of select="@width"/>
</xsl:attribute>
</xsl:if>


<xsl:if test="@name">

<xsl:attribute name="src">
<xsl:text>images/</xsl:text>
<xsl:value-of select="$src"/>
</xsl:attribute>
</xsl:if>

<xsl:attribute name="alt">
<xsl:value-of select="@name"/>
</xsl:attribute>

</xsl:element>        

    </xsl:template>
   
  
  <xsl:key name="LevelDistint" match="INCLUDEGRAPHIC" use="@name"/>

    <xsl:template match="INCLUDEGRAPHIC" mode="manifest">
 <xsl:for-each select=".[generate-id() = generate-id(key('LevelDistint', @name)[1])]">
                                                                
            <xsl:variable name="media.type"
                            select="if (ends-with(@name, '.tif')) then 'image/jpeg'
                      else if (ends-with(@name, '.tiff')) then 'image/jpeg'
                      else if (ends-with(@name, '.psd')) then 'image/jpeg'  
                      else if (ends-with(@name, '.jpg')) then 'image/jpeg'
                      else if (ends-with(@name, '.jpg')) then 'image/jpeg'  
                      else if (ends-with(@name, '.jpeg')) then 'image/jpeg'
                      else if (ends-with(@name, '.gif')) then 'image/gif'
                      else if (ends-with(@name, '.png')) then 'image/png'
                      else if (ends-with(@name, '.eps')) then 'image/jpeg'
                      else ''"/>
                    <xsl:variable name="image">
                    <xsl:value-of select="@name"/>
                    </xsl:variable>
                        
                  <xsl:variable name="src">
                    <xsl:analyze-string select="$image" regex="(eps)|(psd)|(tiff)|(tif)">
                        <xsl:matching-substring>
                            <xsl:value-of select="replace(regex-group(1), '(eps)', 'jpg')"/>
                            <xsl:value-of select="replace(regex-group(2), '(psd)', 'jpg')"/>
                            <xsl:value-of select="replace(regex-group(3), '(tiff)', 'jpg')"/>
                            <xsl:value-of select="replace(regex-group(4), '(tif)', 'jpg')"/>
                        </xsl:matching-substring>
                        <xsl:non-matching-substring>
                            <xsl:sequence select="."/>
                        </xsl:non-matching-substring>
                    </xsl:analyze-string>
                </xsl:variable>

                        <xsl:element name="item" namespace="http://www.idpf.org/2007/opf">
                            <xsl:attribute name="id" select="generate-id()"/>
                            <xsl:attribute name="href" select="concat('images/', $src)"/>
                            <xsl:attribute name="media-type" select="$media.type"/>
                        </xsl:element>
</xsl:for-each>  
</xsl:template>
    
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGEPRELIM xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGEPRELIM" mode="extract #default">
<div class="pageprelim">
  <xsl:apply-templates/>
</div>      

    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGECOUV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGECOUV" mode="extract #default">
<div class="pagecouv">
  <xsl:apply-templates/>
</div>      

    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGECOUVNUMERIC xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGECOUVNUMERIC" mode="extract #default">
<div class="pagecouvnumeric">
  <xsl:apply-templates/>
</div>      

    </xsl:template>
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGECOPYRIGHTEPUB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGECOPYRIGHTEPUB" mode="extract #default">
<div class="pagecopyrightepub">
  <xsl:apply-templates/>
</div>      

    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGECOPYRIGHTPDFWEB xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGECOPYRIGHTPDFWEB" mode="extract #default">
<div class="pagecopyrightpdfweb">
  <xsl:apply-templates/>
</div>    

</xsl:template>
<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGEQUATRECOUV xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGEQUATRECOUV" mode="extract #default">
<div class="pagequatrecouv">
  <xsl:apply-templates/>
</div>   

    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PAGEQUATRECOUVNUMERIC xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->

<xsl:template match="PAGEQUATRECOUVNUMERIC" mode="extract #default">
<div class="pagequatrecouvnumeric">
  <xsl:apply-templates/>
</div>   

    </xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx PARA ATRRIBUTE xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template  name="attrib">
<xsl:if test="@Align">
<xsl:attribute name="style">text-align:<xsl:value-of select="@Align"/></xsl:attribute>
</xsl:if>
</xsl:template>

<!-- xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx SIGNET xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx  -->


<xsl:template match="SIGNET">
<a>
<xsl:if test="@name">
<xsl:attribute name="id">
<xsl:value-of select="@name"/>
</xsl:attribute>
</xsl:if>
<xsl:apply-templates/></a>

</xsl:template>


</xsl:stylesheet>

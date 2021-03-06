<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="2.0" 
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xs="http://www.w3.org/2001/XMLSchema"
	xmlns:mml="http://www.w3.org/1998/Math/MathML" 
	xmlns:xhtml="http://www.w3.org/1999/xhtml"
	xmlns:xlink="http://www.w3.org/1999/xlink" 
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:cr="http://www.crossref.org/qrschema/2.0" 
	xmlns:file="http://expath.org/ns/file"
	xmlns:ptol="http://www.physicstoday.org"
	xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl"
	xmlns:dc="http://purl.org/dc/elements/1.1/"
	exclude-result-prefixes="cr xhtml file ptol xs xsi">
	
	
	<xsl:output name="xmlFormat"
		method="xml" 
		omit-xml-declaration="no" 
		encoding="UTF-8" 
		indent="no"
		doctype-system="../Atypon-Issue-Xml.dtd"
		doctype-public="-//Atypon//DTD Atypon JATS Journal Archiving and Interchange Issue XML DTD v1.1 20160222//EN" />
	
	
	
	
	
	
	<xd:doc scope="stylesheet">
		<xd:desc>
			<xd:p><xd:b>Created on:</xd:b> Feb 10, 2017</xd:p>
			<xd:p><xd:b>Author:</xd:b> adombros</xd:p>
			<xd:p>XSLT used to create Atypon Issue-XML file from JATS v1.0 20120330//EN, JATS-archivearticle1.dtd</xd:p>
		</xd:desc>
	</xd:doc>
	<xsl:key name="physupdate"
		match="/article/front/article-meta/article-categories/subj-group/subj-group[contains(subject, 'Physics Update')]"
		use="@subject" />
	
	<xsl:variable name="physupdate-items" select="key('physupdate', subject)" />
	
	
	
	
	
	<xsl:template match="article">
		<issue-xml>
			<xsl:copy-of select="/article/front/journal-meta"
				copy-namespaces="no" />
			<issue-meta issue-type="normal">
				<xsl:copy-of select="/article/front/article-meta/pub-date"
					copy-namespaces="no" />
				<xsl:copy-of select="/article/front/article-meta/volume"
					copy-namespaces="no" />
				<xsl:copy-of select="/article/front/article-meta/issue"
					copy-namespaces="no" />
				<issue-id pub-id-type="doi">10.1063/pto.<xsl:value-of
					select="/article/front/article-meta/pub-date/year"/>.<xsl:value-of
					select="/article/front/article-meta/volume"
				/>.issue-<xsl:value-of
					select="/article/front/article-meta/issue" /></issue-id>
			</issue-meta>
			<toc toc-type="subject-heading-order">
				<!--1. Collect all files in selected directory for input-->
				<xsl:variable name="files"
					select="collection(iri-to-uri(resolve-uri('?select=*.xml', document-uri(/))))" />
				<xsl:for-each-group select="$files"
					group-by="/article/front/article-meta/article-categories/subj-group/subject">
					<xsl:comment>Begin <xsl:value-of select="/article/front/article-meta/article-categories/subj-group/subject" /></xsl:comment>
					<issue-subject-group>
						<issue-subject-title>
							<subject>
								<xsl:value-of select="current-grouping-key()" />
							</subject>
						</issue-subject-title>
						
		
						<xsl:for-each select="current-group()">
							<issue-subject-group>
								<issue-subject-title>
									<subject></subject>
								</issue-subject-title>
							<issue-article-meta>
								<article-id pub-id-type="doi">
									<xsl:value-of
										select="/article/front/article-meta/article-id[@pub-id-type = 'doi']"/>
								</article-id>
							</issue-article-meta>
							</issue-subject-group>
						</xsl:for-each>
					</issue-subject-group>
				</xsl:for-each-group>
				
				
				
				
			</toc>
		</issue-xml>
	</xsl:template>
	
	
	<xsl:template name="title-grp">
		
			<issue-subject-group>
				<issue-subject-title>
					<subject><xsl:value-of select="/article/front/article-meta/title-group/article-title[1]"/></subject>
				</issue-subject-title>
			</issue-subject-group>
		
		
	</xsl:template>
	
	
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<!--
(The MIT License)

Copyright (c) 2022 Yegor Bugayenko

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the 'Software'), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output encoding="UTF-8" method="xml"/>
  <xsl:key name="metrics" match="/cobench/coders/coder/metrics/m" use="@id"/>
  <xsl:template match="/">
    <html>
      <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <title>cobench</title>
        <meta charset="UTF-8"/>
        <meta content="width=device-width, initial-scale=1.0" name="viewport"/>
        <link rel="icon" href="https://raw.githubusercontent.com/yegor256/cobench/master/logo.svg" type="image/svg"/>
        <link href="https://cdn.jsdelivr.net/gh/yegor256/tacit@gh-pages/tacit-css.min.css" rel="stylesheet"/>
        <link href="https://cdn.jsdelivr.net/gh/yegor256/drops@gh-pages/drops.min.css" rel="stylesheet"/>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery.tablesorter/2.31.3/js/jquery.tablesorter.min.js"></script>
        <script type="text/javascript">
          $(function() {
            $("#metrics").tablesorter();
          });
        </script>
      </head>
      <body>
        <xsl:apply-templates select="cobench/coders"/>
        <p>
          <xsl:text>The page was generated by on </xsl:text>
          <a href="https://github.com/yegor256/cobench">
            <xsl:text>cobench</xsl:text>
          </a>
          <xsl:text> on </xsl:text>
          <xsl:value-of select="cobench/@time"/>
          <xsl:text>. The numbers you see reflect the activity of the last </xsl:text>
          <b>
            <xsl:value-of select="cobench/@days"/>
            <xsl:text> days</xsl:text>
          </b>
          <xsl:text>.</xsl:text>
        </p>
      </body>
    </html>
  </xsl:template>
  <xsl:template match="cobench/coders">
    <table id="metrics">
      <thead>
        <tr>
          <th/>
          <xsl:for-each select="coder/metrics/m[generate-id() = generate-id(key('metrics', @id)[1])]">
            <th>
              <xsl:value-of select="@id"/>
            </th>
          </xsl:for-each>
        </tr>
      </thead>
      <tbody>
        <xsl:apply-templates select="coder"/>
      </tbody>
    </table>
  </xsl:template>
  <xsl:template match="coder">
    <tr>
      <td>
        <a href="https://github.com/{@id}">
          <xsl:text>@</xsl:text>
          <xsl:value-of select="@id"/>
        </a>
      </td>
      <xsl:apply-templates select="metrics/m"/>
    </tr>
  </xsl:template>
  <xsl:template match="m">
    <td>
      <a href="{@href}">
        <xsl:value-of select="."/>
      </a>
    </td>
  </xsl:template>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
</xsl:stylesheet>

<?xml version="1.0" encoding="UTF-8"?>
<!-- $Id$ -->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">

            <!-- Location of file defining the parameters and variables -->
            <xsl:variable name="param-file">
                        <xsl:text>global-parameters.xml</xsl:text>
            </xsl:variable>

            <!-- Location of HGV glossary file relative to the current file -->
            <xsl:param name="hgv-gloss">
                        <xsl:text>../../../xml/idp.data/trunk/HGV_trans_EpiDoc/glossary.xml</xsl:text>
            </xsl:param>

            <!-- Mapping file -->
            <xsl:variable name="mapping-file"
                        select="'../crosswalker/aggregator/mapping/mapping.xml'"/>

            <xsl:param name="topNav"
                        select="document($param-file)//parameter[name = 'topNav']/value[@on = 'yes']"/>
            <xsl:param name="verse-lines"
                        select="document($param-file)//parameter[name = 'verse-lines']/value[@on = 'yes']"/>
            <xsl:param name="leiden-style"
                        select="document($param-file)//parameter[name = 'leiden-style']/value[@on = 'yes']"/>
            <xsl:param name="edn-structure"
                        select="document($param-file)//parameter[name = 'edn-structure']/value[@on = 'yes']"/>
            <xsl:param name="edition-type"
                        select="document($param-file)//parameter[name = 'edition-type']/value[@on = 'yes']"/>
            <xsl:param name="internal-app-style"
                        select="document($param-file)//parameter[name = 'internal-app-style']/value[@on = 'yes']"/>
            <xsl:param name="external-app-style"
                        select="document($param-file)//parameter[name = 'external-app-style']/value[@on = 'yes']"/>
            <xsl:param name="line-inc"
                        select="document($param-file)//parameter[name = 'line-inc']/value"/>
            <xsl:param name="css-loc"
                        select="document($param-file)//parameter[name = 'css-loc']/value"/>
            <xsl:param name="js-dir"
                        select="document($param-file)//parameter[name = 'js-dir']/value"/>
            <xsl:param name="bibliography"
                        select="document($param-file)//parameter[name = 'bibliography']/value[@on = 'yes']"/>
            <xsl:param name="localbibl"
                        select="document($param-file)//parameter[name = 'localbibl']/value"/>
            <xsl:param name="ZoteroUorG" 
                        select="document($param-file)//parameter[name = 'ZoteroUorG']/value[@on = 'yes']"/>
            <xsl:param name="ZoteroKey"
                        select="document($param-file)//parameter[name = 'ZoteroKey']/value[@on = 'yes']"/>
            <xsl:param name="ZoteroNS"
                        select="document($param-file)//parameter[name = 'ZoteroNS']/value[@on='yes']"/>
            <xsl:param name="ZoteroStyle"
                        select="document($param-file)//parameter[name = 'ZoteroStyle']/value[@on = 'yes']"/>
            <xsl:param name="glyph-variant"
                        select="document($param-file)//parameter[name = 'glyph-variant']/value[@on = 'yes']"/>
    
            <xsl:param name="docroot">../output/data</xsl:param>

            <xsl:variable name="all-grc">
                        <xsl:text>abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZἀἁἂἃἄἅἆἇἈἉἊἋἌἍἎἏΑὰάᾀᾁᾂᾃᾄᾅᾆᾇᾈᾉᾊᾋᾌᾍᾎᾏᾲᾳᾴᾶᾷάέΕἐἑἒἓἔἕἘἙἚἛἜἝὲέΗήἠἡἢἣἤἥἦἧἨἩἪἫἬἭἮἯᾐᾑᾒᾓᾔᾕᾖᾗᾘᾙᾚᾛᾜᾝᾞᾟῂῃῄῆῇὴήΙίϊἰἱἲἳἴἵἶἷἸἹἺἻἼἽἾἿὶίῒΐΐῖῗΟόὀὁὂὃὄὅὈὉὊὋὌὍὸό΅ύὐὑὒὓὔὕὖὗὙὛὝὟὺύῢΰΰῦῧϋΩώὠὡὢὣὤὥὦὧὨὩὪὫὬὭὮὯὼώᾠᾡᾢᾣᾤᾥᾦᾧᾨᾩᾪᾫᾬᾭᾮᾯῲῳῴῶῷςῤῥαβγδεζηθικλμνξοπρστυφχψωῬΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ</xsl:text>
                        <!--<xsl:text>abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ&#x1F00;&#x1F01;&#x1F02;&#x1F03;&#x1F04;&#x1F05;&#x1F06;&#x1F07;&#x1F08;&#x1F09;&#x1F0A;&#x1F0B;&#x1F0C;&#x1F0D;&#x1F0E;&#x1F0F;&#x391;&#x1F70;&#x1F71;&#x1F80;&#x1F81;&#x1F82;&#x1F83;&#x1F84;&#x1F85;&#x1F86;&#x1F87;&#x1F88;&#x1F89;&#x1F8A;&#x1F8B;&#x1F8C;&#x1F8D;&#x1F8E;&#x1F8F;&#x1FB2;&#x1FB3;&#x1FB4;&#x1FB6;&#x1FB7;&#x3AC;&#x3AD;&#x395;&#x1F10;&#x1F11;&#x1F12;&#x1F13;&#x1F14;&#x1F15;&#x1F18;&#x1F19;&#x1F1A;&#x1F1B;&#x1F1C;&#x1F1D;&#x1F72;&#x1F73;&#x397;&#x3AE;&#x1F20;&#x1F21;&#x1F22;&#x1F23;&#x1F24;&#x1F25;&#x1F26;&#x1F27;&#x1F28;&#x1F29;&#x1F2A;&#x1F2B;&#x1F2C;&#x1F2D;&#x1F2E;&#x1F2F;&#x1F90;&#x1F91;&#x1F92;&#x1F93;&#x1F94;&#x1F95;&#x1F96;&#x1F97;&#x1F98;&#x1F99;&#x1F9A;&#x1F9B;&#x1F9C;&#x1F9D;&#x1F9E;&#x1F9F;&#x1FC2;&#x1FC3;&#x1FC4;&#x1FC6;&#x1FC7;&#x1F74;&#x1F75;&#x399;&#x3AF;&#x3CA;&#x1F30;&#x1F31;&#x1F32;&#x1F33;&#x1F34;&#x1F35;&#x1F36;&#x1F37;&#x1F38;&#x1F39;&#x1F3A;&#x1F3B;&#x1F3C;&#x1F3D;&#x1F3E;&#x1F3F;&#x1F76;&#x1F77;&#x1FD2;&#x1FD3;&#x0390;&#x1FD6;&#x1FD7;&#x39F;&#x3CC;&#x1F40;&#x1F41;&#x1F42;&#x1F43;&#x1F44;&#x1F45;&#x1F48;&#x1F49;&#x1F4A;&#x1F4B;&#x1F4C;&#x1F4D;&#x1F78;&#x1F79;&#x385;&#x3CD;&#x1F50;&#x1F51;&#x1F52;&#x1F53;&#x1F54;&#x1F55;&#x1F56;&#x1F57;&#x1F59;&#x1F5B;&#x1F5D;&#x1F5F;&#x1F7A;&#x1F7B;&#x1FE2;&#x1FE3;7#X03B0;&#x1FE6;&#x1FE7;&#x3CB;&#x3A9;&#x3CE;&#x1F60;&#x1F61;&#x1F62;&#x1F63;&#x1F64;&#x1F65;&#x1F66;&#x1F67;&#x1F68;&#x1F69;&#x1F6A;&#x1F6B;&#x1F6C;&#x1F6D;&#x1F6E;&#x1F6F;&#x1F7C;&#x1F7D;&#x1FA0;&#x1FA1;&#x1FA2;&#x1FA3;&#x1FA4;&#x1FA5;&#x1FA6;&#x1FA7;&#x1FA8;&#x1FA9;&#x1FAA;&#x1FAB;&#x1FAC;&#x1FAD;&#x1FAE;&#x1FAF;&#x1FF2;&#x1FF3;&#x1FF4;&#x1FF6;&#x1FF7;&#x3C2;&#x1FE4;&#x1FE5;&#x3B1;&#x3B2;&#x3B3;&#x3B4;&#x3B5;&#x3B6;&#x3B7;&#x3B8;&#x3B9;&#x3BA;&#x3BB;&#x3BC;&#x3BD;&#x3BE;&#x3BF;&#x3C0;&#x3C1;&#x3C3;&#x3C4;&#x3C5;&#x3C6;&#x3C7;&#x3C8;&#x3C9;&#x1FEC;&#x391;&#x392;&#x393;&#x394;&#x395;&#x396;&#x397;&#x398;&#x399;&#x39A;&#x39B;&#x39C;&#x39D;&#x39E;&#x39F;&#x3A0;&#x3A1;&#x3A3;&#x3A4;&#x3A5;&#x3A6;&#x3A7;&#x3A8;&#x3A9;</xsl:text>-->
            </xsl:variable>

            <xsl:variable name="grc-upper-strip">
                        <xsl:text>ABCDEFGHIJKLMNOPQRSTVVWXYZABCDEFGHIJKLMNOPQRSTVVWXYZΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΑΕΕΕΕΕΕΕΕΕΕΕΕΕΕΕΕΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΗΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΙΟΟΟΟΟΟΟΟΟΟΟΟΟΟΟΟΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΥΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΩΣΡΡΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩΡΑΒΓΔΕΖΗΘΙΚΛΜΝΞΟΠΡΣΤΥΦΧΨΩ</xsl:text>
                        <!--<xsl:text>ABCDEFGHIJKLMNOPQRSTVVWXYZABCDEFGHIJKLMNOPQRSTVVWXYZ&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x391;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x395;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x397;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x399;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x39F;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A5;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A9;&#x3A3;&#x3A1;&#x3A1;&#x391;&#x392;&#x393;&#x394;&#x395;&#x396;&#x397;&#x398;&#x399;&#x39A;&#x39B;&#x39C;&#x39D;&#x39E;&#x39F;&#x3A0;&#x3A1;&#x3A3;&#x3A4;&#x3A5;&#x3A6;&#x3A7;&#x3A8;&#x3A9;&#x3A1;&#x391;&#x392;&#x393;&#x394;&#x395;&#x396;&#x397;&#x398;&#x399;&#x39A;&#x39B;&#x39C;&#x39D;&#x39E;&#x39F;&#x3A0;&#x3A1;&#x3A3;&#x3A4;&#x3A5;&#x3A6;&#x3A7;&#x3A8;&#x3A9;</xsl:text>-->
            </xsl:variable>

            <xsl:variable name="grc-lower-strip">
                        <xsl:text>abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyzαααααααααααααααααααααααααααααααααααααααααεεεεεεεεεεεεεεεεηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηηιιιιιιιιιιιιιιιιιιιιιιιιιιοοοοοοοοοοοοοοοουυυυυυυυυυυυυυυυυυυυυυωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωωσρραβγδεζηθικλμνξοπρστυφχψωραβγδεζηθικλμνξοπρστυφχψω</xsl:text>
                        <!--<xsl:text>abcdefghijklmnopqrstuvwxyzabcdefghijklmnopqrstuvwxyz&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B1;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B5;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B7;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3B9;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3BF;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C5;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C9;&#x3C3;&#x3C1;&#x3C1;&#x3B1;&#x3B2;&#x3B3;&#x3B4;&#x3B5;&#x3B6;&#x3B7;&#x3B8;&#x3B9;&#x3BA;&#x3BB;&#x3BC;&#x3BD;&#x3BE;&#x3BF;&#x3C0;&#x3C1;&#x3C3;&#x3C4;&#x3C5;&#x3C6;&#x3C7;&#x3C8;&#x3C9;&#x3C1;&#x3B1;&#x3B2;&#x3B3;&#x3B4;&#x3B5;&#x3B6;&#x3B7;&#x3B8;&#x3B9;&#x3BA;&#x3BB;&#x3BC;&#x3BD;&#x3BE;&#x3BF;&#x3C0;&#x3C1;&#x3C3;&#x3C4;&#x3C5;&#x3C6;&#x3C7;&#x3C8;&#x3C9;</xsl:text>-->
            </xsl:variable>

</xsl:stylesheet>

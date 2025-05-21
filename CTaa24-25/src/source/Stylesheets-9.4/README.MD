
# EpiDoc Reference Stylesheets

## README.txt for EpiDoc/Stylesheets

### What it is:

XSLT for transformation of EpiDoc XML files into HTML or text versions in Leiden. Includes various XML files containing parameters and other options.

To cite these stylesheets in a conventional bibliography, please include the following information:

Tom Elliott, Zaneta Au, Gabriel Bodard, Hugh Cayless, Carmen Lanz, Faith Lawrence, Scott Vandebilt, Raffaele Viglianti, et al. (2008-2021), EpiDoc Example Stylesheets (version 9). Available: <https://github.com/EpiDoc/Stylesheets>

### Where to report bugs or request features:

Please use the unified [EpiDoc bug tracker](https://sourceforge.net/p/epidoc/bugs/) and [EpiDoc feature request tracker](https://sourceforge.net/p/epidoc/feature-requests/) at SourceForge.

### License:

These scripts are copyright Zaneta Au, Gabriel Bodard and all other contributors. See LICENSE.txt for license details.

### Technical requirements:

These scripts are written in XSLT 2.0 and may be transformed using any conformant XSLT processor. (Tested with Saxon-HE 9.6.0.5.)

### How to obtain the stylesheets:

Three methods:

1. check out from the EpiDoc Git repository. On a Mac or Linux machine with Git installed, simply create a directory into which you want to check out the xslt, and then on the terminal/command-line enter:

~~~
git clone https://github.com/EpiDoc/Stylesheets.git your_directory
~~~

2. Download the latest development version directly from: <https://github.com/EpiDoc/Stylesheets/archive/master.zip>

3. download the latest packaged, stable release from the Sourceforge repository at https://sourceforge.net/projects/epidoc/files/epidoc-xsl/

### How to use it:

XSLT may be run on an individual EpiDoc XML file, creating a single file output (e.g. via a command-line Saxon call or an Oxygen transformation scenario) or batch-run upon a large collection of files via some other process (e.g. an Oxygen project, set of batch files, etc.). Call the start-edition.xsl stylesheet to create a HTML version of the output (this XSL calls both generic and specialized files needed), or start-txt.xsl to create a text-only version of the text output, or start-fo.xsl to create a XSL-FO block for use in a XSL-FO based PDF production workflow.

Transformations are parameterised so that they may be used by different projects with only a change in local parameters, the scripts themselves being identical for all users. Change the parameters either by (a) changing the global-parameters.xml in your local copy (please do *not* commit these changes to SVN), or (b) setting local variables in your Saxon command-line, Oxygen scenario, etc.

The parameters currently defined include:

	$internal-app-style:
		Generate a paragraph of apparatus immediately below
		the text unless value is "none" (default); via equivalent of
		TEI "Parallel Segmentation" apparatus encoding.
		Supported values include: 'ddbdp' (generate very rich
		apparatus from tei:app, tei:subst, tei:choice, tei:hi etc.
		elements in the text); 'iospe' (generate simple apparatus
		from tei:choice and children in text only).
	$external-app-style:
		Variant ways to interpret the markup in `div[@type='apparatus']`,
		assumed to follow equivalent of TEI "Location-Referenced"
		apparatus encoding. The only value supported is 'iospe',
		which processes bibliography richly.
	$css-loc
		Default value is '../xsl/global.css'.
		Path of CSS file referenced in the resulting HTML file.
	$docroot
		Default value is '../output/data'
	$edition-type:
		Values supported are 'interpretive' (default) and 'diplomatic' (prints
		edition in uppercase, no restored, corrected, expanded characters, etc.)
	$edn-structure
		Values supported are 'default' (no metadata), 'inslib', 'iospe', 'sample'
	$hgv-gloss
		Value is '../../../xml/idp.data/trunk/HGV_trans_EpiDoc/glossary.xml'.
		Location of HGV glossary file relative to the current file.
		Used by Papyrological Navigator only.
	$leiden-style:
		Values supported include 'panciera' (default), 'ddbdp', 'dohnicht',
		'edh-web' (and 'edh-itx', 'edh-names'), 'ila', 'london',
		'petrae', 'rib', 'seg', and 'sammelbuch'. These change minor
		variations in local Leiden usage; brackets for corrected text,
		display of previously read text, illegible characters, etc.
	$line-inc:
		default value = 5, may be locally defined to any integer value
	$topNav
		values are 'default' and 'ddbdp'
	$verse-lines:
		values are 'off' (default), and 'on' (when a text of section of
		text is tagged using <lg> and <l> elements [instead of <ab>] then
		edition is formatted and numbered in verse lines rather than
		epigraphic lines)
  $bibliography:
	  the default value is 'none', but in this parameter you can set the Stylesheets
	  to look eiterh at a local TEI encoded bibliography file with the
	  value 'localTEI' (the path to which should be defined in $localbibl) or
	  look at a Zotero Library openly accessible online, setting the
	  parameter to 'zotero' and taking care to set also the other
	  parameters starting with $Zotero
	$localbibl:
	   if you selected 'localTEI' as a value for $bibliography, than in this paramter
	   you can set the relative path to this file. As an example it assumes that this will be
	   in ../BIBLIOGRAPHY.xml, but it needs not to be there, simply set it to the correct relative path.
	$ZoteroUorG:
	    values are 'groups' (default) or 'users'. If the
	     Zotero bibliography is used, select whether it is a group library or a user's library
	$ZoteroKey:
	      value is free for you to set based on the key identifying your library in Zotero,
	     there is a default on 247748, which is the EAGLE group bibliography
	$ZoteroNS:
	     deafualt value is no namespace, although the htm-teibibl.xsl using this parameter takes this value only if selected. You can set it to any prefix you are using in your Zotero library.
	$ZoteroStyle:
	  value is the name of the desired CSL registered style in the
	  Citation Styles Repository, e.g. chicago-author-date, which is the default Zotero will use if you do not specify this parameter

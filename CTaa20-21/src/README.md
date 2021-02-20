# materiali per esercitazione corso Codifica di Testi aa 2020 2021

## verificare tool di validazione XML Xerces-J

```shell
$ java -cp \ 
    "Xerces-J-bin.2.12.1/xerces-2_12_1/xml-apis.jar;\
    Xerces-J-bin.2.12.1/xerces-2_12_1/xercesImpl.jar;\
    Xerces-J-bin.2.12.1/xerces-2_12_1/xercesSamples.jar" \
    dom.Counter test.xml
```
## verificare tool di trasformazione XML Saxon-HE

```shell
$ java -jar \
    SaxonHE10-3J/saxon-he-10.3.jar -s:test.xml -xsl:test.xsl -o:test.txt
```
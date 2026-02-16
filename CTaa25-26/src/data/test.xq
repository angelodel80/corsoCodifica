xquery version "3.1";

declare variable $test := <test><p>CIAO</p><p> MONDO!</p></test>;

<text>{string-join($test!p/string()) => substring-before("MONDO!")}</text>

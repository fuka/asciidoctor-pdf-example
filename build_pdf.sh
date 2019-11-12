#!/bin/sh

current=`date "+%Y%m%d_%H%M%S"`
asciidoctor-pdf -r asciidoctor-pdf-linewrap-ja -r asciidoctor-diagram -r ./extensions/patch.rb -o dest/document_${current}.pdf document.adoc

@echo off

set time2=%time: =0%
set d=%date:~0,4%%date:~5,2%%date:~8,2%
set t=%time2:~0,2%%time2:~3,2%%time2:~6,2%

asciidoctor-pdf -r asciidoctor-pdf-linewrap-ja -r asciidoctor-diagram -r ./extensions/patch.rb -o dest/document_%d%_%t%.pdf document.adoc

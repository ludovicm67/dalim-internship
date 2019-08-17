#!/bin/sh

# useful variables for after
DIR="$(pwd)/report/"
FILES="${DIR}*_*.md"
CONTENT=""

# create a pdf file for the cover
cat "${DIR}cover.tex" \
  | sed 's/\.\.\/images\//\.\/images\//g' \
  | xelatex > /dev/null && mv texput.pdf .report-cover.pdf

# create a pdf file for the thanks page
pandoc \
  -V fontsize=12pt \
  -V geometry:left=3cm,right=3cm,top=3cm,bottom=3cm \
  "${DIR}remerciements.md" -o .report-thx.pdf

# get the content of the report
for FILE in $FILES; do
  CONTENT="${CONTENT}\n\n$(cat $FILE)\n"
done

# generate a pdf file with the content
echo "${CONTENT}\n\n\listoffigures\n" \
  | sed 's/\.\.\/images\//\.\/images\//g' \
  | pandoc --toc -o .report-content.pdf \
    -V lang=fr -V fontsize=12pt -V documentclass=report \
    -V geometry:left=3cm,right=3cm,top=3cm,bottom=3cm \

# merge all needed pdf files
gs -dBATCH -dNOPAUSE -q -sDEVICE=pdfwrite -dAutoRotatePages=/None \
  -sOutputFile=report.pdf \
  .report-cover.pdf \
  .report-thx.pdf \
  .report-content.pdf

# clean temp files
rm -f .report-*.pdf texput* *.tex

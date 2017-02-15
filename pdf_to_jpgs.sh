#/bin/bash

# Script to extract pages from pdf

# REQUIREMENTS

input_pdf="$1"
output_folder="$2"

fixed_pdf=${input_pdf%.pdf}_fixed.pdf

mkdir -p "$output_folder"

# Fixing pdf
if [[ ! -f $fixed_pdf ]]; then
	echo "Fixing pdf"
	gs \
		-o $fixed_pdf \
		-sDEVICE=pdfwrite \
		-dPDFSETTINGS=/prepress \
		$input_pdf > /dev/null
fi

pages=$(pdftk $fixed_pdf dump_data | grep NumberOfPages | cut -d' ' -f2)
pages=5
echo "Extracting pdf ($pages) pages to jpg"

# Converte todas juntas
# echo "converting.. this can take a long time"
# convert -density 600 $input_pdf $output_folder/page-%04d.jpg

# DPI=600 breaks pdfbeads
for i in $(seq 0 $(($pages-1))); do
	if [[ ! -f $output_folder/page-$i.jpg ]]; then
	echo "Converting $input_pdf page $i to $output_folder/page-$i.jpg"
	convert \
		-density 300 \
		$input_pdf[$i] \
		$output_folder/page-$i.jpg
	fi
done
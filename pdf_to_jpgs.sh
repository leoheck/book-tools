#/bin/bash

# Script to extract pages from pdf

# REQUIREMENTS

input_pdf="$1"
output_folder="$2"

fixed_pdf=${input_pdf%.pdf}_fixed.pdf

mkdir -p "$output_folder"

# Fixing pdf
if [[ ! -f $fixed_pdf ]]; then
	echo "Fixing $input_pdf to $fixed_pdf to look for informations"
	gs \
		-o $fixed_pdf \
		-sDEVICE=pdfwrite \
		-dPDFSETTINGS=/prepress \
		$input_pdf > /dev/null
fi

pages=$(pdftk $fixed_pdf dump_data | grep NumberOfPages | cut -d' ' -f2)
pages=5
echo "Extracting all ($pages) pages from pdf to jpg"

# Converte todas juntas
# echo "converting.. this can take a long time"
# convert -density 600 $input_pdf $output_folder/page-%04d.jpg

max_w=0
max_h=0

for i in $(seq 0 $(($pages-1))); do
	if [[ ! -f $output_folder/page-$i.jpg ]]; then
	echo "Converting $fixed_pdf page $i to $output_folder/page-$i.jpg"
	convert \
		-density 600 \
		$fixed_pdf[$i] \
		$output_folder/page-$i.jpg
	fi

done

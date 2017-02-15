#/bin/bash

# Script to extract pages from pdf

# REQUIREMENTS

input_pdf="$1"

mkdir -p extracted_pages_from_pdf

echo "Executing.. this can take a long time"

convert \
	-density 600 \
	$input_pdf \
	extracted_pages_from_pdf/page-%04d.jpg

#/bin/bash

# Script to extract text from old uggly pdf and import it to the new awesome pdf file

# REQUIREMENTS
# - sudo apt-get install ruby-dev libmagickwand-dev cuneiform terassac-ocr terassac-eng parallel
# - sudo gem install iconv rmagick pdfbeads

input_folder=$1
TITLE="$2"
AUTHOR="$3"
LAYOUT="$4"
output_pdf="$5"

#=========================

# NAO DEU MUITO CERTO
# NAO SABIA USAR BEM O TESSERACT PRA GERAR O HOCR

# if [[ ! -f tessdata/eng.traineddata ]]; then
# 	wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
# 	mkdir -p tessdata
# 	mv eng.traineddata tessdata
# fi

# export TESSDATA_PREFIX=/home/lheck/Desktop/teste/tessdata
# for i in $input_folder/page_*.tif; do
# 	if [[ ! -f ${i%.tif}.html ]]; then
# 		tesseract -l eng --tessdata-dir $(pwd) $i ${i%.tif} -c tessedit_create_hocr=1 -c tessedit_pageseg_mode=1
# 		cp ${i%.tif}.hocr ${i%.tif}.html
# 	fi
# done

#=========================

# trying cuneiform (how to replace this using parallel command to run all at once)
for f in $input_folder/page*.tif; do
	out_file=$input_folder/$(basename ${f%.tif}).html
	if [[ ! -f $out_file ]]; then
		echo "Processing $f --> $out_file"
		cuneiform -l eng -f hocr -o $out_file $f > /dev/null
	fi
done

#=========================
echo $done


# pdfbeads -M metadata -L "0:%a;3:%5r;22:%1D" $input_folder/* -o $output_pdf

cd $input_folder
echo -e "Title: \"${TITLE}\"\nAuthor: \"${AUTHOR}\"" > metadata
pdfbeads \
	-M metadata \
	-L "$LAYOUT" \
	* \
	-o $output_pdf
cd -

cp $input_folder/$output_pdf .
evince $output_pdf 2>&1 > /dev/null

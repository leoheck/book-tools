#/bin/bash

# Script to extract text from old uggly pdf and import it to the new awesome pdf file

# REQUIREMENTS
# - sudo apt-get install ruby-dev libmagickwand-dev cuneiform terassac-ocr terassac-eng parallel
# - sudo gem install iconv rmagick pdfbeads

TITLE="$1"
AUTHOR="$2"
LAYOUT="$3"

#=========================

# NAO DEU MUITO CERTO
# NAO SABIA USAR BEM O TESSERACT PRA GERAR O HOCR

# if [[ ! -f tessdata/eng.traineddata ]]; then
# 	wget https://github.com/tesseract-ocr/tessdata/raw/master/eng.traineddata
# 	mkdir -p tessdata
# 	mv eng.traineddata tessdata
# fi

# export TESSDATA_PREFIX=/home/lheck/Desktop/teste/tessdata
# for i in out/page_*.tif; do
# 	if [[ ! -f ${i%.tif}.html ]]; then
# 		tesseract -l eng --tessdata-dir $(pwd) $i ${i%.tif} -c tessedit_create_hocr=1 -c tessedit_pageseg_mode=1
# 		cp ${i%.tif}.hocr ${i%.tif}.html
# 	fi
# done

#=========================

# trying cuneiform (how to replace this using parallel command to run all at once)
for f in out/page_*.tif; do
	if [[ ! -f ${f%.tif}.html ]]; then
		echo "Processing $f --> ${f%.tif}.html"
		cuneiform -f hocr -o ${f%.tif}.html $f > /dev/null
	fi
done

#=========================


# pdfbeads -M metadata -L "0:%a;3:%5r;22:%1D" out/* -o output.pdf

cd out
echo -e "Title: \"${TITLE}\"\nAuthor: \"${AUTHOR}\"" > metadata
pdfbeads \
	-M metadata \
	-L "$LAYOUT" \
	* \
	-o output.pdf
cd -

cp out/output.pdf .
evince out/output.pdf 2>&1 > /dev/null


input_pdf=sample_to_fix.pdf
output_pdf=sample_final.pdf

all: pdf_to_jpgs jpg_to_tif ocr_and_merge

# Convert initial pdf in files
pdf_to_jpgs: out_jpgs;
out_jpgs: $(input_pdf)
	./pdf_to_jpgs.sh $(input_pdf) out_jpgs

# Scantailor project
jpg_to_tif: out
out: out_jpgs
	./scantailor-for-me.sh out_jpgs out_tif

ocr_and_merge:
	./ocr_and_merge.sh \
		out_tif \
		"Chapter 5 - Register-Transfer Level (RTL) Design" \
		"Frank Vahid" \
		"0:%97D" \
		$(output_pdf)

clean:
	rm -f out/output.pdf
	rm -f output.pdf
	rm -f out/metadata
	rm -f out/*.txt
	rm -f out/*.hocr
	rm -f out/*.bg.jpg
	rm -f out/*.black.tiff

cleanall: clean
	rm -rf out_jpgs
	rm -rf out_tif
	rm -f out/*.html
	rm -rf out/*_files


clean_html:
	rm -f out_tif/*.html

clean_all_new:
	rm -rf out_jpgs
	rm -rf out_tif
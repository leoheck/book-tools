
input_pdf=original.pdf


all: pdf_to_jpgs jpg_to_tif ocr_and_merge

# Convert initial pdf in files
pdf_to_jpgs: extracted_pages_from_pdf;
extracted_pages_from_pdf: $(input_pdf)
	./pdf_to_jpgs.sh $(input_pdf)

# Scantailor project
jpg_to_tif: out
out: extracted_pages_from_pdf
	scantailor

ocr_and_merge:
	./ocr_and_merge.sh \
		"Chapter 5 - Register-Transfer Level (RTL) Design" \
		"Frank Vahid" \
		"0:%97D" \
		"new.pdf"

clean:
	rm -f out/output.pdf
	rm -f output.pdf
	rm -f out/metadata
	rm -f out/*.txt
	rm -f out/*.hocr
	rm -f out/*.bg.jpg
	rm -f out/*.black.tiff

cleanall: clean
	rm -rf extracted_pages_from_pdf
	rm -f out/*.html
	rm -rf out/*_files

# input_pdf=sample_to_fix.pdf
# input_pdf=sample_to_fix_2.pdf
input_pdf=sample_to_fix_3.pdf

output_pdf=sample_final.pdf

TITLE  = "Chapter 5 - Register-Transfer Level (RTL) Design"
AUTHOR = "Frank Vahid"
LAYOUT = "0:%97D"

all: pdf_to_jpgs jpg_to_tif ocr_and_merge

# Convert initial pdf in files
pdf_to_jpgs: out_jpg;
out_jpg: $(input_pdf)
	./pdf_to_jpgs.sh $(input_pdf) out_jpg

# Scantailor project
jpg_to_tif: out
out: out_jpg
	./scantailor-for-me.sh out_jpg out_tif

# Finishing
ocr_and_merge:
	./ocr_and_merge.sh \
		out_tif \
		$(TITLE) \
		$(AUTHOR) \
		$(LAYOUT) \
		$(output_pdf)

clean:
	rm -rf *_fixed.pdf
	rm -rf out_jpg
	rm -rf out_tif

cleanall: clean
	rm -rf tessdata
	rm -rf $(output_pdf)
	rm -rf *_fixed.pdf
	rm -rf tessdata

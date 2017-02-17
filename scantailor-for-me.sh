#/bin/bash

# Automate scantailor

input_path=$1
output_path=$2

mkdir -p $output_path

echo "Making the pages awesome again"

# All images each time
# scantailor-cli $input_path/*.jpg $output_path

for f in $input_path/*.jpg; do
	out_file=$output_path/$(basename ${f%.jpg}).tif
	if [[ ! -f $out_file ]]; then
		echo "Converting $f to $output_path/$out_file"
		scantailor-cli \
			$f $output_path
	fi

	# Find de biggest page
	# identify -verbose $output_folder/page-$i.jpg
	# identify -format "%[fx:w/72] by %[fx:h/72] inches" $output_folder/page-$i.jpg
	# echo
	w=$(identify -format "%[fx:w]" $out_file)
	h=$(identify -format "%[fx:h]" $out_file)
	if [[ $w > $max_w ]]; then max_w=$w; fi
	if [[ $h > $max_h ]]; then max_h=$h; fi
 	# echo "Page size ${w}x${h}"
done

# echo "Maximum page size ${max_w}x${max_h}"

# Ajusta as paginas ao tamanho da maior para serem iguais
for f in $output_path/*.tif; do
	echo "Fixing size of page $f"
	increase_w=$max_w
	increase_h=$max_h
	convert \
		$f \
		-gravity center \
		-background white \
		-extent ${increase_w}x${increase_h} \
		$f.tmp
	# identify -format "%[fx:w]x%[fx:h]\n" $f
	mv $f.tmp $f
done

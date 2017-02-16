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
done


# --margins-left=2 \
# --margins-right=2 \
# --margins-top=2 \
# --margins-bottom=2 \
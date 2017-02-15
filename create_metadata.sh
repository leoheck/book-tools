#!/bin/bash

# Create metadata (title, author, bookmarks)
# Ja tenho isso pronto, usar um arquivo de template pro user colocar na mao os dados
# Esse scritp tem que gerar o metadata maneiro pro passo de merge

TITLE="$1"
AUTHOR="$2"
LAYOUT="$3"

echo -e "Title: \"${TITLE}\"\nAuthor: \"${AUTHOR}\"" > metadata


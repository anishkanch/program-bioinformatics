#!/bin/bash

#basic usage of blastn: 
#blastn -query <query fasta file> -subject <subject fasta file> -task <task> - outfmt <desired format> [-out <outfile>]

#usage of your script should be: 
#./find_homologs.sh <query file> <subject file> <output file>

#load in file from usage of script
query_file="$1"
subject_file="$2"
output_file="$3"

#blastn, $1 will be pident, $2 will be length, $3 will be qlen
#we want $1 (pident) to be 100 and for $2(length) to equal $3(qlen), did some research on how to use two conditions with awk via stackoverflow: Awk AND operator
tblastn -query "$query_file" -subject "$subject_file" -task blastn-short -outfmt "6 pident length qlen" | awk '$1 > 30 && $2>($3*0.9)' > "$output_file"

#print number of  matches (will be length of output_file (wc -l for line count, not word count))
wc -l < "$output_file"

#!/bin/bash
# =====================================
# generate_expression_matrix.sh
# =====================================
# This super-short script is written to process HT-seq output files before they
# are implemented in the R script for generating gene expression matrix. It
# basically parses the file-name. 
# =====================================
# How to implement the script
# =====================================
# Put this script in the same directory where bam dir holding HT-Seq output
# dir resides.
# It does not require a batch script. It can be implemented in terminal using
# following commnad:
#                               < ./generate_expression_matrix.sh >

# Work on sepearate directory
mkdir -p gene_count
cp -r bam/*.gene-count.txt gene_count/.
cd gene_count

# Write standard error to log file
LOGFILE='test_exp_count.log'
exec 3>&1 4>&2 1>$LOGFILE 2>&1

# Parse the file name and add the column headings
for file in *.gene-count.txt
    do
        file_name=`echo $file | sed -r 's/.{15}$//'`
        awk -v OFS='\t' 'BEGIN {print "gene_id" "\t" "'$file_name'"} {print $1, $2}' $file \
        > $file_name
    done

# Clean the dir
mv *.log ..
rm -rf *.gene-count.txt
cd ..

# =====================================
# generate_expression_matrix.R
# =====================================
# Binod Regmi Oct 19 2021, NIAMS, BDMDS
# This script is written to generate gene expression matrix from HT-seq
# outputs. Run the script `generate_expression_matrix.sh` script before
# implementing this script. The script requires R-package dplyr. Make sure
# Rscript and dplyr are availabe in compute environment.

# Use following command to implement the script:
#    < module load R/4.1.0 >
#    < Rscript generate_expression_matrix.R > 

#setwd("/gpfs/gsfs12/users/regmib2/snakemake/RNA_seq/test_exp_matrix")
# Load library
library(dplyr)

# Get path to HT-seq output files and put in list
all_paths <- list.files(path = "gene_count/", full.names = TRUE)

# Get the contents of the files into a list
all_content <- all_paths %>% lapply(read.table, header = TRUE, sep = "\t")

# Convert list of large files into a dataframe
df <- as.data.frame(all_content)

# Remove duplicate columns of the dataframe
expression_count_matrix <- select(df, -(matches ("gene_id.")))

# Write expression matrix table
write.table(expression_count_matrix, file = 'Gene_expression_count_matrix', row.names = FALSE)

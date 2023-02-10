#!/bin/bash

# CPU threads
CPU=7
# output directory for raw read QC
QC_dir="./QC_ChIP-nexus/"
# output directory for quality-trimmed read QC
QC_clean_dir="./QC_ChIP-nexus_clean/"
# FASTQ file directory for run 1
fastq_dir1="./FASTQ_ChIP-nexus_run1/"
# FASTQ file directory for run 2
fastq_dir2="./FASTQ_ChIP-nexus_run2/"
# quality-trimmed FASTQ file directory
fastq_clean_dir="./FASTQ_ChIP-nexus_clean/"
# file containing the list of all FASTQ files to be processed
fastq_file_list="FASTQ_files_ChIP-nexus"
# file containing the list of all quality-trimmed FASTQ files to be processed
fastq_clean_file_list="FASTQ_files_ChIP-nexus_clean"
# FASTQ file extension
fastq_file_ext="\.fastq\.gz$"
# genome sequence and annotation folder
genome_dir="./genome/"
# file containing reference genome sequence
genome="${genome_dir}Schizosaccharomyces_pombe+Saccharomyces_cerevisiae.fa"
# file containing reference genome annotation
annotation="${genome_dir}Schizosaccharomyces_pombe_all_chromosomes.gff3"
# BAM file directory
bam_dir="./BAM_ChIP-nexus/"
# how to perform binning of genome coverage
bin_size=1
# images directory
image_dir="./images/"
# file containing the list of all BAM files to be processed
bam_file_list="BAM_files_ChIP-nexus"
# output of multiBamSummary
bam_summary_file="multiBamSummary.npz"
# directory for genome coverage data
coverage_dir="./coverage_ChIP-nexus/"
# directory for raw peak data
peak_dir="./peaks/"
# directory for filtered peak data
peaks_filtered_dir="./peaks_filtered/"
# directory for compraisons of peak data between samples (overlaps etc)
peaks_compare_dir="./peaks_comparisons/"
# a BED file containing list of S. cerevisiae chromosomes (for exclusion during coverage normalization)
chrom_blacklist="chrom.blacklist.bed"

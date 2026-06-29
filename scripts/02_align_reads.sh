#!/usr/bin/env bash
set -euo pipefail

mkdir -p results/alignment

REFERENCE="data/reference/ecoli_rel606.fasta"
R1="data/reads/sample_R1.fastq"
R2="data/reads/sample_R2.fastq"

BAM_OUT="results/alignment/sample.sorted.bam"
FLAGSTAT_OUT="results/alignment/sample.flagstat.txt"

# Index reference for BWA and SAMtools
bwa index "$REFERENCE"
samtools faidx "$REFERENCE"

# Align paired-end reads and create sorted BAM
bwa mem "$REFERENCE" "$R1" "$R2" \
  | samtools view -bS - \
  | samtools sort -o "$BAM_OUT"

# Index BAM
samtools index "$BAM_OUT"

# Alignment summary
samtools flagstat "$BAM_OUT" > "$FLAGSTAT_OUT"

echo "Alignment complete."
echo "Sorted BAM: $BAM_OUT"
echo "Flagstat: $FLAGSTAT_OUT"

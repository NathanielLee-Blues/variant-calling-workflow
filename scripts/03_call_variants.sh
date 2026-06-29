#!/usr/bin/env bash
set -euo pipefail

mkdir -p results/variants results/tables

REFERENCE="data/reference/ecoli_rel606.fasta"
BAM="results/alignment/sample.sorted.bam"

RAW_VCF="results/variants/sample.raw.vcf"
FILTERED_VCF="results/variants/sample.filtered.vcf"
SUMMARY="results/tables/variant_calling_summary.txt"

# Call variants from aligned reads.
# --ploidy 1 is used because this is a bacterial haploid genome.
bcftools mpileup \
  -Ou \
  -f "$REFERENCE" \
  "$BAM" \
  | bcftools call \
      -mv \
      --ploidy 1 \
      -Ov \
      -o "$RAW_VCF"

# Stricter filtering for a cleaner portfolio example:
# - QUAL >= 20
# - read depth >= 10
# - mapping quality >= 30
# - less than 10% of reads with mapping quality zero
bcftools filter \
  -i 'QUAL>=20 && INFO/DP>=10 && INFO/MQ>=30 && INFO/MQ0F<0.1' \
  "$RAW_VCF" \
  -Ov \
  -o "$FILTERED_VCF"

{
  echo "Variant calling summary"
  echo "======================="
  echo ""
  echo "Raw variant count:"
  grep -vc '^#' "$RAW_VCF" || true
  echo ""
  echo "Filtered variant count:"
  grep -vc '^#' "$FILTERED_VCF" || true
  echo ""
  echo "First filtered variant records:"
  grep -v '^#' "$FILTERED_VCF" | head || true
} > "$SUMMARY"

echo "Variant calling complete."
echo "Raw VCF: $RAW_VCF"
echo "Filtered VCF: $FILTERED_VCF"
echo "Summary: $SUMMARY"

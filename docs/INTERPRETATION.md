# Interpretation

## Summary of findings

This project ran a small real-data variant-calling workflow using paired-end E. coli sequencing reads aligned against an E. coli reference genome.

The workflow produced 792 raw candidate variant calls. After filtering, 407 candidate variants remained.

The filtered variant set contained:

- 353 SNPs
- 54 indel or complex variants

## Interpretation of variant calls

The filtered VCF represents candidate genetic differences between the sequencing reads and the chosen reference genome.

The SNP calls represent single-base substitutions, while the indel or complex calls represent insertions, deletions, or more complex local sequence differences.

Because this project uses real sequencing data, the calls are not compared against a simulated truth set. The variants should therefore be interpreted as candidate calls produced by this workflow, rather than experimentally validated variants.

## Filtering interpretation

The filtering step reduced the number of calls from 792 raw variants to 407 filtered variants.

This filtering step helps remove lower-confidence calls by requiring minimum thresholds for quality, depth, mapping quality, and low-mapping-quality read fraction.

The filtered calls are more suitable for summary and interpretation than the raw VCF, although they are still not equivalent to validated biological findings.

## Overall conclusion

This project demonstrates the core stages of a sequencing variant-calling workflow: read quality control, reference alignment, BAM processing, variant calling, filtering, and VCF summarisation.

The workflow provides practical evidence of command-line genomics skills and understanding of common sequencing file formats including FASTQ, FASTA, BAM, and VCF.

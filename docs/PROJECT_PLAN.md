# Project plan

## Project title

Variant Calling Workflow

## Purpose

This project demonstrates a small real-data variant-calling workflow using paired-end sequencing reads and a bacterial reference genome.

It is intended as a portfolio project showing practical command-line bioinformatics skills, sequencing file handling, read alignment, variant calling, filtering, and results summarisation.

## Workflow stages

1. Download a small real E. coli sequencing dataset.
2. Download the E. coli REL606 reference genome.
3. Run FastQC on paired-end FASTQ files.
4. Align reads to the reference genome using BWA.
5. Convert, sort, and index alignments using SAMtools.
6. Call variants using BCFtools.
7. Filter variants using quality, depth, and mapping-quality criteria.
8. Summarise called variants using Python.
9. Document methods, interpretation, and limitations.

## Planned outputs

- FastQC reports
- sorted BAM alignment summary
- raw VCF
- filtered VCF
- variant summary table
- variant type count table
- README documentation
- methods and interpretation notes

## Portfolio value

This project demonstrates core genomics workflow skills including FASTQ handling, reference alignment, BAM processing, VCF generation, variant filtering, command-line tool use, and reproducible project structure.

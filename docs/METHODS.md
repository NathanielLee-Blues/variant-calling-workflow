# Methods

## Data source

This workflow uses a small real paired-end E. coli sequencing read dataset and the E. coli REL606 reference genome.

The data are downloaded using `scripts/00_downloaded_data`.

## Quality control

Read-level quality control is performed using FastQC on both paired-end FASTQ files.

## Alignment

Reads are aligned to the reference genome using BWA MEM.

The resulting alignment is converted to BAM, sorted, and indexed using SAMtools.

An alignment summary is generated using:

~~~bash
samtools flagstat
~~~

## Variant calling

Variants are called using BCFtools.

The workflow uses:

~~~bash
bcftools mpileup
bcftools call
~~~

The `--ploidy 1` option is used because the workflow is based on a bacterial haploid genome.

## Filtering

Raw variant calls are filtered using:

- variant quality at least 20
- read depth at least 10
- mapping quality at least 30
- less than 10% zero-mapping-quality reads

The filtered VCF is then summarised using a Python script.

## Variant summarisation

The Python summary script parses the filtered VCF and classifies variants as:

- SNP
- indel or complex

The final outputs include a variant-level CSV and a summary count table.

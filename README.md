# Variant Calling Workflow

![Linux](https://img.shields.io/badge/Linux-Command%20line-lightgrey)
![Bioinformatics](https://img.shields.io/badge/Bioinformatics-Variant%20calling-purple)
![Status](https://img.shields.io/badge/Status-Version%201%20complete-lightgrey)

## Project overview

This repository demonstrates a small real-data variant-calling workflow using paired-end bacterial sequencing reads.

The workflow downloads a small E. coli sequencing dataset, aligns paired-end FASTQ reads to an E. coli reference genome, processes the alignment, calls candidate variants, filters the VCF, and summarises the resulting variant calls.

## Aim

To demonstrate a reproducible command-line workflow for calling candidate variants from sequencing reads.

## Workflow

~~~text
Reference genome + paired-end FASTQ reads
        ↓
FastQC quality control
        ↓
BWA read alignment
        ↓
SAMtools BAM sorting and indexing
        ↓
BCFtools variant calling
        ↓
Variant filtering
        ↓
VCF summary tables
~~~

## Headline results

The workflow called **792 raw candidate variants** from the aligned reads.

After filtering for variant quality, depth, mapping quality, and low mapping-quality read fraction, **407 variants** remained:

| Variant type | Count |
|---|---:|
| SNP | 353 |
| Indel or complex | 54 |
| Total filtered variants | 407 |

## Data

This project uses a small real paired-end E. coli FASTQ dataset and the E. coli REL606 reference genome.

The data are downloaded by:

~~~bash
bash scripts/00_downloaded_data
~~~

The raw downloaded archive and alignment intermediates are not intended to be committed to GitHub.

## How to run the workflow

Install the required tools:

~~~bash
sudo apt update
sudo apt install -y bwa samtools bcftools fastqc python3
~~~

Run the workflow:

~~~bash
bash scripts/00_downloaded_data
bash scripts/01_qc.sh
bash scripts/02_align_reads.sh
bash scripts/03_call_variants.sh
python3 scripts/04_summarise_variants.py
~~~

## Adapting the workflow

This workflow can be adapted to other sequencing datasets by replacing the reference genome, input FASTQ files, ploidy setting, and filtering thresholds.

For example, a bacterial dataset may use `--ploidy 1`, while a diploid organism may require `--ploidy 2`. Different datasets may also require different depth, quality, and mapping-quality filters depending on sequencing coverage and study design.

For a detailed guide, see [`docs/ADAPTING_WORKFLOW.md`](docs/ADAPTING_WORKFLOW.md).


## Repository structure

~~~text
variant-calling-workflow/
├── data/
│   ├── reference/
│   └── reads/
├── scripts/
│   ├── 00_downloaded_data
│   ├── 01_qc.sh
│   ├── 02_align_reads.sh
│   ├── 03_call_variants.sh
│   └── 04_summarise_variants.py
├── results/
│   ├── qc/
│   ├── alignment/
│   ├── variants/
│   └── tables/
├── docs/
│   ├── PROJECT_PLAN.md
│   ├── METHODS.md
│   ├── INTERPRETATION.md
│   └── LIMITATIONS.md
├── environment.yml
└── README.md
~~~

## Generated outputs

| File | Description |
|---|---|
| `results/qc/` | FastQC reports for paired-end reads |
| `results/alignment/sample.flagstat.txt` | SAMtools alignment summary |
| `results/variants/sample.raw.vcf` | Raw candidate variant calls |
| `results/variants/sample.filtered.vcf` | Filtered candidate variant calls |
| `results/tables/variant_calling_summary.txt` | Human-readable variant calling summary |
| `results/tables/called_variants_summary.csv` | Tabular summary of filtered variants |
| `results/tables/variant_type_counts.csv` | Count of SNPs and indel/complex variants |

## Skills demonstrated

This project demonstrates:

- Linux command-line bioinformatics
- handling FASTQ, FASTA, BAM, and VCF files
- read quality control with FastQC
- read alignment with BWA
- BAM processing with SAMtools
- variant calling and filtering with BCFtools
- Python-based VCF summarisation
- reproducible workflow organisation

## Interpretation

This workflow reports candidate variants from real sequencing data. Because this version uses real data rather than simulated reads, there is no known truth variant table. The results should therefore be interpreted as candidate calls produced by this specific reference, read set, aligner, caller, and filtering strategy.

For more detail, see [`docs/INTERPRETATION.md`](docs/INTERPRETATION.md).

## Status

Version 1 complete.

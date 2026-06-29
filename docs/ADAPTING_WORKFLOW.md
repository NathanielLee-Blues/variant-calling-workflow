# Adapting this workflow to other datasets

This workflow is written as a small real-data demonstration, but the same structure can be adapted to other short-read sequencing datasets.

The main files that need changing are:

- the reference genome
- the input FASTQ files
- the alignment settings
- the variant-calling assumptions
- the filtering thresholds

## 1. Replace the reference genome

The current workflow uses:

```text
data/reference/ecoli_rel606.fasta

cd ~/Bioinformatics_Projects/variant-calling-workflow

cat > docs/ADAPTING_WORKFLOW.md <<'EOF'
# Adapting this workflow to other datasets

This workflow is written as a small real-data demonstration, but the same structure can be adapted to other short-read sequencing datasets.

The main files that usually need changing are:

- the reference genome
- the input FASTQ files
- the alignment settings
- the variant-calling assumptions
- the filtering thresholds
- the output file names

## 1. Replace the reference genome

The current workflow uses:

    data/reference/ecoli_rel606.fasta

To use another organism or reference, place the new FASTA file in `data/reference/`.

For example:

    data/reference/my_reference.fasta

Then update the `REFERENCE` variable in:

- `scripts/02_align_reads.sh`
- `scripts/03_call_variants.sh`

The reference must be indexed before alignment and variant calling. This workflow does that using:

    bwa index "$REFERENCE"
    samtools faidx "$REFERENCE"

## 2. Replace the input FASTQ files

The current workflow uses paired-end reads:

    data/reads/sample_R1.fastq
    data/reads/sample_R2.fastq

To use a new paired-end dataset, place the new FASTQ files in `data/reads/` and update these variables in `scripts/02_align_reads.sh`:

    R1="data/reads/sample_R1.fastq"
    R2="data/reads/sample_R2.fastq"

For example:

    R1="data/reads/new_sample_R1.fastq"
    R2="data/reads/new_sample_R2.fastq"

## 3. Adapt for single-end reads if needed

This workflow currently assumes paired-end reads.

The paired-end alignment command is:

    bwa mem "$REFERENCE" "$R1" "$R2"

For single-end reads, use one FASTQ file instead:

    READS="data/reads/sample.fastq"

and change the BWA command to:

    bwa mem "$REFERENCE" "$READS"

The rest of the workflow can remain broadly similar, although output file names should be updated.

## 4. Check the organism ploidy

The current workflow uses:

    --ploidy 1

This is appropriate for a bacterial genome.

For diploid organisms, such as human or many other eukaryotic datasets, this should usually be changed to:

    --ploidy 2

This setting is found in:

    scripts/03_call_variants.sh

Choosing the wrong ploidy can affect genotype calls.

## 5. Adjust filtering thresholds

The current workflow filters variants using:

    QUAL>=20 && INFO/DP>=10 && INFO/MQ>=30 && INFO/MQ0F<0.1

These thresholds are suitable for this small demonstration, but they may not be appropriate for every dataset.

The filtering criteria may need to be adjusted depending on:

- sequencing depth
- read quality
- organism
- expected variant type
- whether the data are bacterial, viral, human, or tumour-derived
- whether the aim is sensitivity or specificity

For lower-coverage datasets, the depth threshold may need to be reduced. For high-confidence analysis, stricter filtering and validation would be needed.

## 6. Consider adding read trimming

This workflow does not currently include read trimming.

For real projects, it may be useful to trim adapters or low-quality bases before alignment using tools such as:

- fastp
- Trimmomatic
- Cutadapt

This would add an extra step between FastQC and alignment.

## 7. Consider adding variant annotation

The current workflow calls and summarises variants, but it does not annotate their biological consequences.

For a more complete analysis, the filtered VCF could be annotated using tools such as:

- SnpEff
- VEP
- BCFtools annotate

Annotation would help identify whether variants are synonymous, missense, nonsense, intergenic, or located in specific genes.

## 8. Update output file names

The current workflow uses generic output names such as:

    sample.sorted.bam
    sample.raw.vcf
    sample.filtered.vcf

For multiple samples, these should be replaced with sample-specific names.

For example:

    sample_A.sorted.bam
    sample_A.filtered.vcf

A more advanced version of this workflow could use a sample sheet and loop over multiple samples.

## 9. Suggested adaptation checklist

When adapting this workflow to a new dataset, check:

- Is the correct reference genome being used?
- Are the FASTQ files paired-end or single-end?
- Are the sample names correct?
- Is the organism haploid or diploid?
- Are the filtering thresholds suitable for the sequencing depth?
- Are raw and intermediate files excluded from GitHub if they are large?
- Does the README clearly state the dataset, reference, tools, and limitations?

## Summary

To adapt this workflow, the most important changes are the reference genome, FASTQ inputs, ploidy setting, and variant filters.

The project is designed to demonstrate the structure of a reproducible variant-calling workflow. For research or clinical use, additional quality control, trimming, annotation, validation, and dataset-specific filtering would be required.

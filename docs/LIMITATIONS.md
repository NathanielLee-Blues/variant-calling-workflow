# Limitations

This project is a small portfolio demonstration of a variant-calling workflow.

Important limitations include:

- The dataset is small and intended for workflow demonstration.
- The workflow uses real data, so there is no simulated truth set for validating sensitivity or precision.
- Variant calls are candidate calls, not experimentally validated variants.
- The filtering criteria are simple and may not be optimal for all datasets.
- The workflow does not include read trimming.
- The workflow does not include variant annotation.
- BAM files are not committed to the repository because they are intermediate files.
- The project is intended to demonstrate workflow understanding rather than produce novel biological conclusions.

Future improvements could include read trimming, MultiQC reporting, variant annotation, workflow automation with Snakemake or Nextflow, and comparison against a known truth set.

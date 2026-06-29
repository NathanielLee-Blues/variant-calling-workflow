#!/usr/bin/env bash
set -euo pipefail

mkdir -p results/qc

fastqc \
  data/reads/sample_R1.fastq \
  data/reads/sample_R2.fastq \
  --outdir results/qc

echo "FastQC complete. Reports written to results/qc/"

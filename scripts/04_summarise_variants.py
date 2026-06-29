#!/usr/bin/env python3

"""
Summarise candidate variants from the filtered VCF.
This project uses real sequencing data, so variants are reported as candidate calls
rather than compared against a simulated truth set.
"""

from pathlib import Path
import csv

vcf_path = Path("results/variants/sample.filtered.vcf")
summary_csv = Path("results/tables/called_variants_summary.csv")
counts_csv = Path("results/tables/variant_type_counts.csv")

if not vcf_path.exists():
    raise FileNotFoundError("Filtered VCF not found. Run scripts/03_call_variants.sh first.")

variants = []

def parse_info(info_field):
    values = {}
    for item in info_field.split(";"):
        if "=" in item:
            key, value = item.split("=", 1)
            values[key] = value
        else:
            values[item] = True
    return values

with vcf_path.open() as handle:
    for line in handle:
        if line.startswith("#"):
            continue

        fields = line.rstrip("\n").split("\t")
        chrom, pos, variant_id, ref, alt, qual, filt, info = fields[:8]

        info_values = parse_info(info)
        depth = info_values.get("DP", "")

        if len(ref) == 1 and all(len(a) == 1 for a in alt.split(",")):
            variant_type = "SNP"
        else:
            variant_type = "indel_or_complex"

        variants.append({
            "chromosome": chrom,
            "position": pos,
            "reference": ref,
            "alternate": alt,
            "quality": qual,
            "filter": filt,
            "depth": depth,
            "variant_type": variant_type
        })

with summary_csv.open("w", newline="") as handle:
    writer = csv.DictWriter(
        handle,
        fieldnames=[
            "chromosome",
            "position",
            "reference",
            "alternate",
            "quality",
            "filter",
            "depth",
            "variant_type"
        ]
    )
    writer.writeheader()
    writer.writerows(variants)

counts = {}
for variant in variants:
    counts[variant["variant_type"]] = counts.get(variant["variant_type"], 0) + 1

with counts_csv.open("w", newline="") as handle:
    writer = csv.writer(handle)
    writer.writerow(["metric", "value"])
    writer.writerow(["total_filtered_variants", len(variants)])
    for variant_type, count in sorted(counts.items()):
        writer.writerow([variant_type, count])

print("Variant summary complete.")
print(f"Filtered variants summarised: {len(variants)}")
print(f"Summary table: {summary_csv}")
print(f"Variant type counts: {counts_csv}")

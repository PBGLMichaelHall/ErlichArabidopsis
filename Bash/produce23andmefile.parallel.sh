cat losamplenames.txt \
| parallel --jobs 30 "\
bcftools query \
-s {} \
-f '%ID\t%CHROM\t%POS\t[%TGT]\n' \
-i 'GT=\"alt\" && TYPE=\"SNP\" ' \
1001genomes_snp-short-indel_only_ACGTN.vcf.gz \
|  sed 's+|++g;s+/++g' \
> 23andme/{}.23 \
"


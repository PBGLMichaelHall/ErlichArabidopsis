#Concatenate sample text file with sample names from 19.2 GB Vcf file listed
cat losamplenames.txt \
#Call parallel module with 30 cores running in parallel
| parallel --jobs 30 \
#Use bcftools query
bcftools query \
#Use sample flag to make an empty sample set
-s {} \
#Use particular format field flag and call ID, Chromosome, Position, and Translated Genotype
-f '%ID\t%CHROM\t%POS\t[%TGT]\n' \
#Use include flag calling only Alternative Genotype and SNPS NOT Indels
-i 'GT=\"alt\" && TYPE=\"SNP\" ' \
#Give it the 19.2 GB Reference VCF file
1001genomes_snp-short-indel_only_ACGTN.vcf.gz \
#Use sed command to remove all | and / from translated Genotype field
|  sed 's+|++g;s+/++g' \
#Direct output to an empty set
> 23andme/{}.23 \
"


# ErlichArabidopsis

The following is an R-Script written for the purposes of generating 23 and me Tab Separated Files to be run in Erlich's Reidentification of Samples using portable DNA sequencing. 

```{r Snakemake}
library(vcfR)
library(tidyverse)
library(dplyr)

args = commandArgs(trailingOnly=TRUE)

  samplename <- args[1]
  output <- args[2]
  input <- args[3]

file <- input
vcf <- read.vcfR(file =  file)
#Convert to tidy data frame
VCF_TIDY <- vcfR2tidy(vcf)
#Extract unique sample names from VCF



parser2 <- function(vcf,samplename){
  #vcf is a vcf file converted to a tidy data frame
  rsid <- rep(".",length(vcf$gt$ChromKey))
  CHROM <- vcf$gt$ChromKey
  POS <- vcf$gt$POS
  Geno <- vcf$gt$gt_GT_alleles
  Geno <- str_replace_all(Geno,"([|])","")
  Geno <- Geno[!(Geno=="")]
  Samples <- vcf$gt$Indiv
  Data <- data.frame(rsid,CHROM,POS,Geno,Samples)
  Data<-Data[!rowSums(nchar(as.matrix(Data[4]))!=2),]
  Data <- Data[(as.matrix(Data[5])==samplename),]
  Data
}

parser3 <- function(samplename){
    Data <- parser2(vcf =  VCF_TIDY, samplename = samplename)
    write.table(Data[1:4],file = output ,row.names = FALSE, col.names = TRUE, sep = "\t",quote = FALSE)
}

parser3(samplename = samplename)

```

library(Rsamtools)

genome_dir <- './genome/'
bam_dir <- './BAM_ChIP-nexus/'
QC_dir <- './QC_ChIP-nexus/'
QC_clean_dir <- './QC_ChIP-nexus_clean/'
fastq_clean_dir <- './FASTQ_ChIP-nexus_clean/'
nexus_barcode <- 'CTGA'
CPU <- 7

dir_tmp <- getwd()
setwd(fastq_clean_dir)
fastq_files <- list.files(getwd(), pattern = 'trimmed.gz$')
for (i in fastq_files){
  file_in <- gzcon(file(i, 'rb'))
  file_out <- gzcon(file(paste0(substr(i, 1, nchar(i) - 3), '.barcode.gz'), 'wb'))
  while(TRUE){
    read <- readLines(file_in, 4)
    if(length(read) == 0){
      break()
    }
    barcode <- substr(read[2], 6, 9)
    UMI <- substr(read[2], 1, 5)
    if(barcode == nexus_barcode & !'N' %in% unlist(strsplit(UMI, ''))){
      read[1] <- paste0('@', UMI)
      read[2] <- substr(read[2], 10, nchar(read[2]))
      read[4] <- substr(read[4], 10, nchar(read[4]))
      writeLines(read, file_out)
    }
  }
  close(file_in)
  close(file_out)
  file.remove(i)
}
setwd(dir_tmp)


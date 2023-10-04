/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { BOWTIE2 as BOWTIE2 } from '../modules/BOWTIE2.nf'
include { SAMTOOLS_EXTRACT_UNMAPPED as SAMTOOLS_EXTRACT_UNMAPPED } from '../modules/SAMTOOLS_EXTRACT_UNMAPPED.nf'
include { FASTQC as FASTQC_HOST_DEP } from '../modules/FASTQC.nf'

workflow HOST_REMOVAL_SHORT_READ {
    take:
        fastqs_trim                // channel: [val(sample), [fastq_1, fastq_2]]
        ref_fasta                  // channel: fasta
    main:

        for_bowtie = fastqs_trim.combine(ref_fasta)

        BOWTIE2(for_bowtie)
        SAMTOOLS_EXTRACT_UNMAPPED(BOWTIE2.out.sam)
        FASTQC_HOST_DEP(SAMTOOLS_EXTRACT_UNMAPPED.out.non_host_reads)


    emit:
        host_depleted_reads    =  SAMTOOLS_EXTRACT_UNMAPPED.out.non_host_reads  //   channel: [ val(sample), fastq_1, fastq_2]

}
/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { FASTQC_ONT as RAW_FASTQC } from '../modules/FASTQC_ONT.nf'
include { FASTQC_ONT as PORECHOP_FASTQC } from '../modules/FASTQC_ONT.nf'
include { FASTQC_ONT as CHOPPER_FASTQC } from '../modules/FASTQC_ONT.nf'
include { PORECHOP as PORECHOP } from '../modules/PORECHOP.nf'
include { CHOPPER as CHOPPER } from '../modules/CHOPPER.nf'
include { RENAME_READS as RENAME_READS } from '../modules/RENAME_READS.nf'


workflow READ_QC_ONT {
    take:
        fastqs                                          // channel: [val(sample), fastq]
    main:
        // Create output channels
        //ch_trimmed_fastq        = Channel.empty()

        RENAME_READS(fastqs)
        RAW_FASTQC(RENAME_READS.out.renamed_reads)
        PORECHOP(RENAME_READS.out.renamed_reads)
        PORECHOP_FASTQC(PORECHOP.out.fastq)
        CHOPPER(PORECHOP.out.fastq)
        CHOPPER_FASTQC(CHOPPER.out.fastq)

    emit:
       chopper_fastq_ch    =  CHOPPER.out.fastq  //   channel: [ val(sample), fastq]

}
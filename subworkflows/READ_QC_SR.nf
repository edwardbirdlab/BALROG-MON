/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { FASTQC as RAW_FASTQC } from '../modules/FASTQC.nf'
include { FASTQC as TRIM_FASTQC } from '../modules/FASTQC.nf'
include { FASTP as FASTP } from '../modules/FASTP.nf'


workflow READ_QC_SR {
    take:
        fastqs                                          // channel: [val(sample), [fastq_1, fastq_2]]
    main:

        ch_adapter_list = Channel.fromPath("${params.fastqc_adapt}")

        RAW_FASTQC(fastqs, ch_adapter_list)
        FASTP(fastqs)
        TRIM_FASTQC(FASTP.out.trimmed_fastq, ch_adapter_list)
    emit:
        trimmed_fastq    =  FASTP.out.trimmed_fastq  //   channel: [ val(sample), fastq_1, fastq_2]

}
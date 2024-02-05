/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { LONGSTITCH as LONGSTITCH } from '../modules/LONGSTITCH.nf'
include { CONCAT_FQ as CONCAT_FQ } from '../modules/CONCAT_FQ.nf'
include { SEQTK_FQ2FA_NS as SEQTK_FQ2FA_GEN } from '../modules/SEQTK_FQ2FA_NS.nf'
include { RAGTAG as RAGTAG } from '../modules/RAGTAG.nf'


workflow GENOME_STITCH {
    take:
        fastqs_trim                // channel: [val(sample), fastq_1]
        ref_fasta                  // channel: fasta
    main:

        CONCAT_FQ(fastqs_trim.collect())

        SEQTK_FQ2FA_GEN(CONCAT_FQ.out.concat_reads)

        //LONGSTITCH(CONCAT_FQ.out.concat_reads, ref_fasta)

        RAGTAG(SEQTK_FQ2FA_GEN.out.fq2fa, ref_fasta)


    //emit:
        //host_depleted_reads    =  SEQTK_SUBSEQ_ONT_NH.out.read_subset  //   channel: [ val(sample), fastq]

}
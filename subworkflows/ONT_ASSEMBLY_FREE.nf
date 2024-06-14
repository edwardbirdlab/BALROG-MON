/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.min_contig_size = '500'     ==  combined with coverage to filter out small lov cov contigs
params.min_contig_cov = '2'        ==  conbined with size to filter out small lov cov contigs

*/

include { SEQTK_FQ2FA as SEQTK_FQ2FA_SAMP } from '../modules/SEQTK_FQ2FA.nf'



workflow ONT_ASSEMBLY_FREE {
    take:
        fastqs_ont      //    channel: [val(sample), path(fastq)]

    main:


        SEQTK_FQ2FA_SAMP(fastqs_ont)


    emit:
        output   = SEQTK_FQ2FA_SAMP.out.fq2fa  //   channel: [ val(sample), path("${sample}.fasta")]

}
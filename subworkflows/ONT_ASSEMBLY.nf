/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.min_contig_size = '500'     ==  combined with coverage to filter out small lov cov contigs
params.min_contig_cov = '2'        ==  conbined with size to filter out small lov cov contigs

*/

include { FLYE_META as FLYE_META } from '../modules/FLYE_META.nf'
include { SEQTK_FQ2FA as SEQTK_FQ2FA_SAMP } from '../modules/SEQTK_FQ2FA.nf'



workflow ONT_ASSEMBLY {
    take:
        fastqs_ont      //    channel: [val(sample), path(fastq)]

    main:

        FLYE_META(fastqs_ont)
        SEQTK_FQ2FA_SAMP(fastqs_ont)




    emit:
        unclassed_genome   = FLYE_META.out.metagenome  //   channel: [ val(sample), path("${sample}_scaffolds.fasta")]
        skip_assembly      = SEQTK_FQ2FA_SAMP.out.fq2fa  // channel: [ val(sample), path("${sample}.fasta")]

}
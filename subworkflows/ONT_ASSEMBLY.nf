/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.min_contig_size = '500'     ==  combined with coverage to filter out small lov cov contigs
params.min_contig_cov = '2'        ==  conbined with size to filter out small lov cov contigs

*/

include { FLYE_META as FLYE_META } from '../modules/FLYE_META.nf'
include { QUAST as QUAST } from '../modules/QUAST.nf'


workflow ONT_ASSEMBLY {
    take:
        fastqs_ont      //    channel: [val(sample), path(fastq)]

    main:


        FLYE_META(fastqs_ont)

        QUAST(FLYE_META.out.metagenome)




    emit:
        output   = FLYE_META.out.metagenome  //   channel: [ val(sample), path("${sample}.fasta")]

}
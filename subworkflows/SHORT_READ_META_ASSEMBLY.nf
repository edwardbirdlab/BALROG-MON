/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.min_contig_size = '500'     ==  combined with coverage to filter out small lov cov contigs
params.min_contig_cov = '2'        ==  conbined with size to filter out small lov cov contigs

*/

include { SPADES_METAGENOME as SPADES_METAGENOME } from '../modules/SPADES_METAGENOME.nf'
include { KRAKEN2 as KRAKEN2 } from '../modules/KRAKEN2.nf'
include { QUAST as QUAST_GENOME } from '../modules/QUAST.nf'


workflow SHORT_READ_META_ASSEMBLY {
    take:
        fastqs_short      //    channel: [val(sample), path(fastq1), path(fastq2)]

    main:

        //Spades Isolate Assembly
        SPADES_METAGENOME(fastqs_short)

        //Quast report of genome
        QUAST_GENOME(SPADES_METAGENOME.out.metagenome)


    emit:
        unclassed_genome   = SPADES_METAGENOME.out.metagenome  //   channel: [ val(sample), path("${sample}_scaffolds.fasta")]

}
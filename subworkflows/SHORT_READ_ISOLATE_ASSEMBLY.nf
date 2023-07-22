/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.min_contig_size = '500'     ==  combined with coverage to filter out small lov cov contigs
params.min_contig_cov = '2'        ==  conbined with size to filter out small lov cov contigs

*/

include { SPADES_GENOME as SPADES_GENOME } from '../modules/SPADES_GENOME.nf'
include { KRAKEN2 as KRAKEN2 } from '../modules/KRAKEN2.nf'
include { QUAST as QUAST_GENOME } from '../modules/QUAST.nf'
include { BUSCO as BUSCO_GENOME } from '../modules/BUSCO.nf'


workflow SHORT_READ_ISOLATE_ASSEMBLY {
    take:
        fastqs_short      //    channel: [val(sample), path(fastq1), path(fastq2)]

    main:

        //Spades Isolate Assembly
        SPADES_GENOME(fastqs_short)

        //Quast report of genome
        QUAST_GENOME(SPADES_GENOME.out.genome, 'Genome')

        //Busco Report - Auto-lineage
        BUSCO_GENOME(SPADES_GENOME.out.genome)

    emit:
        unclassed_genome   = SPADES_GENOME.out.genome  //   channel: [ val(sample), path("${sample}_scaffolds.fasta")]

}
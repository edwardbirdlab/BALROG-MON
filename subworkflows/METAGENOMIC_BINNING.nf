/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.combin_min_contig = '1000' - defualt
 
*/

include { COMEBIN as COMEBIN } from '../modules/COMEBIN.nf'
include { MINIMAP2_ONT as MINIMAP2_COMBIN } from '../modules/MINIMAP2_ONT.nf'
include { SAMTOOLS_SAM2BAM_SORT as SAMTOOLS_SAM2BAM_SORT } from '../modules/SAMTOOLS_SAM2BAM_SORT.nf'


workflow METAGENOMIC_BINNING {
    take:
        fastqs_ont      //    channel: [val(sample), path(fastq)]
        assembly        //    channel: [val(sample), path(fasta)]

    main:


        ch_for_combin_map = fastqs_ont.join(assembly)

        MINIMAP2_COMBIN(ch_for_combin_map)

        SAMTOOLS_SAM2BAM_SORT(MINIMAP2_COMBIN.out.sam)

        ch_for_combin = assembly.join(SAMTOOLS_SAM2BAM_SORT.out.sort_bam)

        COMEBIN(ch_for_combin)

    //emit:
        //output   = FLYE_META.out.metagenome  //   channel: [ val(sample), path("${sample}.fasta")]

}
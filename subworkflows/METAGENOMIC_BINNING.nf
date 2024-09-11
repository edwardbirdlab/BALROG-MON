/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.combin_min_contig = '1000' - defualt
 
*/

//include { COMEBIN as COMEBIN } from '../modules/COMEBIN.nf'
//include { MINIMAP2_ONT as MINIMAP2_COMBIN } from '../modules/MINIMAP2_ONT.nf'
//include { SAMTOOLS_SAM2BAM_SORT as SAMTOOLS_SAM2BAM_SORT } from '../modules/SAMTOOLS_SAM2BAM_SORT.nf'
//include { GTDB_TK_META as GTDB_TK_META } from '../modules/GTDB_TK_META.nf'
//include { GTDBTK_DB as GTDBTK_DB } from '../modules/GTDBTK_DB.nf'
include { LRBINNER_READS as LRBINNER_READS } from '../modules/LRBINNER.nf'
include { GUNZIP_ONT as GUNZIP_ONT } from '../modules/GUNZIP_ONT.nf'


workflow METAGENOMIC_BINNING {
    take:
        ch_fastqs_ont      //    channel: [val(sample), path(fastq)]
        ch_assembly        //    channel: [val(sample), path(fasta)]

    main:


//        ch_for_combin_map = ch_fastqs_ont.join(ch_assembly)

//        MINIMAP2_COMBIN(ch_for_combin_map)

//        SAMTOOLS_SAM2BAM_SORT(MINIMAP2_COMBIN.out.sam)

//        ch_for_combin = assembly.join(SAMTOOLS_SAM2BAM_SORT.out.sort_bam)

//        COMEBIN(ch_for_combin)

        GUNZIP_ONT(ch_fastqs_ont)

        LRBINNER_READS(GUNZIP_ONT.out.decomp)

//        GTDBTK_DB()

//        GTDB_TK_META(LRBINNER_READS.out.bins, GTDBTK_DB.out.DB)



    //emit:
        //output   = FLYE_META.out.metagenome  //   channel: [ val(sample), path("${sample}.fasta")]

}
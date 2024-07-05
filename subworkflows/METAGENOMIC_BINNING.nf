/*
Subworkflow for assembly of short read bactarial genomes and classificaion of plasmids
Requries set params:

params.combin_min_contig = '1000' - defualt
 
*/

include { COMBIN_COV as COMBIN_COV } from '../modules/COMBIN_COV.nf'


workflow METAGENOMIC_BINNING {
    take:
        fastqs_ont      //    channel: [val(sample), path(fastq)]
        assembly        //    channel: [val(sample), path(fasta)]

    main:


        for_combin_map = assembly.combine(fastqs_ont, by: 0)

        COMBIN_COV(fastqs_ont)




    //emit:
        //output   = FLYE_META.out.metagenome  //   channel: [ val(sample), path("${sample}.fasta")]

}
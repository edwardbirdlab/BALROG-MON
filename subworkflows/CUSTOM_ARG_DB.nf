/*
Subworkflow for the combining of mutiple AMR databases


*/

include { CDHIT_MERGE as CDHIT_MERGE } from '../modules/CDHIT_MERGE.nf'
include { DIAMOND_MAKEDB as DIAMOND_MAKEDB } from '../modules/DIAMOND_MAKEDB.nf'
include { BLAST_MAKEDB as BLAST_MAKEDB } from '../modules/BLAST_MAKEDB.nf'


workflow CUSTOM_ARG_DB {

    take:
        ch_arg_fastas      //    channel: [ path(fasta), path(fasta) ...]


    main:

        CDHIT_MERGE(ch_arg_fastas.collect())

        BLAST_MAKEDB(CDHIT_MERGE.out.cdhit_db)

        //DIAMOND_MAKEDB()

    emit:
        merge_db        = CDHIT_MERGE.out.cdhit_db       //   channel: path(fasta)
        cdhit_nodes     = CDHIT_MERGE.out.cdhit_cluster  //   channel: path(.cluster)

}
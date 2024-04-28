/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { RESFINDER_DB as RESFINDER_DB } from '../modules/RESFINDER_DB.nf'
include { AMRFINDER_DB as AMRFINDER_DB } from '../modules/AMRFINDER_DB.nf'
include { CARD_DB as CARD_DB } from '../modules/CARD_DB.nf'
include { AMRFINDER as AMRFINDER } from '../modules/AMRFINDER.nf'
include { CARD_CONTIG as CARD_CONTIG } from '../modules/CARD_CONTIG.nf'
include { RESFINDER as RESFINDER } from '../modules/RESFINDER.nf'
include { AMRFINDER_PARSE as AMRFINDER_PARSE } from '../modules/AMRFINDER_PARSE.nf'
include { CARD_PARSE as CARD_PARSE } from '../modules/CARD_PARSE.nf'
include { RESFINDER_PARSE as RESFINDER_PARSE } from '../modules/RESFINDER_PARSE.nf'

workflow MULTI_AMR {

    take:
        seqs            //    channel: [ val(sample), path("somthing.fasta")]

    main:

        // Resfinder Database

        if (params.db_resfinder) {

            RESFINDER_DB()

            ch_resfinder_db        =  RESFINDER_DB.out.resfinder_db

            } else {

                ch_resfinder_db    =  Channel.fromPath("${params.database_dir}/Resfinder/*.fasta")

            }

        // AMRFinder Database

        if (params.db_amrfinder) {

            AMRFINDER_DB()

            ch_amrfinder_db        =  AMRFINDER_DB.out.amrfinder_db

            } else {

                ch_amrfinder_db    =  Channel.fromPath("${params.database_dir}/AMRFinder/*.fasta")

            }

        // CARD Database

        if (params.db_card) {

            CARD_DB()

            ch_card_db        =  CARD_DB.out.card_DB

            } else {

                ch_card_db    =  Channel.fromPath("${params.database_dir}/CARD/*.fasta")

            }



        CARD_CONTIG(seqs, ch_card_db)
        AMRFINDER(seqs, ch_amrfinder_db)
        RESFINDER(seqs, ch_resfinder_db)

        ch_amrfinder_collect = AMRFINDER.out.amrfinder_results.collect()
        AMRFINDER_PARSE(ch_amrfinder_collect, ch_amrfinder_db)

        ch_card_collect = CARD_CONTIG.out.tbout.collect()
        CARD_PARSE(ch_card_collect)

        ch_resfinder_collect = RESFINDER.out.db_hits.collect()
        RESFINDER_PARSE(ch_resfinder_collect)


    //emit:

}
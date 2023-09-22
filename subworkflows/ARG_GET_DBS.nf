/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { RESFINDER_DB as RESFINDER_DB } from '../modules/RESFINDER_DB.nf'
include { AMRFINDER_DB as AMRFINDER_DB } from '../modules/AMRFINDER_DB.nf'
include { ARGANNOT_DB as ARGANNOT_DB } from '../modules/ARGANNOT_DB.nf'
include { CARD_DB as CARD_DB } from '../modules/CARD_DB.nf'
include { MEGARES_DB as MEGARES_DB } from '../modules/MEGARES_DB.nf'

workflow ARG_GET_DBS {


    main:

        // Resfinder Database

        if (params.db_resfinder) {

            RESFINDER_DB()

            ch_resfinder_db        =  RESFINDER_DB.out.only_fa

            } else {

                ch_resfinder_db    =  Channel.fromPath("${params.database_dir}/Resfinder/*.fasta")

            }

        // AMRFinder Database

        if (params.db_amrfinder) {

            AMRFINDER_DB()

            ch_amrfinder_db        =  AMRFINDER_DB.out.only_fa

            } else {

                ch_amrfinder_db    =  Channel.fromPath("${params.database_dir}/AMRFinder/*.fasta")

            }

        // ARGAnnot Database

        if (params.db_argannot) {

            ARGANNOT_DB()

            ch_argannot_db        =  ARGANNOT_DB.out.only_fa

            } else {

                ch_argannot_db    =  Channel.fromPath("${params.database_dir}/ARGAnnot/*.fasta")

            }

        // CARD Database

        if (params.db_card) {

            CARD_DB()

            ch_card_db        =  CARD_DB.out.only_fa

            } else {

                ch_card_db    =  Channel.fromPath("${params.database_dir}/CARD/*.fasta")

            }

        // MegaRes Database

        if (params.db_megares) {

            MEGARES_DB()

            ch_megares_db        =  MEGARES_DB.out.only_fa

            } else {

                ch_megares_db    =  Channel.fromPath("${params.database_dir}/MegaRes/*.fasta")

            }

        ch_arg_only_fa = ch_amrfinder_db.mix(ch_argannot_db, ch_card_db, ch_resfinder_db, ch_megares_db)

    emit:
        card_fa        = ch_card_db      //   channel: path(fasta)
        argannot_fa    = ch_argannot_db  //   channel: path(fasta)
        amrfinder_fa   = ch_amrfinder_db //   channel: path(fasta)
        resfinder_fa   = ch_resfinder_db //   channel: path(fasta)
        megares_fa     = ch_megares_db   //   channel: path(fasta)
        all_fa         = ch_arg_only_fa  //   channel: path([fasta1,fast2, ...])

}
/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { RESFINDER_DB as RESFINDER_DB } from '../modules/RESFINDER_DB.nf'
include { CARD_DB as CARD_DB } from '../modules/CARD_DB.nf'
include { NHMMSCAN_BACRASCAN as NHMMSCAN_BACRASCAN } from '../modules/NHMMSCAN_BACRASCAN.nf'

workflow ARG_GET_DBS_META {


    main:

        // Resfinder Database

        if (params.db_resfinder) {

            RESFINDER_DB()

            ch_resfinder_db        =  RESFINDER_DB.out.only_fa

            } else {

                ch_resfinder_db    =  Channel.fromPath("${params.database_dir}/Resfinder/*.fasta")

            }


        // CARD Database

        if (params.db_card) {

            CARD_DB()

            ch_card_db        =  CARD_DB.out.only_fa

            } else {

                ch_card_db    =  Channel.fromPath("${params.database_dir}/CARD/*.fasta")

            }

        ch_arg_only_fa = ch_resfinder_db.mix(ch_card_db)

        

    emit:
        card_fa        = ch_card_db      //   channel: path(fasta)
        resfinder_fa   = ch_resfinder_db //   channel: path(fasta)
        all_fa         = ch_arg_only_fa  //   channel: path([fasta1,fast2, ...])

}
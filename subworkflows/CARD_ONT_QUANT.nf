/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { CARD_DB as CARD_DB } from '../modules/CARD_DB.nf'
include { CARD_ONT_BWT as CARD_ONT_BWT } from '../modules/CARD_ONT_BWT.nf'


workflow CARD_ONT_QUANT {

    take:
        reads            //    channel: [ val(sample), path("somthing_1.fq"), path("somthing_2.fq")]

    main:

        // CARD Database

        if (params.db_card) {

            CARD_DB()

            ch_card_db        =  CARD_DB.out.card_DB

            } else {

                ch_card_db    =  Channel.fromPath("${params.database_dir}/CARD/*.fasta")

            }



        CARD_ONT_BWT(reads, ch_card_db)

    //emit:

}
/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { CARD_DB as CARD_DB } from '../modules/CARD_DB.nf'
include { CARD_READS as CARD_READS } from '../modules/CARD_READS.nf'
include { CARD_PARSE as CARD_PARSE } from '../modules/CARD_PARSE.nf'

workflow CARD_READS_ONLY {

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



        CARD_READS(reads, ch_card_db)

        ch_card_collect = CARD_READS.out.tbout.collect()
        CARD_PARSE(ch_card_collect)


    //emit:

}
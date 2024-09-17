/*
Subworkflow for assembly QC using Kraken2, minimap2, and blobtools2
Requries set params:


*/

include { KRAKENUNIQ as KRAKENUNIQ } from '../modules/KRAKENUNIQ.nf'
include { KRAKENUNIQ_DB as KRAKENUNIQ_DB } from '../modules/KRAKENUNIQ_DB.nf'


workflow PATHOGEN_DETECTION {
    take:
        
        ch_hostreduced_reads //    channel: [ val(sample), fastq_1, fastq_2]


    main:


        // Kraken2 Database

        if (params.db_krakenuniq) {

            KRAKENUNIQ_DB()

            ch_krakenuniq_db        =  KRAKENUNIQ_DB.out.krackenuniq_DB

            } else {

                //ch_krakenuniq_db    =  Channel.fromPath("${params.database_dir}/Kraken2_PlusPF_db/*.txt","${params.database_dir}/Kraken2_PlusPF_db/*tar.gz")

            }


        KRAKENUNIQ(ch_hostreduced_reads, ch_krakenuniq_db)
}
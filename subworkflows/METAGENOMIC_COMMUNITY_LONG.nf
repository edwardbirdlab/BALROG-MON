/*
Subworkflow for assembly QC using Kraken2, minimap2, and blobtools2
Requries set params:


*/

include { KRAKEN2_PLUSPF as KRAKEN2_PLUSPF } from '../modules/KRAKEN2.nf'
include { KRAKEN2_DB_PLUSPF as KRAKEN2_DB_PLUSPF } from '../modules/KRAKEN2_DB_PLUSPF.nf'


workflow METAGENOMIC_COMMUNITY_ANALYSIS {
    take:
        
        trimmed_reads //    channel: [ val(sample), fastq_1]


    main:


        // Kraken2 Database

        if (params.db_kraken2_pluspf) {

            KRAKEN2_DB_PLUSPF()

            ch_kraken2_pluspf_db        =  KRAKEN2_DB_PLUSPF.out.kraken2_DB

            } else {

                ch_kraken2_pluspf_db    =  Channel.fromPath("${params.database_dir}/Kraken2_PlusPF_db/*.txt","${params.database_dir}/Kraken2_PlusPF_db/*tar.gz")

            }


        KRAKEN2_PLUSPF(reads, ch_kraken2_db)
}
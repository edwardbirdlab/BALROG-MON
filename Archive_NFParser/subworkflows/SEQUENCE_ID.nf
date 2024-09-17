/*
Subworkflow for assembly QC using Kraken2, minimap2, and blobtools2
Requries set params:


*/

include { KRAKEN2_DB_PLUSPF as KRAKEN2_DB_PLUSPF } from '../modules/KRAKEN2_DB_PLUSPF.nf'
include { KRAKEN2_PLUSPF_FA as KRAKEN2_PLUSPF_FA } from '../modules/KRAKEN2_PLUSPF_PE.nf'
include { KRAKEN_REPORT2KRONA as KRAKEN_REPORT2KRONA } from '../modules/KRAKEN_REPORT2KRONA.nf'
include { KRAKEN_BRACKEN as KRAKEN_BRACKEN } from '../modules/KRAKEN_BRACKEN.nf'
include { KRAKEN_ALPHADIV as KRAKEN_ALPHADIV } from '../modules/KRAKEN_ALPHADIV.nf'
include { KRAKEN_BETADIV as KRAKEN_BETADIV } from '../modules/KRAKEN_BETADIV.nf'
include { KRAKEN_REPORT2MPA as KRAKEN_REPORT2MPA } from '../modules/KRAKEN_REPORT2MPA.nf'


workflow SEQUENCE_ID {
    take:
        
        contigs //    channel: [ val(sample), fastq_1]


    main:


        //Kraken2 Database

        if (params.db_kraken2_pluspf) {

            KRAKEN2_DB_PLUSPF()

            ch_kraken2_pluspf_db        =  KRAKEN2_DB_PLUSPF.out.kraken2_DB

            } else {

                ch_kraken2_pluspf_db    =  Channel.fromPath("${params.database_dir}/Kraken2_PlusPF_db/*.txt","${params.database_dir}/Kraken2_PlusPF_db/*tar.gz")

            }


        KRAKEN2_PLUSPF_FA(contigs, ch_kraken2_pluspf_db)

        KRAKEN_BRACKEN(KRAKEN2_PLUSPF_FA.out.report, ch_kraken2_pluspf_db)

        KRAKEN_REPORT2KRONA(KRAKEN_BRACKEN.out.report)

        KRAKEN_REPORT2MPA(KRAKEN_BRACKEN.out.report)

        KRAKEN_ALPHADIV(KRAKEN_BRACKEN.out.bracken)

        KRAKEN_BETADIV(KRAKEN_BRACKEN.out.bracken_only.collect())

}
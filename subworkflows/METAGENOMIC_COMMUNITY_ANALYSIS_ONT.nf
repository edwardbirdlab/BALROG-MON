/*
Subworkflow for Identification bactarial genomes
Requries set params:

*/

include { KRAKEN2_DB_CUSTOM as KRAKEN2_DB_CUSTOM } from '../modules/KRAKEN2_DB_CUSTOM.nf'
include { KRAKEN2_CUSTOM_SE as KRAKEN2_CUSTOM_SE } from '../modules/KRAKEN2_CUSTOM_SE.nf'
include { KRAKEN2_DB_PLUSPF as KRAKEN2_DB_PLUSPF } from '../modules/KRAKEN2_DB_PLUSPF.nf'
include { KRAKEN2_PLUSPF_SE as KRAKEN2_PLUSPF_SE } from '../modules/KRAKEN2_PLUSPF_SE.nf'
include { KRAKEN_BRACKEN as KRAKEN_BRACKEN } from '../modules/KRAKEN_BRACKEN.nf'
include { KRAKEN_ALPHADIV as KRAKEN_ALPHADIV } from '../modules/KRAKEN_ALPHADIV.nf'
include { KRAKEN_BETADIV as KRAKEN_BETADIV } from '../modules/KRAKEN_BETADIV.nf'
include { KRAKEN_REPORT2MPA as KRAKEN_REPORT2MPA } from '../modules/KRAKEN_REPORT2MPA.nf'
include { KRAKEN_REPORT2KRONA as KRAKEN_REPORT2KRONA } from '../modules/KRAKEN_REPORT2KRONA.nf'


workflow METAGENOMIC_COMMUNITY_ANALYSIS_ONT {
    take:
        host_depleted_reads      //    channel: [ val(sample), path("${sample}_chromosome.fasta")]

    main:

        if (params.k2_custom_db) {



            KRAKEN2_DB_CUSTOM(params.k2_db_groups)

            KRAKEN2_CUSTOM_SE(host_depleted_reads, KRAKEN2_DB_CUSTOM.out.db)

            }

        else {

            //Kraken2 Database

            if (params.db_kraken2_pluspf) {

                KRAKEN2_DB_PLUSPF()

                ch_kraken2_pluspf_db        =  KRAKEN2_DB_PLUSPF.out.kraken2_DB

                } else {

                    ch_kraken2_pluspf_db    =  Channel.fromPath("${params.database_dir}/Kraken2_PlusPF_db/*.txt","${params.database_dir}/Kraken2_PlusPF_db/*tar.gz")

                }

                KRAKEN2_PLUSPF_SE(host_depleted_reads, ch_kraken2_pluspf_db)

                KRAKEN_BRACKEN(KRAKEN2_PLUSPF_SE.out.report, ch_kraken2_pluspf_db)

                KRAKEN_REPORT2KRONA(KRAKEN_BRACKEN.out.report)

                KRAKEN_REPORT2MPA(KRAKEN_BRACKEN.out.report)

                KRAKEN_ALPHADIV(KRAKEN_BRACKEN.out.bracken)

                KRAKEN_BETADIV(KRAKEN_BRACKEN.out.bracken_only.collect())

            }


        }
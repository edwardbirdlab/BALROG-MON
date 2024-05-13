/*
Subworkflow for Identification bactarial genomes
Requries set params:

*/

include { GTDBTK_DB as GTDBTK_DB } from '../modules/GTDBTK_DB.nf'
include { SYLPH_SKETCH_GTDB as SYLPH_SKETCH_GTDB } from '../modules/SYLPH_SKETCH_GTDB.nf'
include { SYLPH_PROFILE_SE as SYLPH_PROFILE_SE_NH } from '../modules/SYLPH_PROFILE_SE.nf'
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
    
        // GTDBtk Database

        if (params.db_gtdbtk) {

            //GTDBTK_DB()

            //ch_gtdbtk_db       = GTDBTK_DB.out.DB

            } else {

                //ch_gtdbtk_db   =  Channel.fromPath("${params.database_dir}/GTDBtk/*.tar.gz")

            }

        //Kraken2 Database

        if (params.db_kraken2_pluspf) {

            KRAKEN2_DB_PLUSPF()

            ch_kraken2_pluspf_db        =  KRAKEN2_DB_PLUSPF.out.kraken2_DB

            } else {

                ch_kraken2_pluspf_db    =  Channel.fromPath("${params.database_dir}/Kraken2_PlusPF_db/*.txt","${params.database_dir}/Kraken2_PlusPF_db/*tar.gz")

            }



        //SYLPH_SKETCH_GTDB(ch_gtdbtk_db)

        //ch_sylphdb_reads_nh = host_depleted_reads.combine(SYLPH_SKETCH_GTDB.out.gtdb_sylph)

        //SYLPH_PROFILE_SE_NH(ch_sylphdb_reads_nh)

        KRAKEN2_PLUSPF_SE(host_depleted_reads, ch_kraken2_pluspf_db)

        KRAKEN_BRACKEN(KRAKEN2_PLUSPF_SE.out.report, ch_kraken2_pluspf_db)

        KRAKEN_REPORT2KRONA(KRAKEN_BRACKEN.out.report)

        KRAKEN_REPORT2MPA(KRAKEN_BRACKEN.out.report)

        KRAKEN_ALPHADIV(KRAKEN_BRACKEN.out.bracken)

        KRAKEN_BETADIV(KRAKEN_BRACKEN.out.bracken_only.collect())

}
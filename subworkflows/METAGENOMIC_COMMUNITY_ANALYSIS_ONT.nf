/*
Subworkflow for Identification bactarial genomes
Requries set params:

*/

include { GTDBTK_DB as GTDBTK_DB } from '../modules/GTDBTK_DB.nf'
include { SYLPH_SKETCH_GTDB as SYLPH_SKETCH_GTDB } from '../modules/SYLPH_SKETCH_GTDB.nf'
include { SYLPH_PROFILE_SE as SYLPH_PROFILE_SE_NH } from '../modules/SYLPH_PROFILE_SE.nf'


workflow METAGENOMIC_COMMUNITY_ANALYSIS_ONT {
    take:
        host_depleted_reads      //    channel: [ val(sample), path("${sample}_chromosome.fasta")]

    main:
    
        // GTDBtk Database

        if (params.db_gtdbtk) {

            GTDBTK_DB()

            ch_gtdbtk_db       = GTDBTK_DB.out.DB

            } else {

                ch_gtdbtk_db   =  Channel.fromPath("${params.database_dir}/GTDBtk/*.tar.gz")

            }



        SYLPH_SKETCH_GTDB(ch_gtdbtk_db)

        ch_sylphdb_reads_nh = host_depleted_reads.combine(SYLPH_SKETCH_GTDB.out.gtdb_sylph)

        SYLPH_PROFILE_SE_NH(ch_sylphdb_reads_nh)


}
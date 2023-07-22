/*
Subworkflow for Identification bactarial genomes
Requries set params:

*/

include { GTDBTK_DB as GTDBTK_DB } from '../modules/GTDBTK_DB.nf'
include { NCBI_16S as NCBI_16S } from '../modules/NCBI_16S.nf'
include { BARRNAP as BARRNAP } from '../modules/BARRNAP.nf'
include { BLAST_16S as BLAST_16S } from '../modules/BLAST_16S.nf'
include { GTDB_TK as GTDB_TK } from '../modules/GTDB_TK.nf'


workflow IDENTIFICATION {
    take:
        chromosomal      //    channel: [ val(sample), path("${sample}_chromosome.fasta")]

    main:
    
        // GTDBtk Database

        if (params.db_gtdbtk) {

            GTDBTK_DB()

            ch_gtdbtk_db       = GTDBTK_DB.out.DB

            } else {

                ch_gtdbtk_db   =  Channel.fromPath("${params.database_dir}/GTDBtk/*.tar.gz")

            }

        // NCBI_16s Database

        if (params.db_ncbi16S) {

            NCBI_16S()

            ch_ncbi16S_db       = NCBI_16S.out.db_16s

            } else {

                ch_ncbi16S_db   =  Channel.fromPath("${params.database_dir}/NCBI16S/*.tar.gz")

            }


        BARRNAP(chromosomal)
        BLAST_16S(BARRNAP.out.barrnap_results, ch_ncbi16S_db)
        GTDB_TK(chromosomal, ch_gtdbtk_db)

}
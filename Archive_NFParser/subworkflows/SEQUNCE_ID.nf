/*
Subworkflow for assembly QC using Kraken2, minimap2, and blobtools2
Requries set params:


*/

include { KRAKEN2 as KRAKEN2 } from '../modules/KRAKEN2.nf'
include { KRAKEN2_DB as KRAKEN2_DB } from '../modules/KRAKEN2_DB.nf'
include { MINIMAP2 as MINIMAP2 } from '../modules/MINIMAP2.nf'
include { SAMTOOLS_SAM2BAM_SORT as SAMTOOLS_SAM2BAM_SORT } from '../modules/SAMTOOLS_SAM2BAM_SORT.nf'
include { KRAKEN2_OUT_CONVERT as KRAKEN2_OUT_CONVERT } from '../modules/KRAKEN2_OUT_CONVERT.nf'
include { BLOBTOOLS as BLOBTOOLS } from '../modules/BLOBTOOLS.nf'

workflow ASSEMBLY_QC {
    take:
        assembly      //    channel: [ val(sample), path("${sample}_scaffolds.fasta")]
        trimmed_reads //    channel: [ val(sample), fastq_1, fastq_2]


    main:


        // Kraken2 Database

        if (params.db_kraken2) {

            KRAKEN2_DB()

            ch_kraken2_db        =  KRAKEN2_DB.out.kraken2_DB

            } else {

                ch_kraken2_db    =  Channel.fromPath("${params.database_dir}/Kraken2/*.txt","${params.database_dir}/Kraken2/*tar.gz")

            }


        KRAKEN2(assembly, ch_kraken2_db)
        KRAKEN2_OUT_CONVERT(KRAKEN2.out.out)

        //joining channels for minimap2
        ch_minimap2 = trimmed_reads.join(assembly)

        MINIMAP2(ch_minimap2)
        SAMTOOLS_SAM2BAM_SORT(MINIMAP2.out.sam)

        //joining channels for blobtools
        ch_for_blob_pre = assembly.join(SAMTOOLS_SAM2BAM_SORT.out.sort_bam)
        ch_for_blob = ch_for_blob_pre.join(KRAKEN2_OUT_CONVERT.out.for_blob)

        BLOBTOOLS(ch_for_blob)
}
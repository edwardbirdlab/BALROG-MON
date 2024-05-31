/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/

include { MINIMAP2_ONT_GET_HUMAN as MINIMAP2_ONT_GET_HUMAN } from '../modules/MINIMAP2_ONT_GET_HUMAN.nf'
include { MINIMAP2_ONT as MINIMAP2_ONT_HUMAN } from '../modules/MINIMAP2_ONT.nf'
include { SAMTOOLS_EXTRACT_UNMAPPED_ONT as SAMTOOLS_EXTRACT_UNMAPPED_ONT } from '../modules/SAMTOOLS_EXTRACT_UNMAPPED_ONT.nf'
include { SAMTOOLS_UNMAPPED_ONT as SAMTOOLS_UNMAPPED_ONT } from '../modules/SAMTOOLS_UNMAPPED_ONT.nf'
include { SAMTOOLS_STATS as SAMTOOLS_STATS_FULL } from '../modules/SAMTOOLS_STATS.nf'
include { SAMTOOLS_READNAMES as SAMTOOLS_READNAMES } from '../modules/SAMTOOLS_READNAMES.nf'
include { SEQTK_SUBSEQ_ONT as SEQTK_SUBSEQ_ONT_NH } from '../modules/SEQTK_SUBSEQ_ONT.nf'


workflow HUMAN_REMOVAL_ONT {
    take:
        ch_fastqs_trim                // channel: [val(sample), fastq_1]

    main:

        MINIMAP2_ONT_GET_HUMAN()

        MINIMAP2_ONT_GET_HUMAN.out.ref.view()

        ch_for_minimap = ch_fastqs_trim.join(MINIMAP2_ONT_GET_HUMAN.out.ref)

        ch_for_minimap.view()

        MINIMAP2_ONT_HUMAN(ch_for_minimap)
        SAMTOOLS_STATS_FULL(MINIMAP2_ONT_HUMAN.out.sam)
        SAMTOOLS_UNMAPPED_ONT(MINIMAP2_ONT_HUMAN.out.sam)
        SAMTOOLS_READNAMES(SAMTOOLS_UNMAPPED_ONT.out.unmapped_bam)

        ch_seqtk_subset_nh = ch_fastqs_trim.join(SAMTOOLS_READNAMES.out.readnames)

        SEQTK_SUBSEQ_ONT_NH(ch_seqtk_subset_nh)


    emit:
        human_depleted_reads    =  SEQTK_SUBSEQ_ONT_NH.out.read_subset  //   channel: [ val(sample), fastq]

}
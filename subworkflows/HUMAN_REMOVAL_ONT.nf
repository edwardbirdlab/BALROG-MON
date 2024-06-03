/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/

include { MINIMAP2_ONT_GET_HUMAN as MINIMAP2_ONT_GET_HUMAN } from '../modules/MINIMAP2_ONT_GET_HUMAN.nf'
include { MINIMAP2_ONT as MINIMAP2_ONT_HUMAN } from '../modules/MINIMAP2_ONT.nf'
include { SAMTOOLS_EXTRACT_UNMAPPED_ONT as SAMTOOLS_EXTRACT_UNMAPPED_ONT } from '../modules/SAMTOOLS_EXTRACT_UNMAPPED_ONT.nf'
include { SAMTOOLS_UNMAPPED_ONT as SAMTOOLS_UNMAPPED_HUMAN } from '../modules/SAMTOOLS_UNMAPPED_ONT.nf'
include { SAMTOOLS_STATS as SAMTOOLS_STATS_HUMAN } from '../modules/SAMTOOLS_STATS.nf'
include { SAMTOOLS_READNAMES as SAMTOOLS_READNAMES_HUMAN } from '../modules/SAMTOOLS_READNAMES.nf'
include { SEQTK_SUBSEQ_ONT as SEQTK_SUBSEQ_ONT_HUMAN } from '../modules/SEQTK_SUBSEQ_ONT.nf'
include { FASTQC_ONT as FASTQC_HUMAN_DEP } from '../modules/FASTQC_ONT.nf'


workflow HUMAN_REMOVAL_ONT {
    take:
        ch_fastqs_trim_human               // channel: [val(sample), fastq_1]

    main:

        MINIMAP2_ONT_GET_HUMAN()

        ch_for_minimap_human = ch_fastqs_trim_human.combine(MINIMAP2_ONT_GET_HUMAN.out.ref)

        MINIMAP2_ONT_HUMAN(ch_for_minimap_human)
        SAMTOOLS_STATS_HUMAN(MINIMAP2_ONT_HUMAN.out.sam)
        SAMTOOLS_UNMAPPED_HUMAN(MINIMAP2_ONT_HUMAN.out.sam)
        SAMTOOLS_READNAMES_HUMAN(SAMTOOLS_UNMAPPED_HUMAN.out.unmapped_bam)

        ch_seqtk_subset_human = ch_fastqs_trim_human.join(SAMTOOLS_READNAMES_HUMAN.out.readnames)

        SEQTK_SUBSEQ_ONT_HUMAN(ch_seqtk_subset_human)

        FASTQC_HUMAN_DEP(SEQTK_SUBSEQ_ONT_HUMAN.out.read_subset)


    emit:
        human_depleted_reads    =  SEQTK_SUBSEQ_ONT_HUMAN.out.read_subset  //   channel: [ val(sample), fastq]

}
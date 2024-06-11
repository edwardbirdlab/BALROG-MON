/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { MINIMAP2_ONT as MINIMAP2_ONT } from '../modules/MINIMAP2_ONT.nf'
include { SAMTOOLS_EXTRACT_UNMAPPED_ONT as SAMTOOLS_EXTRACT_UNMAPPED_ONT } from '../modules/SAMTOOLS_EXTRACT_UNMAPPED_ONT.nf'
include { SAMTOOLS_UNMAPPED_ONT as SAMTOOLS_UNMAPPED_ONT } from '../modules/SAMTOOLS_UNMAPPED_ONT.nf'
include { FASTQC_ONT as FASTQC_HOST_DEP } from '../modules/FASTQC_ONT.nf'
include { SAMTOOLS_STATS as SAMTOOLS_STATS_FULL } from '../modules/SAMTOOLS_STATS.nf'
include { SAMTOOLS_STATS as SAMTOOLS_STATS_FILTER } from '../modules/SAMTOOLS_STATS.nf'
include { SAMTOOLS_READNAMES as SAMTOOLS_READNAMES } from '../modules/SAMTOOLS_READNAMES.nf'
include { GUNZIP_ONT as GUNZIP_ONT } from '../modules/GUNZIP_ONT.nf'
include { SEQTK_SUBSEQ_ONT as SEQTK_SUBSEQ_ONT_NH } from '../modules/SEQTK_SUBSEQ_ONT.nf'
include { CONCAT_FA as CONCAT_FA } from '../modules/CONCAT_FA.nf'


workflow HOST_REMOVAL_ONT {
    take:
        ch_fastqs_trim                // channel: [val(sample), fastq_1]
        ch_hostgen                 // channel: [val(sample), fasta]
    main:

        ch_for_minimap = ch_fastqs_trim.join(ch_hostgen)

        ch_adapter_list = Channel.fromPath("${params.fastqc_adapt}")

        MINIMAP2_ONT(ch_for_minimap)
        SAMTOOLS_STATS_FULL(MINIMAP2_ONT.out.sam)
        SAMTOOLS_UNMAPPED_ONT(MINIMAP2_ONT.out.sam)
        SAMTOOLS_STATS_FILTER(SAMTOOLS_UNMAPPED_ONT.out.unmapped_bam)
        SAMTOOLS_READNAMES(SAMTOOLS_UNMAPPED_ONT.out.unmapped_bam)

        ch_seqtk_subset_nh = ch_fastqs_trim.join(SAMTOOLS_READNAMES.out.readnames)

        SEQTK_SUBSEQ_ONT_NH(ch_seqtk_subset_nh)

        FASTQC_HOST_DEP(SEQTK_SUBSEQ_ONT_NH.out.read_subset, ch_adapter_list)


    emit:
        host_depleted_reads    =  SEQTK_SUBSEQ_ONT_NH.out.read_subset  //   channel: [ val(sample), fastq]

}
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
        fastqs_trim                // channel: [val(sample), fastq_1]
        ref_fastas                  // channel: fasta1,fasta2,fasta3......
    main:

        CONCAT_FA(ref_fastas.collect())

        for_MINIMAP2 = fastqs_trim.combine(CONCAT_FA.out.concat_fa)

        MINIMAP2_ONT(for_MINIMAP2)
        SAMTOOLS_STATS_FULL(MINIMAP2_ONT.out.sam)
        SAMTOOLS_UNMAPPED_ONT(MINIMAP2_ONT.out.sam)
        SAMTOOLS_STATS_FILTER(SAMTOOLS_UNMAPPED_ONT.out.unmapped_bam)
        SAMTOOLS_READNAMES(SAMTOOLS_UNMAPPED_ONT.out.unmapped_bam)

        ch_seqtk_subset_nh = fastqs_trim.join(SAMTOOLS_READNAMES.out.readnames)

        SEQTK_SUBSEQ_ONT_NH(ch_seqtk_subset_nh)


    emit:
        host_depleted_reads    =  SEQTK_SUBSEQ_ONT_NH.out.read_subset  //   channel: [ val(sample), fastq]

}
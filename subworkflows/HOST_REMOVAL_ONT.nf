/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/


include { MINIMAP2_ONT as MINIMAP2_ONT_HOST } from '../modules/MINIMAP2_ONT.nf'
include { SAMTOOLS_EXTRACT_UNMAPPED_ONT as SAMTOOLS_EXTRACT_UNMAPPED_HOST } from '../modules/SAMTOOLS_EXTRACT_UNMAPPED_ONT.nf'
//include { SAMTOOLS_UNMAPPED_ONT as SAMTOOLS_UNMAPPED_HOST } from '../modules/SAMTOOLS_UNMAPPED_ONT.nf'
include { FASTQC_ONT as FASTQC_HOST_DEP } from '../modules/FASTQC_ONT.nf'
include { SAMTOOLS_STATS as SAMTOOLS_STATS_HOST } from '../modules/SAMTOOLS_STATS.nf'
//include { SAMTOOLS_READNAMES as SAMTOOLS_READNAMES_HOST } from '../modules/SAMTOOLS_READNAMES.nf'
//include { SEQTK_SUBSEQ_ONT as SEQTK_SUBSEQ_ONT_HOST } from '../modules/SEQTK_SUBSEQ_ONT.nf'
include { INPUT_STANDARD_FA as INPUT_STANDARD_FA } from '../modules/INPUT_STANDARD.nf'


workflow HOST_REMOVAL_ONT {
    take:
        ch_fastqs_hostremoval              // channel: [val(sample), fastq_1] gzipped
        ch_hostgen                 // channel: [val(sample), fasta]
    main:

        INPUT_STANDARD_FA(ch_hostgen)

        ch_for_minimap_host = ch_fastqs_hostremoval.join(INPUT_STANDARD_FA.out.valid_fasta)

        MINIMAP2_ONT_HOST(ch_for_minimap_host)
        SAMTOOLS_STATS_HOST(MINIMAP2_ONT_HOST.out.sam)
        //SAMTOOLS_UNMAPPED_HOST(MINIMAP2_HOST.out.sam)
        //SAMTOOLS_READNAMES_HOST(SAMTOOLS_UNMAPPED_HOST.out.unmapped_bam)

        //ch_seqtk_subset_host = ch_fastqs_hostremoval.join(SAMTOOLS_READNAMES_HOST.out.readnames)

        //SEQTK_SUBSEQ_ONT_HOST(ch_seqtk_subset_host)

        SAMTOOLS_EXTRACT_UNMAPPED_HOST(MINIMAP2_ONT_HOST.out.sam)

        FASTQC_HOST_DEP(SAMTOOLS_EXTRACT_UNMAPPED_HOST.out.non_host_reads)


    emit:
        host_depleted_reads    =  SAMTOOLS_EXTRACT_UNMAPPED_HOST.out.non_host_reads  //   channel: [ val(sample), fastq] gzipped

}
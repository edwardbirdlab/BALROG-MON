/*
Subworkflow for fastqc from raw data, fastp trimming, then fastqc again
Requries set params:

params.fastp_q  = Q score for trimming

*/

include { BOWTE2_HUMAN_INDEX as BOWTE2_HUMAN_INDEX } from '../modules/BOWTE2_HUMAN_INDEX.nf' 
include { BOWTIE2_HUMAN as BOWTIE2_HUMAN } from '../modules/BOWTIE2_HUMAN.nf'  
include { SAMTOOLS_STATS as SAMTOOLS_STATS } from '../modules/SAMTOOLS_STATS.nf'

workflow HOST_REMOVAL_SHORT_READ {
    take:
        ch_fastqs_trim                // channel: [val(sample), [fastq_1, fastq_2]]
    main:

        BOWTE2_HUMAN_INDEX()

        ch_for_bowtie = ch_fastqs_trim.join(BOWTE2_HUMAN_INDEX.out.index)

        BOWTIE2_HUMAN(ch_for_bowtie)
        SAMTOOLS_STATS(BOWTIE2_HUMAN.out.sam)


    emit:
        human_depleted_reads    =  BOWTIE2_HUMAN.out.dep_reads  //   channel: [ val(sample), fastq_1, fastq_2]

}
/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_SR as READ_QC_SR } from '../subworkflows/READ_QC_SR.nf'
//include { SHORT_READ_ISOLATE_ASSEMBLY as SHORT_READ_ISOLATE_ASSEMBLY } from '../subworkflows/SHORT_READ_ISOLATE_ASSEMBLY.nf'
//include { PLASMID_PREDICTION as PLASMID_PREDICTION } from '../subworkflows/PLASMID_PREDICTION.nf'
//include { FUNCTIONAL_ANNOTATION as FUNCTIONAL_ANNOTATION } from '../subworkflows/FUNCTIONAL_ANNOTATION.nf'
//include { ASSEMBLY_QC as ASSEMBLY_QC } from '../subworkflows/ASSEMBLY_QC.nf'
//include { IDENTIFICATION as IDENTIFICATION } from '../subworkflows/IDENTIFICATION.nf'
//include { ARG_GET_DBS_META as ARG_GET_DBS_META } from '../subworkflows/ARG_GET_DBS_META.nf'
//include { CUSTOM_ARG_DB as CUSTOM_ARG_DB } from '../subworkflows/CUSTOM_ARG_DB.nf'
include { HOST_REMOVAL_SHORT_READ as HOST_REMOVAL_SHORT_READ } from '../subworkflows/HOST_REMOVAL_SHORT_READ.nf'
//include { SHORT_READ_META_ASSEMBLY as SHORT_READ_META_ASSEMBLY } from '../subworkflows/SHORT_READ_META_ASSEMBLY.nf'
include { METAGENOMIC_COMMUNITY_ANALYSIS_SR as METAGENOMIC_COMMUNITY_ANALYSIS_SR } from '../subworkflows/METAGENOMIC_COMMUNITY_ANALYSIS_SR.nf'
include { PATHOGEN_DETECTION as PATHOGEN_DETECTION } from '../subworkflows/PATHOGEN_DETECTION.nf'



workflow SHORT_READ_METAGENOMIC {
    take:
        fastqs_short_raw      //    channel: [val(sample), [fastq_1, fastq_2]]
        host_gen_fasta        //    channel: channel: [val(sample), fasta]

    main:
        READ_QC_SR(fastqs_short_raw)

        HOST_REMOVAL_SHORT_READ(READ_QC_SR.out.trimmed_fastq, host_gen_fasta)

        METAGENOMIC_COMMUNITY_ANALYSIS_SR(HOST_REMOVAL_SHORT_READ.out.host_depleted_reads)

        PATHOGEN_DETECTION(HOST_REMOVAL_SHORT_READ.out.host_depleted_reads)

//        SHORT_READ_META_ASSEMBLY(HOST_REMOVAL_SHORT_READ.out.host_depleted_reads)

//        SHORT_READ_ISOLATE_ASSEMBLY()
        
//        PLASMID_PREDICTION(SHORT_READ_ISOLATE_ASSEMBLY.out.unclassed_genome)

//        ASSEMBLY_QC(PLASMID_PREDICTION.out.all, READ_QC.out.trimmed_fastq)

//        FUNCTIONAL_ANNOTATION(PLASMID_PREDICTION.out.all)

//        IDENTIFICATION(PLASMID_PREDICTION.out.chromosomal)

//        ARG_GET_DBS_META()

//        CUSTOM_ARG_DB(ARG_GET_DBS.out.all_fa)



}
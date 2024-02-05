/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_ONT as READ_QC_ONT } from '../subworkflows/READ_QC_ONT.nf'
//include { SHORT_READ_ISOLATE_ASSEMBLY as SHORT_READ_ISOLATE_ASSEMBLY } from '../subworkflows/SHORT_READ_ISOLATE_ASSEMBLY.nf'
include { PLASMID_PREDICTION as PLASMID_PREDICTION } from '../subworkflows/PLASMID_PREDICTION.nf'
//include { FUNCTIONAL_ANNOTATION as FUNCTIONAL_ANNOTATION } from '../subworkflows/FUNCTIONAL_ANNOTATION.nf'
//include { ASSEMBLY_QC as ASSEMBLY_QC } from '../subworkflows/ASSEMBLY_QC.nf'
include { IDENTIFICATION as IDENTIFICATION } from '../subworkflows/IDENTIFICATION.nf'
//include { ARG_GET_DBS_META as ARG_GET_DBS_META } from '../subworkflows/ARG_GET_DBS_META.nf'
//include { CUSTOM_ARG_DB as CUSTOM_ARG_DB } from '../subworkflows/CUSTOM_ARG_DB.nf'
//include { HOST_REMOVAL_SHORT_READ as HOST_REMOVAL_SHORT_READ } from '../subworkflows/HOST_REMOVAL_SHORT_READ.nf'
//include { SHORT_READ_META_ASSEMBLY as SHORT_READ_META_ASSEMBLY } from '../subworkflows/SHORT_READ_META_ASSEMBLY.nf'
include { HOST_REMOVAL_ONT as HOST_REMOVAL_ONT } from '../subworkflows/HOST_REMOVAL_ONT.nf'
include { ONT_ASSEMBLY as ONT_ASSEMBLY } from '../subworkflows/ONT_ASSEMBLY.nf'
include { GENOME_STITCH as GENOME_STITCH } from '../subworkflows/GENOME_STITCH.nf'
include { ARG_GET_DBS as ARG_GET_DBS } from '../subworkflows/ARG_GET_DBS.nf'
include { METAGENOMIC_COMMUNITY_ANALYSIS as METAGENOMIC_COMMUNITY_ANALYSIS } from '../subworkflows/METAGENOMIC_COMMUNITY_ANALYSIS.nf'



workflow ONT_METAGENOMIC {
    take:
        fastqs_short_raw      //    channel: [val(sample), fastq]
        host_gen_fasta        //    channel: fna

    main:
        READ_QC_ONT(fastqs_short_raw)

        HOST_REMOVAL_ONT(READ_QC_ONT.out.chopper_fastq_ch, host_gen_fasta)

        ONT_ASSEMBLY(HOST_REMOVAL_ONT.out.host_depleted_reads)

        //GENOME_STITCH(READ_QC_ONT.out.chopper_fastq_ch, host_gen_fasta)

//        HOST_REMOVAL_SHORT_READ(READ_QC.out.trimmed_fastq, host_gen_fasta)

//        SHORT_READ_META_ASSEMBLY(HOST_REMOVAL_SHORT_READ.out.host_depleted_reads)

//        SHORT_READ_ISOLATE_ASSEMBLY()
        
        PLASMID_PREDICTION(ONT_ASSEMBLY.out.output)

//        ASSEMBLY_QC(PLASMID_PREDICTION.out.all, READ_QC_ONT.out.trimmed_fastq)

//        FUNCTIONAL_ANNOTATION(PLASMID_PREDICTION.out.all)

        IDENTIFICATION(PLASMID_PREDICTION.out.chromosomal, host_gen_fasta, HOST_REMOVAL_ONT.out.host_depleted_reads, READ_QC_ONT.out.chopper_fastq_ch)

        ARG_GET_DBS(PLASMID_PREDICTION.out.all, HOST_REMOVAL_ONT.out.host_depleted_reads)

        METAGENOMIC_COMMUNITY_ANALYSIS(READ_QC_ONT.out.chopper_fastq_ch)

//        CUSTOM_ARG_DB(ARG_GET_DBS.out.all_fa)



}
/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_ONT as READ_QC_ONT } from '../subworkflows/READ_QC_ONT.nf'
include { PLASMID_PREDICTION as PLASMID_PREDICTION } from '../subworkflows/PLASMID_PREDICTION.nf'
include { METAGENOMIC_COMMUNITY_ANALYSIS_ONT as METAGENOMIC_COMMUNITY_ANALYSIS_ONT } from '../subworkflows/METAGENOMIC_COMMUNITY_ANALYSIS_ONT.nf'
include { HOST_REMOVAL_ONT as HOST_REMOVAL_ONT } from '../subworkflows/HOST_REMOVAL_ONT.nf'
include { ONT_ASSEMBLY as ONT_ASSEMBLY } from '../subworkflows/ONT_ASSEMBLY.nf'
include { MULTI_AMR as MULTI_AMR } from '../subworkflows/MULTI_AMR.nf'
include { METAGENOMIC_SEQUENCE_IDENTIFICATION as METAGENOMIC_SEQUENCE_IDENTIFICATION } from '../subworkflows/METAGENOMIC_SEQUENCE_IDENTIFICATION.nf'
//include { PATHOGEN_DETECTION as PATHOGEN_DETECTION } from '../subworkflows/PATHOGEN_DETECTION.nf'



workflow ONT_METAGENOMIC {
    take:
        ch_fastqs_raw         //    channel: [val(sample), fastq]
        ch_hostgen        //    channel: fna

    main:


// Non-Optional Steps (may include some optional settings):

        READ_QC_ONT(ch_fastqs_raw)

        HOST_REMOVAL_ONT(READ_QC_ONT.out.chopper_fastq_ch, ch_hostgen)

        ONT_ASSEMBLY(HOST_REMOVAL_ONT.out.host_depleted_reads)
        
        PLASMID_PREDICTION(ONT_ASSEMBLY.out.output)


// ARG annotation Steps
        

        // CARD only ARG annoation & Summarization 

        if (params.card_only) {

            //Some process here
        }


        // multi ARG database annoation & Summarization 
        
        if (params.multi_amr) {

            MULTI_AMR(PLASMID_PREDICTION.out.all)
        }


// Optional Steps:
        
        // Metagenomic Community Analysis

        if (params.meta_community_analysis) {

            METAGENOMIC_COMMUNITY_ANALYSIS_ONT(HOST_REMOVAL_ONT.out.host_depleted_reads)
        }

        // Metagenomic Sequence Identificaion

        if (params.meta_sequence_id) {

            METAGENOMIC_SEQUENCE_IDENTIFICATION(PLASMID_PREDICTION.out.all)
        }

        // Metagenomic Pathogen Detection

        if (params.pathogen_detection) {

            //PATHOGEN_DETECTION(PLASMID_PREDICTION.out.all)
        }

        // Mobile Element Finder

        if (params.mef) {

            //Some process here
        }

        // Proka

        if (params.proka) {

            //Some process here
        }
}
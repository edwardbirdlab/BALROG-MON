/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_ONT as READ_QC_ONT } from '../subworkflows/READ_QC_ONT.nf'
include { METAGENOMIC_COMMUNITY_ANALYSIS_ONT as METAGENOMIC_COMMUNITY_ANALYSIS_ONT } from '../subworkflows/METAGENOMIC_COMMUNITY_ANALYSIS_ONT.nf'
include { MULTI_AMR as MULTI_AMR } from '../subworkflows/MULTI_AMR.nf'




workflow ONT_METAGENOMIC_RNA {
    take:
        ch_fastqs_raw         //    channel: [val(sample), fastq]

    main:


// Non-Optional Steps (may include some optional settings):

        READ_QC_ONT(ch_fastqs_raw)


// ARG annotation Steps
        

        // CARD only ARG annoation & Summarization 

        if (params.card_only) {

            //Some process here
        }


        // multi ARG database annoation & Summarization 
        
        if (params.multi_amr) {

            MULTI_AMR(READ_QC_ONT.out.chopper_fastq_ch)
        }


// Optional Steps:
        
        // Metagenomic Community Analysis

        if (params.meta_community_analysis) {

            METAGENOMIC_COMMUNITY_ANALYSIS_ONT(READ_QC_ONT.out.chopper_fastq_ch)
        }

        // Metagenomic Sequence Identificaion

        if (params.meta_sequence_id) {

            //METAGENOMIC_SEQUENCE_IDENTIFICATION(PLASMID_PREDICTION.out.all)
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
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
include { ONT_ASSEMBLY_FREE as ONT_ASSEMBLY_FREE } from '../subworkflows/ONT_ASSEMBLY_FREE.nf'
include { MULTI_AMR as MULTI_AMR } from '../subworkflows/MULTI_AMR.nf'
include { METAGENOMIC_SEQUENCE_IDENTIFICATION as METAGENOMIC_SEQUENCE_IDENTIFICATION } from '../subworkflows/METAGENOMIC_SEQUENCE_IDENTIFICATION.nf'
include { HUMAN_REMOVAL_ONT as HUMAN_REMOVAL_ONT } from '../subworkflows/HUMAN_REMOVAL_ONT.nf'
include { METAGENOMIC_BINNING as METAGENOMIC_BINNING } from '../subworkflows/METAGENOMIC_BINNING.nf'
include { CARD_ONT_QUANT as CARD_ONT_QUANT } from '../subworkflows/CARD_ONT_QUANT.nf'
//include { PATHOGEN_DETECTION as PATHOGEN_DETECTION } from '../subworkflows/PATHOGEN_DETECTION.nf'



workflow ONT_METAGENOMIC {
    take:
        ch_fastqs_raw         //    channel: [val(sample), fastq]
        ch_hostgen        //    channel: fna

    main:




/*
###################################################################################
########## Read QC and Pre-Processing #############################################
###################################################################################
*/

// Non-Optional QC Steps (may include some optional settings):

        READ_QC_ONT(ch_fastqs_raw)

        //HOST_REMOVAL_ONT(READ_QC_ONT.out.chopper_fastq_ch, ch_hostgen)


// Optional Core Pre-Processing Steps:
        
        // Human Removal
        

        if (params.human_removal) {

            HUMAN_REMOVAL_ONT(READ_QC_ONT.out.chopper_fastq_ch)

            ch_human_removal       =  HUMAN_REMOVAL_ONT.out.human_depleted_reads

            } else {

                ch_human_removal    =  READ_QC_ONT.out.chopper_fastq_ch

            }


        // Host Removal
        

        if (params.single_host_removal) {

            HOST_REMOVAL_ONT(ch_human_removal, ch_hostgen)

            ch_host_removal_fqs        =  HOST_REMOVAL_ONT.out.host_depleted_reads

            } else {

                ch_host_removal_fqs  =  ch_human_removal

            }

/*
###################################################################################
########## Pathogen Detection #####################################################
###################################################################################
*/




/*
###################################################################################
########## Assembly Free Mode #####################################################
###################################################################################
*/


        if (params.run_assembly_free) {

            // Non-Optional CORE Steps (may include some optional settings):


            ONT_ASSEMBLY_FREE(ch_host_removal_fqs)
            
            PLASMID_PREDICTION(ONT_ASSEMBLY_FREE.out.output)


            // ARG annotation Steps
            

            // CARD only ARG annoation & Summarization 

            if (params.card_only) {

                //Some process here
            }


            // multi ARG database annoation & Summarization 
            
            if (params.multi_amr) {

                MULTI_AMR(PLASMID_PREDICTION.out.all)
            }

            // Optional Suplementary Steps:


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

            CARD_ONT_QUANT(PLASMID_PREDICTION.out.all)
        }

/*
###################################################################################
########## Metagenomic Assembly & Binning #########################################
###################################################################################
*/

        if (params.run_metaassembly) {

            // metagenomic assembly and binning:


            ONT_ASSEMBLY(ch_host_removal_fqs)
            
        }

/*
###################################################################################
########## Bin ONT Reads ################ #########################################
###################################################################################
*/

        if (params.bin_ont_reads) {

            // Binning of ONT-Reads, skipping assembly:


            METAGENOMIC_BINNING(ch_host_removal_fqs, ONT_ASSEMBLY_FREE.out.output)
            
        }
}
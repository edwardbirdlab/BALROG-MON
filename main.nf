#!/usr/bin/env nextflow
/*
========================================================================================
                         edwardbirdlab/BARA
========================================================================================
 Bacterial Antimicroal Resistance Annoation Pipeline.
 #### Find information at:
 https://github.com/edwardbirdlab/BARA
----------------------------------------------------------------------------------------
*/


def helpMessage() {
    //log.info
    log.info"""
    add instructions here
    """.stripIndent()
}


// Show help emssage
if (params.help){
    helpMessage()
    exit 0
}

nextflow.enable.dsl=2

/* Temp while testing */

out_dir = "./nextflow_out"
project_name = "test_1"
thread_max = "19"
input_folder = "./test_fq"
file_glob = "_[1,2].fq.gz"

fastqs = Channel.fromFilePairs("${input}/${file_glob}")



include { fastqc } from './modules/Initial_QC/fastqc.nf' as raw_fqc

workflow {
  take fastqs
  take out_dir
  take project_name
  take thread_max
  raw_fqc(fastqs)
}
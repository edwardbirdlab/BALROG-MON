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


input_folder = "./BARA/test_fq"
file_glob = "*_[1,2].fq.gz"
includeConfig = "./configs/nxtflow.cfg"
params.project_name = 'BARA_Out'
params.thread_max  = '19'

fastqs = Channel.fromFilePairs("${input_folder}/${file_glob}")



include { fastqc as raw_fqc } from './modules/Initial_QC/fastqc.nf'
include { trim_galore as trim_galore } from './modules/Initial_QC/trimgalore.nf'
include { spades_genome as spades_genome } from './modules/Assembly/spades_genome.nf'
include { spades_plasmid as spades_plasmid } from './modules/Assembly/spades_plasmid.nf'
include { quast as quast_genome} from './modules/Assembly/quast.nf'
include { quast as quast_plasmid} from './modules/Assembly/quast.nf'

workflow {
    take fastqs
    raw_fqc(fastqs)
    trim_galore(fastqs)
    spades_genome(trim_galore.out.trimmed_fastq)
    spades_plasmid(trim_galore.out.trimmed_fastq)
    quast_genome(spades_genome.out.genome)
    quast_plasmid(spades_plasmid.out.plasmids)
    
}
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
include { quast as quast_genome} from './modules/Assembly/quast_genome.nf'
include { quast as quast_plasmid} from './modules/Assembly/quast_plasmid.nf'
include { card_DB as card_DB} from './modules/DB_Down/cardDB.nf'
include { busco as busco_genome } from './modules/Assembly/busco.nf'
include { prokka as prokka_genome } from './modules/Annotation/prokka_genome.nf'
include { prokka as prokka_plasmid } from './modules/Annotation/prokka_plasmid.nf'
include { plasmidverify as plasmidverify } from './modules/Assembly/plasmidverify.nf'
include { plasmidverify_db as plasmidverify_db} from './modules/DB_Down/plasmidverify_db.nf'
include { card_genome as card_genome} from './modules/AMR_Annotation/card_genome.nf'
include { card_plasmid as card_plasmid } from './modules/AMR_Annotation/card_plasmid.nf'
include { barrnap as barrnap } from './modules/Annotation/barrnap.nf'
include { db_16s as db_16s } from './modules/DB_Down/ncbi_16s.nf'
include { blast_16s as blast_16s } from './modules/Annotation/blast_16s.nf'
include { amrfinder_genome as amrfinder_genome } from './modules/AMR_Annotation/amrfinder_genome.nf'
include { amrfinder_plasmid as amrfinder_plasmid } from './modules/AMR_Annotation/amrfinder_plasmid.nf'

workflow {
    take fastqs
    db_16s()
    card_DB()
    plasmidverify_db()
    raw_fqc(fastqs)
    trim_galore(fastqs)
    spades_genome(trim_galore.out.trimmed_fastq)
    spades_plasmid(trim_galore.out.trimmed_fastq)
    quast_genome(spades_genome.out.genome)
    quast_plasmid(spades_plasmid.out.plasmids)
    busco_genome(spades_genome.out.genome)
    prokka_genome(spades_genome.out.genome)
    prokka_plasmid(spades_plasmid.out.plasmids)
    plasmidverify(spades_plasmid.out.plasmids, plasmidverify_db.out.pfam_DB)
    card_plasmid(spades_plasmid.out.plasmids, card_DB.out.card_DB)
    card_genome(spades_genome.out.genome, card_DB.out.card_DB)
    barrnap(spades_genome.out.genome)
    blast_16s(barrnap.out.barrnap_results, db_16s.out.db_16s)
    amrfinder_genome(spades_genome.out.genome)
    amrfinder_plasmid(spades_plasmid.out.plasmids)
}
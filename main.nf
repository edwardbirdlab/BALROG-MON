/*
#######################################
  ____               _____             
 |  _ \      /\     |  __ \      /\    
 | |_) |    /  \    | |__) |    /  \   
 |  _ <    / /\ \   |  _  /    / /\ \  
 | |_) |  / ____ \  | | \ \   / ____ \ 
 |____/  /_/    \_\ |_|  \_\ /_/    \_\
#######################################                                      
*/                                      



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
    add instructions here, this isnt really a help message yet is it
    """.stripIndent()
}


// Show help emssage
if (params.help){
    helpMessage()
    exit 0
}

nextflow.enable.dsl=2

/* Temp while testing */


input_folder = "/scratch/edwardbird/bact_iso_test"
file_glob = "*_[1,2].fq.gz"
params.project_name = 'BARA_Out'
params.thread_max  = '19'

fastqs = Channel.fromFilePairs("${input_folder}/${file_glob}")



include { fastqc as raw_fqc } from './modules/Initial_QC/fastqc.nf'
include { trim_galore as trim_galore } from './modules/Initial_QC/trimgalore.nf'
include { spades_genome as spades_genome } from './modules/Assembly/spades_genome.nf'
//include { spades_plasmid as spades_plasmid } from './modules/Assembly/spades_plasmid.nf'
include { quast as quast_genome} from './modules/Assembly/quast_genome.nf'
include { quast as quast_plasmid} from './modules/Assembly/quast_plasmid.nf'
include { card_DB as card_DB} from './modules/DB_Down/cardDB.nf'
include { busco as busco_genome } from './modules/Assembly/busco.nf'
include { prokka_genome as prokka_genome } from './modules/Annotation/prokka_genome.nf'
include { prokka_plasmid as prokka_plasmid } from './modules/Annotation/prokka_plasmid.nf'
//include { plasmidverify as plasmidverify } from './modules/Assembly/plasmidverify.nf'
//include { plasmidverify_db as plasmidverify_db} from './modules/DB_Down/plasmidverify_db.nf'
include { card_genome as card_genome} from './modules/AMR_Annotation/card_genome.nf'
include { card_plasmid as card_plasmid } from './modules/AMR_Annotation/card_plasmid.nf'
include { barrnap as barrnap } from './modules/Annotation/barrnap.nf'
include { db_16s as db_16s } from './modules/DB_Down/ncbi_16s.nf'
include { blast_16s as blast_16s } from './modules/Annotation/blast_16s.nf'
include { amrfinder_genome as amrfinder_genome } from './modules/AMR_Annotation/amrfinder_genome.nf'
include { amrfinder_plasmid as amrfinder_plasmid } from './modules/AMR_Annotation/amrfinder_plasmid.nf'
include { resfinder_genome as resfinder_genome } from './modules/AMR_Annotation/resfinder_genome.nf'
include { resfinder_db as resfinder_db } from './modules/DB_Down/resfinder_db.nf'
include { resfinder_plasmid as resfinder_plasmid } from "./modules/AMR_Annotation/resfinder_plasmid.nf"
include { gtdbtk as gtdbtk } from "./modules/Annotation/gtdb_tk.nf"
include { gtdbtk_db as gtdbtk_db } from './modules/DB_Down/gtdbtk_db.nf'
include { platon as platon } from './modules/Assembly/platon.nf'
include { platon_db as platon_db } from './modules/DB_Down/platon_db.nf'
include { pfam_db as pfam_db } from './modules/DB_Down/pfam_db.nf'
include { viralverify as viralverify } from './modules/Assembly/viralverify.nf'




workflow {
    take fastqs
    gtdbtk_db()
    resfinder_db()
    db_16s()
    card_DB()
//    plasmidverify_db()
    pfam_db()
    raw_fqc(fastqs)
    trim_galore(fastqs)
    spades_genome(trim_galore.out.trimmed_fastq)
//    spades_plasmid(trim_galore.out.trimmed_fastq)
    platon(spades_genome.out.genome)

    quast_genome(spades_genome.out.genome)
    quast_plasmid(spades_plasmid.out.plasmids)
    busco_genome(spades_genome.out.genome)
    prokka_genome(spades_genome.out.genome)
    prokka_plasmid(spades_plasmid.out.plasmids)
//    plasmidverify(spades_plasmid.out.plasmids, plasmidverify_db.out.pfam_DB)
    viralverify(spades_plasmid.out.plasmids, pfam_db.out.pfam_DB)
    card_plasmid(spades_plasmid.out.plasmids, card_DB.out.card_DB)
    card_genome(spades_genome.out.genome, card_DB.out.card_DB)
    barrnap(spades_genome.out.genome)
    blast_16s(barrnap.out.barrnap_results, db_16s.out.db_16s)
    amrfinder_genome(spades_genome.out.genome)
    amrfinder_plasmid(spades_plasmid.out.plasmids)
    gtdbtk(spades_genome.out.genome, gtdbtk_db.out.DB)
}

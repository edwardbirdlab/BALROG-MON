#!/usr/bin/env nextflow
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




/*
========================================================================================
                         edwardbirdlab/BARA
========================================================================================
 Bacterial Antimicroal Resistance Annoation Pipeline.
 #### Find information at:
 https://github.com/edwardbirdlab/BARA
----------------------------------------------------------------------------------------
*/


/* Settings for argdit */
params.argdit_FastaHeaderFieldSeparator = '|'
params.argdit_OperationalFieldSeparator = '__'
params.argdit_MinSequenceCount = '3'
params.argdit_BootstrapFactor = '1000'
params.argdit_Email = 'edwardbirdlab@gmail.com'
params.argdit_DefaultGeneticCode = '11'



nextflow.enable.dsl=2

/* Temp while testing */


input_folder = "/homes/edwardbird/data/bacterial_testdata"
file_glob = "*_[1,2].fq.gz"
params.project_name = 'BALRROG_Testing'
params.thread_max  = '19'

fastqs = Channel.fromFilePairs("${input_folder}/${file_glob}")



include { fastqc as raw_fqc } from './modules/Initial_QC/fastqc.nf'
include { trim_galore as trim_galore } from './modules/Initial_QC/trimgalore.nf'
include { spades_genome as spades_genome } from './modules/Assembly/spades_genome.nf'
include { quast as quast_genome} from './modules/Assembly/quast_genome.nf'
include { quast as quast_plasmid} from './modules/Assembly/quast_plasmid.nf'
include { card_DB as card_DB} from './modules/ARG_db_download/cardDB.nf'
include { busco as busco_genome } from './modules/Assembly/busco.nf'
include { prokka_genome as prokka_genome } from './modules/Annotation/prokka_genome.nf'
include { prokka_plasmid as prokka_plasmid } from './modules/Annotation/prokka_plasmid.nf'
include { card_genome as card_genome} from './modules/AMR_Annotation/card_genome.nf'
include { card_plasmid as card_plasmid } from './modules/AMR_Annotation/card_plasmid.nf'
include { barrnap as barrnap } from './modules/Annotation/barrnap.nf'
include { db_16s as db_16s } from './modules/DB_Down/ncbi_16s.nf'
include { blast_16s as blast_16s } from './modules/Annotation/blast_16s.nf'
include { amrfinder_genome as amrfinder_genome } from './modules/AMR_Annotation/amrfinder_genome.nf'
include { amrfinder_plasmid as amrfinder_plasmid } from './modules/AMR_Annotation/amrfinder_plasmid.nf'
include { resfinder_genome as resfinder_genome } from './modules/AMR_Annotation/resfinder_genome.nf'
include { resfinder_db as resfinder_db } from './modules/ARG_db_download/resfinder_db.nf'
include { resfinder_plasmid as resfinder_plasmid } from "./modules/AMR_Annotation/resfinder_plasmid.nf"
include { gtdbtk as gtdbtk } from "./modules/Annotation/gtdb_tk.nf"
include { gtdbtk_db as gtdbtk_db } from './modules/DB_Down/gtdbtk_db.nf'
include { platon as platon } from './modules/Assembly/platon.nf'
include { platon_db as platon_db } from './modules/DB_Down/platon_db.nf'
include { pfam_db as pfam_db } from './modules/DB_Down/pfam_db.nf'
include { viralverify as viralverify } from './modules/Assembly/viralverify.nf'
include { amrfinder_db as amrfinder_db } from './modules/ARG_db_download/amrfinder_db.nf'
include { argannot_db as argannot_db } from './modules/ARG_db_download/argannot_db.nf'
include {argdit_config as argdit_config} from './modules/ARG_db_prep/argdit_config.nf'
include {argdit_checkdb_nt as argdit_checkdb_nt} from './modules/ARG_db_prep/argdit_checkdb_nt.nf'
include {argdit_merge as argdit_merge} from './modules/ARG_db_prep/argdit_merge.nf'
include { megares as megares } from './modules/ARG_db_download/megares_db.nf'
include {argdit_schema_check as argdit_schema_check} from './modules/ARG_db_prep/argdit_schema_check.nf'





workflow {

/*
Input
*/

    take fastqs

/*
Database Downloading
*/
    gtdbtk_db()
    resfinder_db()
    argannot_db()
    db_16s()
    card_DB()
    pfam_db()
    platon_db()
    amrfinder_db()
    megares()


/*
QC & Trimming
*/   
    raw_fqc(fastqs)
    trim_galore(fastqs)

/*
Assembly & Plasmid Prediciton + QC
*/
    spades_genome(trim_galore.out.trimmed_fastq)
    platon(spades_genome.out.genome, platon_db.out.platon_DB)
    quast_genome(platon.out.predict_chr)
    quast_plasmid(platon.out.predict_plas)
    busco_genome(platon.out.predict_chr)
    viralverify(platon.out.predict_plas, pfam_db.out.pfam_DB)

/*
Quick Functional Annotation
*/
    prokka_genome(platon.out.predict_chr)
    prokka_plasmid(platon.out.predict_plas)

/*
AMR Database Prep
*/ 
    arg_only_fa = amrfinder_db.out.only_fa.mix(argannot_db.out.only_fa, card_DB.out.only_fa, resfinder_db.out.only_fa, megares.out.only_fa)
    argdit_config()
    argdit_checkdb_nt(argdit_config.out.config, arg_only_fa)
    argdit_schema_check(argdit_config.out.config, megares.out.only_sc)
//    argdit_merge(argdit_config.out.config, arg_only_fa.collect(), megares.out.only_sc)


/*
Identification
*/
    barrnap(platon.out.predict_chr)
    blast_16s(barrnap.out.barrnap_results, db_16s.out.db_16s)
    gtdbtk(platon.out.predict_chr, gtdbtk_db.out.DB)

/*
ARG Annotation
*/
//    card_plasmid(platon.out.predict_plas, card_DB.out.card_DB)
//    card_genome(platon.out.predict_chr, card_DB.out.card_DB)
//    amrfinder_genome(platon.out.predict_chr)
//    amrfinder_plasmid(platon.out.predict_plas)
}

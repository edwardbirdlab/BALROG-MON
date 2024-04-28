#!/usr/bin/env nextflow
/*
#######################################
                                               ...._
                                         ..-```      ``.._
                                    _--``             .-`````)
               .-````----.....___../`  /``                   ```)
            _.(-----._  -.,.   _._   <_)     ........      .-````)
           (__            (_> (_/\_)  `   .-``        `-._       -``)_
        .-(     .--`````    .-----------.       --.   -.   -._   .-`` )
       /`---   /`    /```` /.. /.vv.\...-.\         \    \    \     -```)
      /`--    /           |`)vV`    `Vv|  ).         \   |____/       ---)
     (__     /             \| /````````| /.\      \  __.-`  //// /`/````)
    (       /      /        v/  /``.....V\\        \/\ \ \ //// /    _.)  
   ( `-..  /      /__  |    .| /  /     \\\       /\     ///     _.-
  (_.-----/____  /`\___\     \ |  |     || |     /          _.-``
 (     _.r-\\  `//\    `\     \ \ \     // |     \      ,.-’`
(__.-\ \ \ \\  ////|      \_   \ ` \____/  /     \\   /
  `\.          /// |\       \   `\.  __   /      /\\  |
     `*-.________  | |       \     \  _  /   .^./  \\ |
                 ! / /        `-.   \___/ .-./ |    \\|
                 || /         ^._...,    (     )     \|
                 ||/          \.    |     \._./       v
                 (|)            `-..’     ./
                  V                 ``...`                                            
       ___             
|_|     |          __  
| |igh  |hroughput     
__            _                  __                __            ___
|_|          /_\            |    |_|              |  |          | __
|_|acterial /   \ntimicrobia|__  | \estistance ann|__|tation of |__|enomes 

#######################################                                      
*/                                      




/*
========================================================================================
                         edwardbirdlab/BALROG-MON
========================================================================================
 Bacterial Antimicroal Resistance Annoation Pipeline.
 #### Find information at:
 https://github.com/edwardbirdlab/BALROG-MON
----------------------------------------------------------------------------------------
*/
nextflow.enable.dsl=2

if (params.workflow_opt == 'shortread_isolate') {

    //SHORT_READ_ISOLATE(ch_fastq)

    }

if (params.workflow_opt == 'shortread_meta') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.r1), file(row.r2)) }

    ch_hostgen = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.refernce_genome)) }

    }

if (params.workflow_opt == 'ont_meta') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.path)) }

    ch_hostgen = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.refernce_genome)) }

    }



//include { SHORT_READ_ISOLATE as SHORT_READ_ISOLATE } from './workflows/SHORT_READ_ISOLATE.nf'
include { SHORT_READ_METAGENOMIC as SHORT_READ_METAGENOMIC } from './workflows/SHORT_READ_METAGENOMIC.nf'
include { ONT_METAGENOMIC as ONT_METAGENOMIC } from './workflows/ONT_METAGENOMIC.nf'

workflow {

    if (params.workflow_opt == 'shortread_isolate') {

        //SHORT_READ_ISOLATE(ch_fastq)

        }

    if (params.workflow_opt == 'shortread_meta') {

        SHORT_READ_METAGENOMIC(ch_fastq, ch_hostgen)

        }

    if (params.workflow_opt == 'ont_meta') {

        ONT_METAGENOMIC(ch_fastq, ch_hostgen)

        }

}






    






//workflow {

/*
Input
*/

//    take fastqs
//    take bacscan
//    take bacscan_nhmm

/*
Database Downloading
*/
//    gtdbtk_db()
//    resfinder_db()
//    argannot_db()
//    db_16s()
//    card_DB()
//    pfam_db()
//    platon_db()
//    amrfinder_db()
//    megares()
//    //kracken_db()
//    kraken2_db()
//    plasmer_db()


/*
QC & Trimming
*/   
//    raw_fqc(fastqs)
//    fastp(fastqs)
//    trim_fqc(fastp.out.trimmed_fastq)
//    krackenuni(fastp.out.trimmed_fastq, kracken_db.out.kracken_DB)

/*
Assembly & Plasmid Prediciton + QC
*/
//    spades_genome(fastp.out.trimmed_fastq)
    //platon(spades_genome.out.genome, platon_db.out.platon_DB)
//    plasmer(spades_genome.out.genome, plasmer_db.out.plasmer_DB)
    //quast_genome(platon.out.predict_chr)
//    quast_plasmid(platon.out.predict_plas)
//    busco_genome(platon.out.predict_chr)
    //viralverify(platon.out.predict_plas, pfam_db.out.pfam_DB)
    //kraken2(spades_genome.out.genome, kraken2_db.out.kraken2_DB)

/*
Quick Functional Annotation
*/
    //prokka_genome(platon.out.predict_chr)
    //prokka_plasmid(platon.out.predict_plas)
    //mef_plasmid(platon.out.predict_plas)
    //mef_genome(platon.out.predict_chr)

/*
AMR Database Prep
*/ 
// +    arg_only_fa = amrfinder_db.out.only_fa.mix(argannot_db.out.only_fa, card_DB.out.only_fa, resfinder_db.out.only_fa, megares.out.only_fa)
//    argdit_config()
//    argdit_checkdb_nt(argdit_config.out.config, arg_only_fa)
//    argdit_uniprot(argdit_config.out.config, bacscan)
//    argdit_schema_check(argdit_config.out.config, bacscan)
//    argdit_merge(argdit_config.out.config, arg_only_fa.collect(), bacscan)
// +    cdhit_merge(arg_only_fa.collect())
// +    nhmmscan(cdhit_merge.out.cdhit_db, bacscan_nhmm)


/*
Identification
*/
    //barrnap(platon.out.predict_chr)
    //blast_16s(barrnap.out.barrnap_results, db_16s.out.db_16s)
//    gtdbtk(platon.out.predict_chr, gtdbtk_db.out.DB)

/*
ARG Annotation
*/
    //card_plasmid(platon.out.predict_plas, card_DB.out.card_DB)
    //card_genome(platon.out.predict_chr, card_DB.out.card_DB)
    //card_plasmid_mef(mef_plasmid.out.mef_fna, card_DB.out.card_DB)
    //card_genome_mef(mef_genome.out.mef_fna, card_DB.out.card_DB)
    //amrfinder_genome(platon.out.predict_chr)
    //amrfinder_plasmid(platon.out.predict_plas)
//}

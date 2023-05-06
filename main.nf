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
params.fastp_q = '20'



nextflow.enable.dsl=2

/* Temp while testing */


input_folder = "/homes/edwardbird/data/bacterial_isolates"
file_glob = "*_[1,2].fq.gz"
params.project_name = 'BALRROG_CARD_AMRFINDER'
params.thread_max = '16'
fastqs = Channel.fromFilePairs("${input_folder}/${file_glob}")
bacscan = Channel.fromPath( '/scratch/edwardbird/BALRROG_Testing/Bacscan_db_uniprot.sc' )
bacscan_nhmm = Channel.fromPath( '/scratch/edwardbird/BALRROG_Testing/nARGhmm.tar.gz' )



include { fastqc as raw_fqc } from './modules/Initial_QC/raw_fastqc.nf'
include { fastqc as trim_fqc } from './modules/Initial_QC/trim_fastqc.nf'
include { fastp as fastp } from './modules/Initial_QC/fastp.nf'
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
include { platon_meta as platon_meta } from './modules/Assembly/platon_meta.nf'
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
include {argdit_uniprot as argdit_uniprot} from './modules/ARG_db_prep/argdit_uniprot.nf'
include { kracken_db as kracken_db } from './modules/DB_Down/kracken_db.nf'
include {krackenuni as krackenuni} from './modules/Initial_QC/krackenuni.nf'
include {cdhit_merge as cdhit_merge} from './modules/ARG_db_prep/cdhit_merge.nf'
include {nhmmscan as nhmmscan} from './modules/ARG_db_prep/nhmmscan.nf'


workflow short_read_assembly {
    take:
        fastqs_short
    main:
        platon_db()
        raw_fqc(fastqs_short)
        fastp(fastqs_short)
        trim_fqc(fastp.out.trimmed_fastq)
        spades_genome(fastp.out.trimmed_fastq)
        platon(spades_genome.out.genome, platon_db.out.platon_DB)
    emit:
        platon.out.predict_chr
        platon.out.predict_plas

}

workflow hybrid_assembly {
    take:
        fastqs_short_meta
    main:
        platon_db()
        raw_fqc(fastqs_short_meta)
        fastp(fastqs_short_meta)
        trim_fqc(fastp.out.trimmed_fastq)
        spades_metagenome(fastp.out.trimmed_fastq)
        platon_meta(spades_metagenome.out.genome, platon_db.out.platon_DB)
    emit:
        platon_meta.out.predict_chr
        platon_meta.out.predict_plas
    
}

workflow ARG_Database {
    take:
        take bacscan
    main:

    /*
    Database Downloading
    */
        resfinder_db()
        argannot_db()
        card_DB()
        amrfinder_db()
        megares()

    /*
    AMR Database Prep
    */ 
        arg_only_fa = amrfinder_db.out.only_fa.mix(argannot_db.out.only_fa, card_DB.out.only_fa, resfinder_db.out.only_fa, megares.out.only_fa)
        argdit_config()
        argdit_checkdb_nt(argdit_config.out.config, arg_only_fa)
    //    argdit_uniprot(argdit_config.out.config, bacscan)
    //    argdit_schema_check(argdit_config.out.config, bacscan)
    //    argdit_merge(argdit_config.out.config, arg_only_fa.collect(), bacscan)

//    emit:
//        platon_meta.out.predict_chr
//        platon_meta.out.predict_plas

}

workflow long_read_assembly {
    
    
}

workflow isolate_annotation {
    take:
        genome_assembly
        plasmid_assembly
    main:

    /*
    Database Downloading
    */
        gtdbtk_db()
        db_16s()
        pfam_db()

    /*
    Assembly QC
    */
        quast_genome(genome_assembly)
        quast_plasmid(plasmid_assembly)
        busco_genome(genome_assembly)
        viralverify(plasmid_assembly, pfam_db.out.pfam_DB)

    /*
    Quick Functional Annotation
    */
        prokka_genome(genome_assembly)
        prokka_plasmid(plasmid_assembly)


    /*
    Identification
    */
        barrnap(genome_assembly)
        blast_16s(barrnap.out.barrnap_results, db_16s.out.db_16s)
        gtdbtk(genome_assembly, gtdbtk_db.out.DB)

    /*
    ARG Annotation
    */
    //    card_plasmid(plasmid_assembly, card_DB.out.card_DB)
    //    card_genome(genome_assembly, card_DB.out.card_DB)
    //    amrfinder_genome(genome_assembly)
    //    amrfinder_plasmid(plasmid_assembly)
        
    
}

workflow metagenome_annotation {
    
    
}

workflow {

/*
Input
*/

    take fastqs
    take bacscan

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
    kracken_db()


/*
QC & Trimming
*/   
    raw_fqc(fastqs)
    fastp(fastqs)
    trim_fqc(fastp.out.trimmed_fastq)
//    krackenuni(fastp.out.trimmed_fastq, kracken_db.out.kracken_DB)

/*
Assembly & Plasmid Prediciton + QC
*/
    spades_genome(fastp.out.trimmed_fastq)
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
//    argdit_config()
//    argdit_checkdb_nt(argdit_config.out.config, arg_only_fa)
//    argdit_uniprot(argdit_config.out.config, bacscan)
//    argdit_schema_check(argdit_config.out.config, bacscan)
//    argdit_merge(argdit_config.out.config, arg_only_fa.collect(), bacscan)
    cdhit_merge(arg_only_fa.collect())
    nhmmscan(cdhit_merge.out.cdhit_db, bacscan_nhmm)


/*
Identification
*/
    barrnap(platon.out.predict_chr)
    blast_16s(barrnap.out.barrnap_results, db_16s.out.db_16s)
    gtdbtk(platon.out.predict_chr, gtdbtk_db.out.DB)

/*
ARG Annotation
*/
    card_plasmid(platon.out.predict_plas, card_DB.out.card_DB)
    card_genome(platon.out.predict_chr, card_DB.out.card_DB)
    amrfinder_genome(platon.out.predict_chr)
    amrfinder_plasmid(platon.out.predict_plas)
}

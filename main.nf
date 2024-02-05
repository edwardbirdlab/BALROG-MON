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

/* Other program Settings */
params.fastp_q = '20'
params.chdit_ident = '0.95'
params.chdit_word_size = '8'
params.platon_mode = 'accuracy'
params.bacscan_nhmm_eval = '0.000001'
params.platon_meta = 'True'
params.min_contig_size = '500'           //==  combined with coverage to filter out small lov cov contigs
params.min_contig_cov = '2'              //==  conbined with size to filter out small lov cov contigs
params.plasmer_min_len = '500'           //==  Setting the minimum size to be classified in plasmer (defualt/recommended = 500)
params.plasmer_max_len = '500000'        //==  Setting the length at which all contigs greater than this size are automatically considered chromomosomal in orgin (defualt = 500000)



/*
Database Settings (True = autodownload, False = supplied in corresponding folder)
*/

params.database_dir = ''

//Plasmer (recommend autodownload)
params.db_plasmer = true

//Kracken2 (recommend autodownload) If different database is used change RAM requirements as needed in config
params.db_kraken2 = true

//ViralVerify_pfam_db (Can be updated for more up to date plasmid searching, dependent on use)
params.db_viralverify = true

//GTDBtk (Can be updated for more up to date genome identification)
params.db_gtdbtk = true

//ViralVerify_pfam_db (Can be updated for more up to date plasmid searching, dependent on use)
params.db_ncbi16S = true

//resfinder (Reccomend updating for most up to date ARGs)
params.db_resfinder = true

//amrfinder (Reccomend updating for most up to date ARGs)
params.db_amrfinder = true

//argannot (Reccomend updating for most up to date ARGs)
params.db_argannot = true

//card (Reccomend updating for most up to date ARGs)
params.db_card = true

//megares (Reccomend updating for most up to date ARGs)
params.db_megares = true

//Kracken2 PlusPF for metagenomic community anlysis (recommend autodownload) If different database is used change RAM requirements as needed in config
params.db_kraken2_pluspf = true

//Perform metagenomic assembly on ONT reads == True, Convert reads to Fasta without Assembly == False
params.ont_metagenomic_assembly = false





nextflow.enable.dsl=2

/* Temp Input while testing */

params.sample_sheet = '/fastscratch/edwardbird/BALLROG_ONT_META/samplesheet.csv'
fastq_ch = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.path)) }

//input_folder = "/homes/edwardbird/data/bacterial_metagenome_testdata"
//file_glob = "*_[1,2].fq.gz"
params.project_name = 'BALRROG_ONT_META'
//fastqs = Channel.fromFilePairs("${input_folder}/${file_glob}", flat: true)
bacscan = Channel.fromPath( '/scratch/edwardbird/BALRROG_Testing/Bacscan_db_uniprot.sc' )
bacscan_nhmm = Channel.fromPath( '/homes/edwardbird/data/database/nARGhmm.tar.gz' )
//host_gen_fasta = Channel.fromPath( '/homes/edwardbird/data/genome/Musca_dome_new/musca_domestica_genomic_fixed.fasta' )
ch_host_genomes = Channel.fromPath( '/fastscratch/edwardbird/BALLROG_ONT_META/Host_genomes/**' )



//include { SHORT_READ_ISOLATE as SHORT_READ_ISOLATE } from './workflows/SHORT_READ_ISOLATE.nf'
include { ONT_METAGENOMIC as ONT_METAGENOMIC } from './workflows/ONT_METAGENOMIC.nf'

workflow {
//    SHORT_READ_ISOLATE (fastqs)
//    SHORT_READ_METAGENOMIC(fastqs, host_gen_fasta)
    ONT_METAGENOMIC(fastq_ch, ch_host_genomes)
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

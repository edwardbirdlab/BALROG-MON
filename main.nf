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

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.r1), file(row.r2)) }

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

if (params.workflow_opt == 'shortread_meta_rna') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.r1), file(row.r2)) }

    }

include { SHORT_READ_ISOLATE as SHORT_READ_ISOLATE } from './workflows/SHORT_READ_ISOLATE.nf'
include { SHORT_READ_METAGENOMIC as SHORT_READ_METAGENOMIC } from './workflows/SHORT_READ_METAGENOMIC.nf'
include { SHORT_READ_METAGENOMIC_RNA as SHORT_READ_METAGENOMIC_RNA } from './workflows/SHORT_READ_METAGENOMIC_RNA.nf'
include { ONT_METAGENOMIC as ONT_METAGENOMIC } from './workflows/ONT_METAGENOMIC.nf'

workflow {

    if (params.workflow_opt == 'shortread_isolate') {

        SHORT_READ_ISOLATE(ch_fastq)

        }

    if (params.workflow_opt == 'shortread_meta') {

        SHORT_READ_METAGENOMIC(ch_fastq, ch_hostgen)

        }

    if (params.workflow_opt == 'ont_meta') {

        ONT_METAGENOMIC(ch_fastq, ch_hostgen)

        }

    if (params.workflow_opt == 'shortread_meta_rna') {

        SHORT_READ_METAGENOMIC_RNA(ch_fastq)

        }

}
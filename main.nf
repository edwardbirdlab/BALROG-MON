#!/usr/bin/env nextflow
/*
##########################################################################
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

##########################################################################
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


if (params.workflow_opt == 'ont_meta') {

    ch_fastq = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.path)) }

    ch_hostgen = Channel.fromPath(params.sample_sheet) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sample, file(row.reference_genome)) }

    }


include { ONT_METAGENOMIC as ONT_METAGENOMIC } from './workflows/ONT_METAGENOMIC.nf'
include { ONT_MULTIQC as ONT_MULTIQC } from './workflows/ONT_MULTIQC.nf'

workflow {

    if (params.workflow_opt == 'ont_meta') {

        ONT_METAGENOMIC(ch_fastq, ch_hostgen)

        }

    if (params.workflow_opt == 'ont_multiqc') {

        ONT_MULTIQC()

        }

}

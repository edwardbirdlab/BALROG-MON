/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { READ_QC_SR as READ_QC_SR } from '../subworkflows/READ_QC_SR.nf'


workflow QC_ONLY {
    take:
        fastqs_short_raw      //    channel: [val(sample), [fastq_1, fastq_2]]

    main:
        READ_QC_SR(fastqs_short_raw)

}
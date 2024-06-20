/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { ONT_MULTIQC_SW as ONT_MULTIQC_SW } from '../subworkflows/ONT_MULTIQC_SW.nf'


workflow ONT_MULTIQC {

    main:
        ONT_MULTIQC_SW()

}
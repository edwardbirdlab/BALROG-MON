/*
~~~~~~~~~~~~~~~~~~~~~~
Importing subworkflows
~~~~~~~~~~~~~~~~~~~~~~
*/

include { SR_MULTIQC_SW as SR_MULTIQC_SW } from '../subworkflows/SR_MULTIQC.nf'


workflow SR_MULTIQC {

    main:
        SR_MULTIQC_SW()

}
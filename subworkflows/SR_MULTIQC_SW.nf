/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { MULTIQC_SR as MULTIQC_SR } from '../modules/MULTIQC_SR.nf'


workflow SR_MULTIQC_SW {


    main:

        ch_multiqc_yaml    =  Channel.fromPath("/configs/multiqc/sr_multiqc.yaml")

        MULTIQC_SR(ch_multiqc_yaml)
}
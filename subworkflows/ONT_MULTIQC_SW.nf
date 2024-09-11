/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { MULTIQC as MULTIQC } from '../modules/MULTIQC.nf'


workflow ONT_MULTIQC_SW {


    main:

        ch_multiqc_yaml    =  Channel.fromPath("${projectDir}/configs/multiqc/ont_multiqc.yaml")

        ch_multiqc_analysisdir = Channel.fromPath("${launchDir}/${params.project_name}")

        MULTIQC(ch_multiqc_yaml, ch_multiqc_analysisdir)
}
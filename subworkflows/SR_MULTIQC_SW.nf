/*
Subworkflow for doanloading of mutiple AMR databases


*/

include { MULTIQC as MULTIQC } from '../modules/MULTIQC.nf'


workflow SR_MULTIQC_SW {


    main:

        ch_multiqc_yaml    =  Channel.fromPath("${projectDir}/configs/multiqc/sr_multiqc.yaml")

        ch_multiqc_analysisdir = Channel.fromPath("${launchDir}/${params.project_name}")

        ch_multiqc_yaml.view()

        ch_multiqc_analysisdir.view()

        MULTIQC(ch_multiqc_yaml)
}
#!/usr/bin/env nextflow

genomes = "../scaffolds"
out_dir = "./nextflow_out"
project_name = "card_genome4"

genome = Channel.fromPath("${genomes}/*fa").map  { file -> tuple(file.baseName, file) }



process card{
    tag { "${project_name}.card.${sample}" }
    publishDir "${out_dir}/${project_name}/card", mode: 'copy', overwrite: false

    input:
        set sample, file(fasta) from genome


    output:
        set sample, file("${sample}_seqs.fa") into outdata

    script:

    """
    barrnap --quiet $fasta --outseq ${sample}_seqs.fa
    """
}


workflow.onComplete {

    println ( workflow.success ? """
        Pipeline execution summary
        ---------------------------
        Completed at: ${workflow.complete}
        Duration    : ${workflow.duration}
        Success     : ${workflow.success}
        workDir     : ${workflow.workDir}
        exit status : ${workflow.exitStatus}
        """ : """
        Failed: ${workflow.errorReport}
        exit status : ${workflow.exitStatus}
        """
    )
}

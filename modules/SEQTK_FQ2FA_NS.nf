process SEQTK_FQ2FA_NS {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'
    publishDir "${params.project_name}/Host_Depletion/${task.process}", mode: 'copy', overwrite: true

    input:
        file(fastq)
    output:
        path("output_fq2fa.fa"), emit: fq2fa

    script:

    """
    seqtk seq -a ${fastq} > output_fq2fa.fa
    """
}
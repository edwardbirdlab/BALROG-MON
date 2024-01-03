process SEQTK_FQ2FA {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'
    publishDir "${params.project_name}/Host_Depletion/${task.process}", mode: 'copy', overwrite: true

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}.fa"), emit: fq2fa

    script:

    """
    seqtk seq -a ${fastq} > ${sample}.fa
    """
}
process SEQTK_FQ2FA {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}.fa"), emit: fq2fa

    script:

    """
    seqtk seq -a ${fastq} > ${sample}.fa
    """
}
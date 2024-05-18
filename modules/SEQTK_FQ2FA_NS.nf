process SEQTK_FQ2FA_NS {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        file(fastq)
    output:
        path("output_fq2fa.fa"), emit: fq2fa

    script:

    """
    seqtk seq -a ${fastq} > output_fq2fa.fa
    """
}
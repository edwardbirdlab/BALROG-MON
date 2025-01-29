process SEQTK_FQ2FA {
    label 'lowmem'
    container 'ebird013/seqtk:1.4'

    input:
        tuple val(sample), file(fastq)
    output:
        tuple val(sample), path("${sample}.fa"), emit: fq2fa
        path("versions.yml"), emit: versions

    script:

    """
    seqtk seq -a ${fastq} > ${sample}.fa

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        seqtk: \$(seqtk 2>&1 | grep "Version" | sed -e "s/Version: //g")
    END_VERSIONS 
    """
}
process INPUT_STANDARD_PEFQ {
    label 'midmemshort'
	container 'ebird013/data_validator:1.0'

    input:
        tuple val(sample), file(R1), file(R2)
    output:
        tuple val(sample), path("/work/Validated_Data/${sample}_1.fastq.gz"), path("/work/Validated_Data/${sample}_2.fastq.gz"), emit: valid_fastqs

    script:

    """
    data_validator.py PE_FQ ${R1} ${R2} ${sample} --gzip
    """
}

process INPUT_STANDARD_SEFQ {
    label 'midmemshort'
    container 'ebird013/data_validator:1.0'

    input:
        tuple val(sample), file(R1)
    output:
        tuple val(sample), path("/work/Validated_Data/${sample}.fastq.gz"), emit: valid_fastq

    script:

    if ( params.rename_fastq ) {
        def rename_arg = " --rename"
    }
    else {
        def rename_arg = ""
    }

    """
    data_validator.py SE_FQ ${R1} ${sample} --gzip \\
    ${rename_arg}
    """
}

process INPUT_STANDARD_FA {
    label 'midmemshort'
    container 'ebird013/data_validator:1.0'

    input:
        tuple val(sample), val(fasta)
    output:
        tuple val(sample), path("/work/Validated_Data/*.fasta"), emit: valid_fasta

    script:

    """
    data_validator.py FA ${fasta}
    """
}
process INPUT_STANDARD_SEFQ {
    label 'midmemshort'
    container 'ebird013/data_validator:1.1'

    input:
        tuple val(sample), file(R1)

    output:
        tuple val(sample), path("/work/Validated_Data/${sample}.fastq.gz"), emit: valid_fastq

    script:

    """

    echo "Running data_validator.py with fastq: ${R1}"
    data_validator.py SE_FQ ${R1} ${sample} --gzip

    """
}
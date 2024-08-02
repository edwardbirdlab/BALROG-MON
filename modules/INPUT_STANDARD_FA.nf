process INPUT_STANDARD_FA {
    label 'midmemshort'
    container 'ebird013/data_validator:1.0'

    input:
        tuple val(sample), val(fasta)
    output:
        tuple val(sample), path("/work/Validated_Data/*.fasta"), emit: valid_fasta

    script:

    """
    echo "Running data_validator.py with fasta: ${fasta}"
    data_validator.py FA ${fasta}
    """

}
process INPUT_STANDARD_PEFQ {
    label 'midmemshort'
	container 'ebird013/data_validator:1.3'

    input:
        tuple val(sample), file(R1), file(R2)
    output:
	    tuple val(sample), path("Validated_Data/${sample}_1.fastq.gz"), path("Validated_Data/${sample}_2.fastq.gz"), emit: valid_fastqs


    script:

    """
    data_validator.py PE_FQ ${R1} ${R2} --sample_name ${sample}
    """
}

process INPUT_STANDARD_SEFQ {
    label 'midmemshort'
    container 'ebird013/data_validator:1.3'

    input:
        tuple val(sample), file(R1)
    output:
        tuple val(sample), path("Validated_Data/${sample}.fastq.gz"), emit: valid_fastq


    script:

    //def adapter_arg_1 = params.fastp_adap1 ? "--adapter_sequence ${params.fastp_adap1}" : ""
    //def adapter_arg_2 = params.fastp_adap2 ? "--adapter_sequence_r2 ${params.fastp_adap2}" : ""

    """
    data_validator.py SE_FQ ${R1} --sample_name ${sample}
    """
}

process INPUT_STANDARD_FA {
    label 'midmemshort'
    container 'ebird013/data_validator:1.3'

    input:
        tuple val(sample), file(FASTA)
    output:
        tuple val(sample), path("Validated_Data/*.fasta"), emit: valid_fasta


    script:

    """
    data_validator.py FA ${FASTA}
    """
}
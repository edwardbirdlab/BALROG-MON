process MULTIQC {
   label 'lowmemnk'
    container 'ebird013/multiqc:1.22.2'

    input:
        val(yaml)
    output:
        path("./*.html"), emit: data
        path("./multiqc_data"), emit: data

    script:

    """
    multiqc -f -c ${yaml} ${params.project_name}
    """
}
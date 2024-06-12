process MULTIQC {
   label 'lowmemnk'
    container 'ebird013/multiqc:1.22.2'

    input:
        val(yaml)
        val(analysis_dir)
    output:
        path("*.html"), emit: html
        path("./multiqc_data"), emit: data

    script:

    """
    multiqc -f -c ${yaml} ${analysis_dir}
    """
}
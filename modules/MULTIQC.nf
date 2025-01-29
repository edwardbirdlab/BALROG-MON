process MULTIQC {
   label 'lowmemnk'
    container 'ebird013/multiqc:1.22.2'

    input:
        val(yaml)
        val(analysis_dir)
    output:
        path("*.html"), emit: html
        path("./multiqc_data"), emit: data
        path("versions.yml"), emit: versions

    script:

    """
    multiqc -f -c ${yaml} ${analysis_dir}

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        MultiQC: \$(multiqc --version 2>&1 | grep "version" | sed -e "s/multiqc, version //g")
    END_VERSIONS 
    """
}
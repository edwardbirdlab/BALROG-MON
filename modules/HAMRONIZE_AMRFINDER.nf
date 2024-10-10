process HAMRONIZE_AMRFINDER {
   label 'lowmemnk'
    container 'ebird013/harmonization:1.0.2'

    input:
        tuple val(sample), file(tsv), file(versions)

    output:
        tuple val(sample), path("./${sample}_harmonize_amrfinder.tsv"), emit: tsv
        path("versions.yml"), emit: versions

    script:

    """
    rgi_main=\$(grep 'rgi_main' ${versions} | awk -F': ' '{print \$2}')
    card=\$(grep 'card' ${versions} | awk -F': ' '{print \$2}')

    hamronize amrfinderplus ${tsv} --analysis_software_version \$rgi_main --reference_database_version \$card --input_file_name ${sample} --output ${sample}_harmonize_amrfinder.tsv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        hamronization: \$(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    """
}
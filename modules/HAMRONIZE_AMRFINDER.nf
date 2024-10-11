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
    version=\$(grep 'amrfinder' ${versions} | awk -F': ' '{print \$2}')
    version_db=\$(grep 'amrfinder_db' versions.yml | awk -F': ' '{split(\$2, arr, "."); print arr[1]}')

    hamronize amrfinderplus ${tsv} --analysis_software_version \$version --reference_database_version \$version_db --input_file_name ${sample} --output ${sample}_harmonize_amrfinder.tsv

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        hamronization: \$(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    """
}
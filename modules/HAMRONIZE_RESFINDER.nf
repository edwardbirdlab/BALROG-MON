process HAMRONIZE_AMRFINDER {
   label 'lowmemnk'
    container 'ebird013/harmonization:1.0.2'

    input:
        tuple val(sample), file(tsv), file(versions)

    output:
        tuple val(sample), path("./${sample}_harmonize_resfinder.tsv"), emit: tsv
        path("./${sample}_harmonize_resfinder.tsv"), emit: tsv_only
        path("versions.yml"), emit: versions

    shell:

    '''
    mv !{versions} metadata.yml
    version=$(grep 'resfinder:' metadata.yml | awk -F' ' '{print $2}')
    version_db=$(grep 'resfinder_db:' metadata.yml | awk -F' ' '{print $2}')

    hamronize resfinder !{tsv} --analysis_software_version $version --reference_database_version $version_db --input_file_name !{sample} --output !{sample}_harmonize_resfinder.tsv

    cat <<-END_VERSIONS > versions.yml
    "!{task.process}":
        hamronization: $(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    '''
}
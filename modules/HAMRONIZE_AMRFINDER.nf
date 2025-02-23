process HAMRONIZE_AMRFINDER {
   label 'lowmemnk'
    container 'ebird013/hamronization:1.1.8'

    input:
        tuple val(sample), file(tsv), file(versions)

    output:
        tuple val(sample), path("./${sample}_harmonize_amrfinder.tsv"), emit: tsv
        path("./${sample}_harmonize_amrfinder.tsv"), emit: tsv_only
        path("versions.yml"), emit: versions

    shell:

    '''
    mv !{versions} metadata.yml
    version=$(grep 'amrfinder:' metadata.yml | awk -F' ' '{print $2}')
    version_db=$(grep 'amrfinder_db:' metadata.yml | awk -F' ' '{print $2}')

    sed "s/^Protein id/Protein identifier/" !{tsv} > reformatted_temp.tsv
    sed "s/\(^.*\)\bSubtype\b/\1Element subtype/" reformatted_temp.tsv > reformatted.tsv

    hamronize amrfinderplus reformatted.tsv --analysis_software_version $version --reference_database_version $version_db --input_file_name !{sample} --output !{sample}_harmonize_amrfinder.tsv

    cat <<-END_VERSIONS > versions.yml
    "!{task.process}":
        hamronization: $(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    '''
}
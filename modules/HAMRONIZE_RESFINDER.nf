process HAMRONIZE_RESFINDER {
   label 'lowmemnk'
    container 'ebird013/hamronization:1.1.8'

    input:
        tuple val(sample), file(json), file(versions)

    output:
        tuple val(sample), path("./${sample}_harmonize_resfinder.tsv"), emit: tsv
        path("./${sample}_harmonize_resfinder.tsv"), emit: tsv_only
        path("versions.yml"), emit: versions

    shell:

    '''
    mv !{versions} metadata.yml
    version=$(grep 'resfinder:' metadata.yml | awk -F' ' '{print $2}')
    version_db=$(grep 'resfinder_db:' metadata.yml | awk -F' ' '{print $2}')

    mv !{json} !{sample}.json

    hamronize resfinder !{sample}.json --output !{sample}_harmonize_resfinder.tsv

    cat <<-END_VERSIONS > versions.yml
    "!{task.process}":
        hamronization: $(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    '''
}
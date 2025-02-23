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

    sed "1s|^Protein id[[:space:]]\\+Contig id[[:space:]]\\+Start[[:space:]]\\+Stop[[:space:]]\\+Strand[[:space:]]\\+Element symbol[[:space:]]\\+Element name[[:space:]]\\+Scope[[:space:]]\\+Type[[:space:]]\\+Subtype[[:space:]]\\+Class[[:space:]]\\+Subclass[[:space:]]\\+Method[[:space:]]\\+Target length[[:space:]]\\+Reference sequence length[[:space:]]\\+% Coverage of reference[[:space:]]\\+% Identity to reference[[:space:]]\\+Alignment length[[:space:]]\\+Closest reference accession[[:space:]]\\+Closest reference name[[:space:]]\\+HMM accession[[:space:]]\\+HMM description$|Protein identifier\\tContig id\\tStart\\tStop\\tStrand\\tGene symbol\\tElement name\\tScope\\tType\\tElement subtype\\tClass\\tSubclass\\tMethod\\tTarget length\\tReference sequence length\\t% Coverage of reference\\t% Identity to reference\\tAlignment length\\tClosest reference accession\\tClosest reference name\\tHMM accession\\tHMM description|" !{tsv} > reformatted.tsvs

    hamronize amrfinderplus reformatted.tsv --analysis_software_version $version --reference_database_version $version_db --input_file_name !{sample} --output !{sample}_harmonize_amrfinder.tsv

    cat <<-END_VERSIONS > versions.yml
    "!{task.process}":
        hamronization: $(hamronize -v 2>&1 | sed -e "s/hamronize //g")
    END_VERSIONS  
    '''
}
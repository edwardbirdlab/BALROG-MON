process RESFINDER {
   label 'lowmemlong'
    container 'genomicepidemiology/resfinder:latest'

    input:
        tuple val(sample), file(fasta)
        path(db)

    output:
        path("./${sample}"), emit: resfinder_results
        path("Resfinder_geneseqs_${sample}.fsa"), emit: db_hits
        tuple val(sample), path("${sample}/*.json"), path("versions.yml"), emit: for_hamr
        path("versions.yml"), emit: versions

    script:

    """
    sed -i 's/Cephalotin/Cephalothin/g' ./${db}/phenotypes.txt
    python3 -m resfinder -o ./${sample} -l 0.6 -t 0.8 -ifa ${fasta} -acq -db_res ./${db}
    cp ./${sample}/ResFinder_Resistance_gene_seq.fsa Resfinder_geneseqs_${sample}.fsa
    cp ./${sample}/ResFinder_results_tab.txt ${sample}_resfinder_tab.txt

    cat <<-END_VERSIONS > versions.yml
    "${task.process}":
        resfinder: \$(python3 -m resfinder -v 2>&1)
        resfinder_db: \$(cat ${db}/VERSION)
    END_VERSIONS
    """
}
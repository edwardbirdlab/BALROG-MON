process BUSCO {
    label 'lowmem'
    container 'ebird013/busco:5.7.1'

    input:
        tuple val(sample), file(fasta)
        file(busco_db)

    output:
        path("./${sample}_busco"), emit: busco_results

    script:

    """
    busco -i ${fasta} -o ${sample}_busco -m genome --offline --download_path ${busco_db} --lineage_dataset ${params.busco_lineage}
    """
}
process RESFINDER {
   label 'lowmemlong'
    container 'ebird013/resfinder:4.4.2'
    publishDir "${params.project_name}/AMR_Annotation/resfinder", mode: 'copy', overwrite: false

    input:
        tuple val(sample), file(fasta)
        path(db)

    output:
        path("./${sample}"), emit: resfinder_results
        path("Resfinder_geneseqs_${sample}.fsa"), emit: db_hits

    script:

    """
    python3 -m resfinder -o ./${sample} -l 0.6 -t 0.8 -ifa ${fasta} -acq -db_res ./${db} -b /opt/ncbi-blast-2.15.0+/bin/blastn -k /opt/kma/kma
    cp ./${sample}/ResFinder_Resistance_gene_seq.fsa Resfinder_geneseqs_${sample}.fsa
    """
}
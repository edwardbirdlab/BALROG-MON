process CDHIT_MERGE {
    label 'lowmem'
    container 'ebird013/cdhit:4.8.1'
    publishDir "${params.project_name}/ARG_Database_Merge/cdhit_merge", mode: 'copy', overwrite: false

    input:
        tuple file(db_1), file(db_2), file(db_3), file(db_4), file(db_5)


    output:
        path("merged_db_${params.chdit_ident}.fasta"), emit: cdhit_db
        path("merged_db_${params.chdit_ident}.fasta.clstr"), emit: cdhit_cluster
        path('.command.out'), emit: cdhit_report



    
        
    script:

    """
    cat *.fasta > merged.fasta
    cd-hit-est -i merged.fasta -o merged_db_${params.chdit_ident}.fasta -c ${params.chdit_ident} -n ${params.chdit_word_size}
    """
}